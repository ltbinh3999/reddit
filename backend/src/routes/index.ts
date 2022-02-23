import type { RequestHandler } from '@sveltejs/kit';
import {Pool} from 'pg';

export const get: RequestHandler = async () => {
  const pool = new Pool()
  await pool.connect()
  const res = await pool.query('SELECT NOW()')
  console.log(res);
  await pool.end()
	return {
		body: {
			item: 'sample'
		}
	};
}

