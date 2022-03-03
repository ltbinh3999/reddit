import pool from "$lib/db";

export async function get({request,params}){
  const cookie = new URLSearchParams(request.headers).get('cookie')
  const token = new URLSearchParams(cookie).get('id')  
  const ifTokenExist = `
  SELECT id, username, token
  FROM users
  WHERE id = $1
  `  
  const result = await pool.query(ifTokenExist, [params.id])  
  if (result.rowCount === 1 && token === result.rows[0].token){
    return {
      status: 200,
      body: {username: result.rows[0].username}
    }
  }

  
}