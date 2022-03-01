import { Pool } from 'pg';
const pool = new Pool()
await pool.connect()

export const db = {
  getAllPost: async () => {
    const result = await pool.query(`
    SELECT title,
      content,
      users.username
    FROM posts
    INNER JOIN users ON posts.user_id = users.id;
    `)
    return result.rows
  },

  getUserById: async (id) => {
    const query = "SELECT username, password FROM users WHERE id = $1"
    const params = [id]
    const result = await pool.query(query, params)
    return result.rows
  },
  login: async (username, password) => {
    const query = "SELECT id FROM user WHRERE username = $1 AND "

  }
}

