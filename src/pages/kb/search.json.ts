import { kbSearchData } from '../../data/kb';

export async function GET() {
  return new Response(JSON.stringify(kbSearchData), {
    status: 200,
    headers: {
      'Content-Type': 'application/json; charset=utf-8'
    }
  });
}
