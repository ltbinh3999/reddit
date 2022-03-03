import pool from "$lib/db"

export async function get({ request }) {
  const cookie = new URLSearchParams(request.headers).get('cookie')
  const token = new URLSearchParams(cookie).get('id')
  const ifTokenExist = `
  SELECT id
  FROM users
  WHERE token = $1
  `  
  const result = await pool.query(ifTokenExist, [token])
  if (result.rowCount===0){
    return {
      status: 302,
      headers:{
        'Location':`/signin`
      }
    }
  }
  return {
    status: 302,
    headers:{
      'Location':`/users/${result.rows[0].id}`
    }
  }
}