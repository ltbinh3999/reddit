import {Pool} from 'pg';
const pool = new Pool()
await pool.connect()
console.log("DATABASE CONNECT SUCESSFULLY");
export const db ={
  getAllPost : async () => {
    const result = await pool.query(`
    SELECT TITLE,
      CONTENT,
      ACCOUNT.NAME
    FROM POST
    INNER JOIN ACCOUNT ON POST.ACCOUNT_ID = ACCOUNT.ID
    LIMIT 5;
    `)
    console.log("GET ALL POST");
    return result.rows
  }

}

