import json
from schemas.consumer import Command
from controllers.order import (
    controller_create_order,
    controller_accept_order,
    controller_done_order,
    controller_cancel_order,
)


def callback(ch, method, properties, body):
    payload = json.loads(body)

    command = payload.get("command")

    data = payload.get("data")
    match command:
        case Command.create:
            controller_create_order(data)
            # controller_notify_app
            # controller_log
        case Command.accept:
            controller_accept_order(data)
        case Command.reject:
            pass
        case Command.done:
            controller_done_order(data)
        case Command.cancel:
            controller_cancel_order(data)
