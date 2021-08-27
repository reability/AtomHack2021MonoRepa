from aiohttp import web
import uuid
import time


class TaskController(web.View):

    async def post(self):
        self.db = self.request.db
        self.tasks = self.db["tasks"]
        self.processes = self.db["PROCESSES"]

        data = await self.request.json()

        try:
            type = data["type"]
        except:
            return web.Response(text="Error")

        # Assignment
        if type == 0:
            return await self.post_new_assignment(data)
        else:
            return web.Response(text="Error")

    async def get(self):
        data = self.request.query
        task_id = data["task"]
        task = await self.task.get(task_id=task_id)
        return task

    async def post_new_assignment(self, data):
        try:
            type = data["type"]
            title = data["title"]
            subtitle = data["subtitle"]
            soft_deadline = data["softDeadline"]
            hard_deadline = data["hardDeadline"]
        except:
            return web.Response(text="Error")
        task_id = str(uuid.uuid4())
        process_id = str(uuid.uuid4())

        print("task_id: ", task_id)
        print("process_id: ", process_id)

        result = await self.processes.insert_one({
            "processId": process_id,
            "author": 0,
            "start_date": time.time(),
            "current_task": task_id,
            "tasks": [],
            "competed": False
        })

        if result is None:
            return web.Response(text="Error")

        result = await self.tasks.insert_one({
            "task_id": task_id,
            "type": type,
            "title": title,
            "subtitle": subtitle,
            "created": time.time(),
            "softDeadline": soft_deadline,
            "hardDeadline": hard_deadline,
            "proccess": process_id,
            "super_task": None,
            "completed": False
        })

        if result is None:
            return web.Response(text="Error")

        result = await self.processes.find_one_and_update(
            {"processId": process_id},
            {"$push": {"tasks": task_id}}
        )

        if result is None:
            return web.Response(text="Error")
        else:
            return web.Response(text="Success")




