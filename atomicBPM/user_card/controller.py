from typing import List

from aiohttp import web

from user.model import User
from task.model import Task
from JSONEncoder import JSONEncoder


class UserCardController(web.View):

	def __init__(self, request: web.Request) -> None:
		super(UserCardController, self).__init__(request)
		self.user = User(db=self.request.db)
		self.tasks = Task(db=self.request.db)

	async def _get_employee(self, employees) -> List:
		all_employee = []
		for employee_id in employees:
			employee = await self.user.get(employee_id)
			if employee:
				active_tasks = await self.tasks.count_tasks(employee_id)
				employee['activeTasks'] = active_tasks
				all_employee.append(employee)
		return all_employee

	async def get(self) -> web.Response:
		data = self.request.query
		user_id = data["userId"]

		target_user = await self.user.get(user_id)
		target_user["activeTasks"] =  await self.tasks.count_tasks(user_id)

		user_deputy = target_user.get('deputy')
		user_subordinates = target_user.get('subordinate')

		all_deputy = await self._get_employee(user_deputy)
		all_subordinates = await self._get_employee(user_subordinates)

		target = {
			"user": target_user,
			"deputyAndSubordinates": {
				"deputy": all_deputy,
				"subordinates": all_subordinates
			}
		}

		return web.Response(content_type='application/json', text=JSONEncoder().encode(target))
