from locust import HttpUser, task, between


class WebsiteUser(HttpUser):
    wait_time = between(1, 5)

    @task
    def criar_usuario(self):
        data = {
            "medicationId": "string",
            "sender_userId": "string",
            "status": "string"
        }

        self.client.post("/order/new", json=data,
                         name='adiciona um pedido na fila')
