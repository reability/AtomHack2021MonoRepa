

class Task:

	def __init__(self, db):
		self.db = db
		self.collection = self.db["TASKS"]

	async def create(self, task):
		result = self.collection.insert_one(task)
		return result

	async def get(self, task_id):
		result = await self.collection.find_one({"taskId": int(task_id)})
		return result

	async def delete(self, task_id):
		await self.collection.find_one_and_delete({"taskId": int(task_id)})

	async def get_completed(self, user_id):
		result = []
		documents = self.collection.find({"executor": int(user_id), "completed": False, "active": True})
		for document in await documents.to_list(length=1000):
			result.append(document)
		return result

	async def count_tasks(self, user_id):
		result = await self.collection.count_documents({"executor": int(user_id), "completed": False, "active": True})
		return result
