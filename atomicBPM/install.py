from aiohttp import web
from motor import motor_asyncio as ma

#from settings import MONGO_HOST, MONGO_DB_NAME, HOST, PORT
from routing import routings

from aiohttp.web import middleware

MONGO_HOST = "mongodb://localhost:27017"
MONGO_DBNAME = "BPM"
client = ma.AsyncIOMotorClient(MONGO_HOST)

db = client[MONGO_DBNAME]
collection = db["USERS"]

documents = [
    {
        "userId": 1,
        "avatar": "img1",
        "name": "Олег Давыдов",
        "job": "Председаль городского совета",
        "departament": "Правительство",
        "email": "andrey@obninskDesk.ru",
        "superViser": None,
        "zemestitel": 2
    },
]
for document in documents:
    print("here")
    result = collection.insert_one(document)
    print("gere")