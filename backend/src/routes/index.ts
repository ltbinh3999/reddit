export async function get({request}){
  const cookie = new URLSearchParams(request.headers).get('cookie')
  console.log(cookie);  
  return {
    status: 200
  }
  
}