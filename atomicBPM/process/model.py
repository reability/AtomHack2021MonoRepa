

class Process:

    def __init__(self, db):
        self.db = db
        self.collection = self.db["PROCESSES"]

    async def get(self, process_id):
        print(process_id)
        result = await self.collection.find_one({"processId": process_id})
        return result
