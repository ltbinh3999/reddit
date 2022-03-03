import pool from "$lib/db"
import { scrypt } from 'crypto'
import { promisify } from 'util'
import jwt from 'jsonwebtoken'
import { serialize } from 'cookie';

export async function post({ request }) {
  const {username,password} = Object.fromEntries(new URLSearchParams(await request.text()))
  if (username.length === 0) {     
    return { status: 400, body: { message: "Username must not be empty" }}
  }
  if (password.length === 0) { 
    return { status: 400, body: { message: "Password must not be empty" }}
  }
  const getUserByUserName = `
  SELECT *
  FROM users
  WHERE username=$1`
  const result = await pool.query(getUserByUserName,[username])
  if (result.rowCount === 0) {
     return { status: 400, body: { message: "No username" }}
  }
  const {id,password:hPassword,salt} = result.rows[0]
  const inputHashedPassword = (await promisify(scrypt)(password, salt, 64) as Buffer).toString('hex')
  if (inputHashedPassword !== hPassword) { 
    return { status: 400, body: { message: "Wrong credential" }}
  }
  
  const token = jwt.sign({id}, process.env.JWT_SECRET_KEY, {expiresIn: "1d"})
  const addToken=`
  UPDATE users
  SET token =$1
  WHERE username =$2
  `
  await pool.query(addToken, [token, username])

  return {status:302, headers: {
    'Set-Cookie': serialize('id', token, {
        path: '/',
        httpOnly: true,
        sameSite: 'strict',
        secure: process.env.NODE_ENV === 'production',
        maxAge: 60 * 60 * 24 * 7, // one week
    }),
}}
}