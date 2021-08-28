from aiohttp import web
from motor import motor_asyncio as ma
import time

#from settings import MONGO_HOST, MONGO_DB_NAME, HOST, PORT
from routing import routings

from aiohttp.web import middleware

MONGO_HOST = "mongodb://localhost:27017"
MONGO_DBNAME = "BPM"
client = ma.AsyncIOMotorClient(MONGO_HOST)

db = client[MONGO_DBNAME]
collection_users = db["USERS"]
collections_tasks = db["TASKS"]

users = [
    {
        "userId": 1,
        "isDeputy": False,
        "avatar": "img1",
        "name": "Антон Мэров",
        "job": "Мэр",
        "departament": "Администрация",
        "email": "mer@sochi.ru",
        "phone": "89990001122",
        "superViser": None,
        "deputy": [2, 3],
        "subordinate": []
    },
    {
        "userId": 2,
        "isDeputy": True,
        "avatar": "img2",
        "name": "Василий Заммеров",
        "job": "Заместитель мэра",
        "departament": "Администрация",
        "email": "zam_mer1@sochi.ru",
        "phone": "89990001123",
        "superViser": 1,
        "deputy": [],
        "subordinate": [4]
    },
    {
        "userId": 3,
        "isDeputy": True,
        "avatar": "img2",
        "name": "Ольга Заммерова",
        "job": "Заместитель мэра",
        "departament": "Администрация",
        "email": "zam_mer2@sochi.ru",
        "phone": "89990001124",
        "superViser": 1,
        "deputy": [],
        "subordinate": [5]
    },
    {
        "userId": 4,
        "isDeputy": False,
        "avatar": "img2",
        "name": "Семен Департаментов",
        "job": "Начальник департамента",
        "departament": "Департамент строительства",
        "email": "headDepStroi@sochi.ru",
        "phone": "89990001125",
        "superViser": 2,
        "deputy": [6],
        "subordinate": [7]
    },
    {
        "userId": 6,
        "isDeputy": True,
        "avatar": "img2",
        "name": "Виктор Замепартаментов",
        "job": "Заместитель начальника департамента",
        "departament": "Департамент строительства",
        "email": "deputyDepStroi@sochi.ru",
        "phone": "89990041125",
        "superViser": 4,
        "deputy": [],
        "subordinate": [7]
    },
    {
        "userId": 7,
        "isDeputy": False,
        "avatar": "img2",
        "name": "Екатерина Отделначалова",
        "job": "Начальник отдела",
        "departament": "Отдел согласования строительства жилых помещений",
        "email": "headSoglOtdel@sochi.ru",
        "phone": "89990041125",
        "superViser": 4,
        "deputy": [8],
        "subordinate": [9]
    },
    {
        "userId": 8,
        "isDeputy": True,
        "avatar": "img2",
        "name": "Петр Замотделначалов",
        "job": "Заместитель начальника отдела",
        "departament": "Отдел согласования строительства жилых помещений",
        "email": "deputySoglOtdel@sochi.ru",
        "phone": "89190041125",
        "superViser": 7,
        "deputy": [],
        "subordinate": [9]
    },
    {
        "userId": 9,
        "isDeputy": False,
        "avatar": "img2",
        "name": "Сергей Исполнительный",
        "job": "Главный специалист-эксперт",
        "departament": "Отдел согласования строительства жилых помещений",
        "email": "workerSoglOtdel@sochi.ru",
        "phone": "89194041125",
        "superViser": 7,
        "deputy": [],
        "subordinate": []
    },
    {
        "userId": 5,
        "isDeputy": False,
        "avatar": "img2",
        "name": "Анна Департаментовка",
        "job": "Начальник департамента",
        "departament": "Департамент городской инфраструктуры",
        "email": "headDepInfra@sochi.ru",
        "phone": "89990001126",
        "superViser": 3,
        "deputy": [10],
        "subordinate": [11]
    },
    {
        "userId": 10,
        "isDeputy": True,
        "avatar": "img2",
        "name": "Петр Замепартаментов",
        "job": "Заместитель начальника департамента",
        "departament": "Департамент городской инфраструктуры",
        "email": "deputyepInfra@sochi.ru",
        "phone": "89990041125",
        "superViser": 5,
        "deputy": [],
        "subordinate": [11]
    },
    {
        "userId": 11,
        "isDeputy": False,
        "avatar": "img2",
        "name": "Владимир Отделначаловый",
        "job": "Начальник отдела",
        "departament": "Отдел ЖКХ",
        "email": "headZhKH@sochi.ru",
        "phone": "81990041125",
        "superViser": 5,
        "deputy": [12],
        "subordinate": [13]
    },
    {
        "userId": 12,
        "isDeputy": True,
        "avatar": "img2",
        "name": "Елена Замотделова",
        "job": "Заместитель начальника отдела",
        "departament": "Отдел ЖКХ",
        "email": "deputyZhKH@sochi.ru",
        "phone": "89190041125",
        "superViser": 11,
        "deputy": [],
        "subordinate": [13]
    },
    {
        "userId": 13,
        "isDeputy": False,
        "avatar": "img2",
        "name": "Василиса Умница",
        "job": "Главный специалист-эксперт",
        "departament": "Отдел ЖКХ",
        "email": "workerZhKH@sochi.ru",
        "phone": "89194041125",
        "superViser": 11,
        "deputy": [],
        "subordinate": []
    }
]
tasks = [
    {
        "taskId": 1,
        "type": 0,
        "title": "task1",
        "subtitle": "important_task",
        "created": time.time(),
        "softDeadline": "01.09.2021",
        "hardDeadline": "31.08.2021.",
        "process": 1,
        "superTask": None,
        "completed": True,
        "executor": 9,
        "watcher": 7
    },
{
        "taskId": 2,
        "type": 0,
        "title": "task1",
        "subtitle": "important_task",
        "created": time.time(),
        "softDeadline": "01.09.2021",
        "hardDeadline": "31.08.2021.",
        "process": 1,
        "superTask": None,
        "completed": False,
        "executor": 2,
        "watcher": 1
    },
{
        "taskId": 3,
        "type": 0,
        "title": "task1",
        "subtitle": "important_task",
        "created": time.time(),
        "softDeadline": "01.09.2021",
        "hardDeadline": "31.08.2021.",
        "process": 1,
        "superTask": None,
        "completed": False,
        "executor": 3,
        "watcher": 1
    },
{
        "taskId": 4,
        "type": 0,
        "title": "task1",
        "subtitle": "important_task",
        "created": time.time(),
        "softDeadline": "01.09.2021",
        "hardDeadline": "31.08.2021.",
        "process": 1,
        "superTask": None,
        "completed": False,
        "executor": 4,
        "watcher": 2
    },
{
        "taskId": 5,
        "type": 0,
        "title": "task1",
        "subtitle": "important_task",
        "created": time.time(),
        "softDeadline": "01.09.2021",
        "hardDeadline": "31.08.2021.",
        "process": 1,
        "superTask": None,
        "completed": False,
        "executor": 5,
        "watcher": 3
    },
{
        "taskId": 6,
        "type": 0,
        "title": "task1",
        "subtitle": "important_task",
        "created": time.time(),
        "softDeadline": "01.09.2021",
        "hardDeadline": "31.08.2021.",
        "process": 1,
        "superTask": None,
        "completed": False,
        "executor": 6,
        "watcher": 4
    },
{
        "taskId": 7,
        "type": 0,
        "title": "task1",
        "subtitle": "important_task",
        "created": time.time(),
        "softDeadline": "01.09.2021",
        "hardDeadline": "31.08.2021.",
        "process": 1,
        "superTask": None,
        "completed": False,
        "executor": 7,
        "watcher": 4
    },
{
        "taskId": 8,
        "type": 0,
        "title": "task1",
        "subtitle": "important_task",
        "created": time.time(),
        "softDeadline": "01.09.2021",
        "hardDeadline": "31.08.2021.",
        "process": 1,
        "superTask": None,
        "completed": False,
        "executor": 8,
        "watcher": 7
    },
{
        "taskId": 9,
        "type": 0,
        "title": "task1",
        "subtitle": "important_task",
        "created": time.time(),
        "softDeadline": "01.09.2021",
        "hardDeadline": "31.08.2021.",
        "process": 1,
        "superTask": None,
        "completed": False,
        "executor": 9,
        "watcher": 7
    },{
        "taskId": 10,
        "type": 0,
        "title": "task1",
        "subtitle": "important_task",
        "created": time.time(),
        "softDeadline": "01.09.2021",
        "hardDeadline": "31.08.2021.",
        "process": 1,
        "superTask": None,
        "completed": False,
        "executor": 10,
        "watcher": 5
    },
{
        "taskId": 11,
        "type": 0,
        "title": "task1",
        "subtitle": "important_task",
        "created": time.time(),
        "softDeadline": "01.09.2021",
        "hardDeadline": "31.08.2021.",
        "process": 1,
        "superTask": None,
        "completed": False,
        "executor": 11,
        "watcher": 5
    },
{
        "taskId": 12,
        "type": 0,
        "title": "task1",
        "subtitle": "important_task",
        "created": time.time(),
        "softDeadline": "01.09.2021",
        "hardDeadline": "31.08.2021.",
        "process": 1,
        "superTask": None,
        "completed": False,
        "executor": 12,
        "watcher": 11
    },
{
        "taskId": 13,
        "type": 0,
        "title": "task1",
        "subtitle": "important_task",
        "created": time.time(),
        "softDeadline": "01.09.2021",
        "hardDeadline": "31.08.2021.",
        "process": 1,
        "superTask": None,
        "completed": False,
        "executor": 13,
        "watcher": 11
    },
{
        "taskId": 14,
        "type": 0,
        "title": "task1",
        "subtitle": "important_task",
        "created": time.time(),
        "softDeadline": "01.09.2021",
        "hardDeadline": "31.08.2021.",
        "process": 1,
        "superTask": None,
        "completed": False,
        "executor": 9,
        "watcher": 7
    },
]

# for document in tasks:
#     print("here")
#     result = collections_tasks.insert_one(document)
#     print("gere")