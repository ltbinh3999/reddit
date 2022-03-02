import { randomBytes, scrypt } from 'crypto'
import { promisify } from 'util';
import pool from './db';

export const signup = async (username: string, password: string):
  Promise<{ error?: 'EMPTY_USERNAME' | 'EMPTY_PASSWORD' | 'DUPLICATE_USERNAME', userId?: string }> => {
  if (username.length === 0) {
    return { error: 'EMPTY_USERNAME' }
  }
  if (password.length === 0) {
    return { error: 'EMPTY_PASSWORD' }
  }

  const addUser = `
  INSERT INTO users(username, password, salt) 
  VALUES ($1,$2,$3) 
  RETURNING id`
  const salt = randomBytes(16).toString('hex')
  const hPassword = (await promisify(scrypt)(password, salt, 64) as Buffer).toString('hex')
  try {
    const result = await pool.query(addUser, [username, hPassword, salt])
    return { userId: result.rows[0] as string }
  } catch (error) {
    if (error.code === '23505') {
      return { error: 'DUPLICATE_USERNAME' }
    }
  }
}
