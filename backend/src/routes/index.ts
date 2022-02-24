import type { RequestHandler } from '@sveltejs/kit';
import { db } from '$lib/db';

export const get: RequestHandler = async () => {
  const result = await db.getAllPost()
	return {
		body: {
      posts: result
		}
	};
}

