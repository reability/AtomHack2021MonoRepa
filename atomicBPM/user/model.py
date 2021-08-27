

class User:

    def __init__(self, db):
        self.db = db
        self.collection = self.db["USERS"]

    async def create(self, user):
        result = self.collection.insert_one(user)
        return result

    async def get(self, user_id):
        result = await self.collection.find_one({"userId": int(user_id)})
        return result
