from typing import Dict
import uuid
import time

from aiohttp import web

from JSONEncoder import JSONEncoder


class TaskController(web.View):

    def __init__(self, request: web.Request) -> None:
        super(TaskController, self).__init__(request)
        self.db = self.request.db
        self.tasks = self.db["TASKS"]
        self.processes = self.db["PROCESSES"]

    async def post(self) -> web.Response:
        data = await self.request.json()

        try:
            type = data["type"]
            redirect = data.pop("redirect")
        except Exception as e:
            return web.Response(text=f"Error = {e}")

        if type == 0 and redirect:
            self.tasks.find_one_and_update({"taskId": data["taskId"]})
            return web.Response(text='Success')
        elif type == 0 and not redirect:
            # Assignment
            return await self.post_new_assignment(data)
        else:
            return web.Response(text="Error while creating task!")

    async def get(self):
        data = self.request.query
        task_id = data["taskId"]
        target = await self.tasks.find_one({"taskId": task_id})
        return web.Response(content_type='application/json', text=JSONEncoder().encode(target))

    async def post_new_assignment(self, data: Dict) -> web.Response:
        try:
            type = data["type"]
            title = data["title"]
            subtitle = data["subtitle"]
            soft_deadline = data["softDeadline"]
            hard_deadline = data["hardDeadline"]
            executor = data["executor"]
            watcher = data["watcher"]
        except Exception as e:
            return web.Response(text=f"Error = {e}")

        task_id = str(uuid.uuid4())
        process_id = str(uuid.uuid4())

        print("task id: ", task_id)
        print("process id: ", process_id)

        result = await self.processes.insert_one({
            "processId": process_id,
            "author": 0,
            "startDate": time.time(),
            "currentTask": task_id,
            "tasks": [],
            "competed": False
        })

        if result is None:
            return web.Response(text="Error while inserting process to db!")

        result = await self.tasks.insert_one({
            "taskId": task_id,
            "type": type,
            "title": title,
            "subtitle": subtitle,
            "created": time.time(),
            "softDeadline": soft_deadline,
            "hardDeadline": hard_deadline,
            "process": process_id,
            "superTask": None,
            "completed": False,
            "executor": executor,
            "watcher": watcher
        })

        if result is None:
            return web.Response(text="Error while inserting task to db!")

        result = await self.processes.find_one_and_update(
            {"processId": process_id},
            {"$push": {"tasks": task_id}}
        )

        if result is None:
            return web.Response(text=f"Error while attaching task {task_id} to process {process_id}!")
        else:
            return web.Response(text="Success")
