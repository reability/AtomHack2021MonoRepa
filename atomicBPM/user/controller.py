from aiohttp import web
from user.model import User
from JSONEncoder import JSONEncoder
import uuid


class UserController(web.View):

    async def get(self):
        user = User(db=self.request.db)

        data = self.request.query
        user_id = data["user"]
        target = await user.get(user_id)
        return web.Response(content_type='application/json', text=JSONEncoder().encode(target))
