from task.controller import TaskController
from user.controller import UserController
from process.controller import ProcessController
from user_card.controller import UserCardController
from tasks_list.controller import TasksListController


routings = [
    ("*", "task", "/task", TaskController),
    ("*", "taskList", "/taskList", TasksListController),
    ("*", "user", "/user", UserController),
    ("*", "userCard", "/userCard", UserCardController),
    ("*", "process", "/process", ProcessController),
]
