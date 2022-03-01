import {Pool} from 'pg';
const pool = new Pool()
await pool.connect()
export const db ={
  getAllPost : async () => {
    const result = await pool.query(`
    SELECT title,
      content,
      users.username
    FROM posts
    INNER JOIN users ON posts.user_id = users.id;
    `)
    console.log(result.rows)
    return result.rows
    
  }
}

