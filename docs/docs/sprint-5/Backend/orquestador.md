---
title: Orquestrador
sidebar_position: 1
---

# Kubernetes

Kubernetes é uma plataforma de código aberto para automação da implantação, escalonamento e operações de contêineres de aplicativos em clusters de hosts. Originalmente desenvolvido pelo Google, o Kubernetes agora é mantido pela Cloud Native Computing Foundation (CNCF).

## Principais Componentes do Kubernetes

1. **Pods:** A menor e mais simples unidade do Kubernetes, que pode conter um ou mais contêineres.

2. **Deployments:** Controladores que gerenciam a criação e atualização de pods e ReplicaSets.

3. **Services:** Abstrações que definem um conjunto lógico de pods e uma política de acesso.

4. **ConfigMaps e Secrets:** Ferramentas para gerenciar dados de configuração e informações sensíveis de maneira segura.

Kubernetes oferece uma infraestrutura robusta para o desenvolvimento de aplicativos escaláveis e resilientes, facilitando a gestão de cargas de trabalho em ambientes de produção.

# Configuração do Kubernetes do Projeto

Para a configuração foi feito a criação e exposição de um deployment e um serviço utilizando Minikube e kubectl.

## Pré-requisitos

- Minikube instalado.
- Kubectl instalado.
- Docker instalado e configurado.
- Acesso ao repositório do projeto no GitHub.

# Passos para Execução

**1. Iniciar Minikube**

Para iniciar o Minikube, abra um terminal e execute o seguinte comando no diretório do backend do projeto:

``minikube start``

**2. Abrir o Dashboard do Minikube**

Para visualizar e gerenciar os recursos do Kubernetes, abra o dashboard do Minikube com o comando abaixo:

``minikube dashboard``

Deixe o terminal aberto com o dashboard rodando.

**3. Criar o Deployment**

Em outro terminal, navegue até o diretório do módulo 10 do projeto e crie o deployment para o backend utilizando a imagem Docker ``patriciahonorato/backend-g2:``

``kubectl create deployment backend-g2 --image=patriciahonorato/backend-g2``

A resposta esperada será:

``deployment.apps/backend-g2 created``

**4. Expor o Deployment como um Serviço**

Exponha o deployment criado como um serviço do tipo NodePort, mapeando a porta 3000:

``kubectl expose deployment backend-g2 --type=NodePort --port=3000``

A resposta esperada será:

``service/backend-g2 exposed``

**5. Configurar o Port Forwarding**

Para acessar o serviço localmente, configure o port forwarding da porta 3000 do serviço para a porta 3000 local:

``kubectl port-forward service/backend-g2 3000:3000``

A resposta esperada será:

``Forwarding from 127.0.0.1:3000 -> 3000``

``Forwarding from [::1]:3000 -> 3000``

``Handling connection for 3000``

``Handling connection for 3000``

Com o port forwarding configurado, o backend estará acessível via ``localhost:3000`` Note que o terminal deve permanecer aberto para manter a conexão.

# Exportação e Importação de Configurações do Kubernetes

Para exportar as configurações do deployment e do serviço criados, foram utilizados os seguintes comandos:

``kubectl get deployments -o yaml > deployments.yaml``

``kubectl get services -o yaml > services.yaml``

Estes arquivos podem ser usados para recriar os recursos em outro cluster Kubernetes. Para importar as configurações em outro cluster, utilize:

``kubectl apply -f deployments.yaml``

``kubectl apply -f services.yaml``

# Demonstração do Kubernetes em funcionamento

O vídeo a seguir apresenta a demonstração do sistema criado:

[![Veja o vídeo no youtube!](http://i3.ytimg.com/vi/zD_euLGPtkU/hqdefault.jpg)](https://youtu.be/zD_euLGPtkU)