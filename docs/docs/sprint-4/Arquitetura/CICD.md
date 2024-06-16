---
title: CI/CD
sidebar_position: 3
---

Uma pipeline CI/CD é o que permite que os serviços sejam executados automaticamente quando alguma implementação é finalizada. No caso do nosso projeto, vários serviços são deployados de acordo com o código na branch main. Utilizamos a separação de `desenvolvimento`, `homologação` e `produção` para um desenvolvimento mais seguro separado da aplicação viva e disponível para todos. Isso é permitido por conta do sistema avançado de versionamento do próprio github, que garante o desenvolvimento em branchs e, por meio de pull's, podemos juntar os códigos de maneira segura.

## Desenvolvimento

Primeiro, quando criamos alguma implementação, colocamos essa implementação na branch de desenvolvimento, a `dev`. Aqui, todos os códigos são testados para garantir que o deploy da aplicação não quebre com as novas implementações.

## Homologação

Quando as novas implementações não quebram as diferentes partes da pipeline de deploy da aplicação, levamos ela para a homologação, onde ocorrem diversos testes de carga e acesso automatizados, garantindo que, quando o código chegue em `produção`, as aplicações com as novas implementações não quebrem de alguma forma.

## Produção

Por fim, uma nova versão da aplicação como um todo é lançada e os serviços que a utilizam podem desfrutar das novas implementações ou correções de bugs.

## Contexto do nosso projeto

No que tange o contexto do nosso projeto, temos uma pipeline que sobe toda a nossa documentação que está presente no diretório `\docs` pelo Github Actions. Em todos os `pull requests` que levam para a branch `dev` essa pipeline é testada para garantir que a pipeline quebre em produção. Por fim, quando tudo está certo, levamos as novas atualizações para a branch `main`, que inicia a pipeline que garante o deploy final da documentação no Github Pages.