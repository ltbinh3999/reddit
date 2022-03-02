import { signup } from "$lib/users";

export async function post({ request }) {
  const data = new URLSearchParams(await request.text())
  const { error, userId } = await signup(data.get('username'), data.get('password'))
  if (error) {
    return {
      status: 400,
      body: { error }
    }
  }
  return {
    status: 201,
    body: { userId }
  }
}
//TODO: refactor this like signin.ts