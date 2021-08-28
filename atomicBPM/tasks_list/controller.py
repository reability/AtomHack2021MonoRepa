from aiohttp import web

from task.model import Task
from JSONEncoder import JSONEncoder


class TasksListController(web.View):

	def __init__(self, request: web.Request) -> None:
		super(TasksListController, self).__init__(request)
		self.tasks = Task(db=self.request.db)

	async def get(self) -> web.Response:
		data = self.request.query
		user_id = data["userId"]

		completed_tasks = await self.tasks.get_completed(user_id)
		target = {
			"tasks": completed_tasks
		}
		return web.Response(content_type='application/json', text=JSONEncoder().encode(target))