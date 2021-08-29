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
        params = self.request.query

        try:
            type = data["type"]
            action = params.get("action")
        except Exception as e:
            return web.Response(text=f"Error = {e}")

        # Redirect
        if action == 'redirect':
            try:
                self.tasks.find_one_and_update(
                    {"taskId": data["taskId"]},
                    {"$set": {"executor": data["executor"]}}
                )
                return web.Response(text='Success')
            except Exception as e:
                return web.Response(text=f'Error - {e}')
        # Decline
        elif action == 'decline':
            try:
                self.tasks.find_one_and_update(
                    {"taskId": data["taskId"]},
                    {"$set": {"active": False}}
                )
                return web.Response(text='Success')
            except Exception as e:
                return web.Response(text=f'Error - {e}')
        # Assignment
        elif type == 0:
            return await self.post_new_assignment(data)
        # Error
        else:
            return web.Response(text="Error! Wrong type or redirect/decline field is missing!")

    async def get(self):
        data = self.request.query
        task_id = data["taskId"]
        target = await self.tasks.find_one({"taskId": int(task_id)})
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
            "completed": False
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

    async def delete(self):
        data = self.request.query
        task_id = data["taskId"]
        self.tasks.find_one_and_delete({"taskId": task_id})
        return web.Response(text='Success')

    async def put(self):
        len = await self.tasks.count_documents({"superTask": None})
        len = JSONEncoder().encode(len)
        for i in range(1, int(len) + 1):
            self.tasks.find_one_and_update(
                {"taskId": i},
                {"$set": {"active": True}}
            )
        return web.Response(text='success')