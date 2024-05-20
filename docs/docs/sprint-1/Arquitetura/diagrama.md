---
title: Arquitetura da solução 
sidebar_position: 1
---

# Arquitetura da solução 

![arquitetura](../../../static/img/sprint-1/arquitetura.png)

A arquitetura do projeto de software foi projetada para fornecer uma experiência robusta e escalável. Para o frontend do sistema está o Flutter, uma tecnologia multiplataforma que possibilita o desenvolvimento do aplicativo móvel. Este aplicativo será a face do produto, oferecendo uma interface intuitiva e responsiva para os usuários. Por trás do painel de controle para o administrador, será implementado o Metabase, uma poderosa ferramenta de análise e visualização de dados, proporcionando aos administradores uma visão abrangente do desempenho do sistema. O backend será construído em Python, garantindo uma base sólida e flexível para o gerenciamento de dados e lógica de negócios. O banco de dados PostgreSQL será utilizado para armazenar e manipular os dados de forma eficiente e confiável. Para as comunicações assíncronas e distribuídas entre os diversos componentes do sistema, será empregado o Kafka, assegurando uma integração fluida e uma resposta ágil às demandas do aplicativo.