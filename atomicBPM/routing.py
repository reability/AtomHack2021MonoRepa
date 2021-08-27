from task.controller import TaskController
from user.controller import UserController
from process.controller import ProcessController

routings = [
    ("*", "task", "/task", TaskController),
    ("*", "user", "/user", UserController),
    ("*", "process", "/process", ProcessController),
]
