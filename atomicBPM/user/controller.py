from aiohttp import web
from user.model import User
from JSONEncoder import JSONEncoder
import uuid


class UserController(web.View):

    def __init__(self, request: web.Request) -> None:
        super(UserController, self).__init__(request)
        self.user = User(db=self.request.db)

    async def get(self) -> web.Response:
        data = self.request.query
        user_id = data["userId"]
        target = await self.user.get(user_id)
        return web.Response(content_type='application/json', text=JSONEncoder().encode(target))
