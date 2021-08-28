# AtomHack2021MonoRepa

## SERVER
### GET urls examples:
/user?userId=1
/process?processId=1
/task?taskId=1

### Task example
'''
  {
    "taskId": task_id,
    "type": type,
    "title": title,
    "subtitle": subtitle,
    "created": time.time(),
    "softDeadline": soft_deadline,
    "hardDeadline": hard_deadline,
    "process": process_id,
    "superTask": None,
    "completed": False
  }
'''
### Process example
  {
    "processId": process_id,
    "author": 0,
    "startDate": time.time(),
    "currentTask": task_id,
    "tasks": [],
    "competed": False
  }
