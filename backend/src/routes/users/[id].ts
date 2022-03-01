import { db } from '$lib/db';

export async function get({ params }) {
  const result = db.getUserById(params.id)
  return {
    body: {
      user: result
    }
  }
}