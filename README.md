# AtomHack2021MonoRepa

## SERVER
### GET urls examples:

  ```
  /user?userId=1
  /process?processId=1
  /task?taskId=1
  /userCard?userId=1
  /taskList?userId=1
  ```

### Task example:

  ```
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
  }
  ```
  
### Process example:

  ```
  {
    "processId": process_id,
    "author": 0,
    "startDate": time.time(),
    "currentTask": task_id,
    "tasks": [],
    "competed": False
  }
  ```
  
### User example:

  ```
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
  }
  ```
