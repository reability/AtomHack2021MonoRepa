from aiohttp import web
from process.model import Process
from JSONEncoder import JSONEncoder
import uuid


class ProcessController(web.View):
    async def get(self) -> web.Response:
        process = Process(db=self.request.db)

        data = self.request.query
        process_id = data["processId"]
        target = await process.get(process_id)
        return web.Response(content_type='application/json', text=JSONEncoder().encode(target))