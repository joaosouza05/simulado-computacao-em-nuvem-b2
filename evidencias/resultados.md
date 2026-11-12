# Evidências do Simulado de Computação em Nuvem

## 1. Configuração inicial
- Namespace `simulado-nuvem` criado com sucesso.
- ConfigMap `pagina` versão 1 criado.
- Secret `senha-app` criado.

## 2. Controle de acesso RBAC
- ServiceAccount `leitor-web` criado.
- Role `leitura-pods` criada.
- RoleBinding configurado.
- Permissão para listar Pods: **yes**.
- Permissão para excluir Pods: **no**.

## 3. Aplicação Web
- Deployment `web` criado com 2 réplicas.
- Imagem utilizada: `nginx:alpine`.
- Service `web` criado como ClusterIP.
- ConfigMap e Secret integrados à aplicação.
- Readiness Probe e Liveness Probe configuradas.

## 4. Teste de acesso
Resultado obtido:

```text
<h1>Simulado Cloud - Versao 1</h1>
```

## 5. Escalabilidade e recuperação
- Deployment escalado de 2 para 3 réplicas.
- Deployment retornou para 2 réplicas.
- Um Pod foi excluído manualmente.
- Kubernetes criou outro Pod automaticamente.

## 6. Atualização da aplicação
- ConfigMap atualizado para a versão 2.
- Deployment reiniciado.
- Aplicação apresentou a nova versão.

Resultado:

```text
<h1>Simulado Cloud - Versao 2</h1>
```

## 7. Simulação de falha e rollback
- Imagem inválida configurada para simular uma falha.
- Pod apresentou `ErrImagePull` e `ImagePullBackOff`.
- Rollback executado com sucesso.
- Deployment voltou a utilizar `nginx:alpine`.
- ConfigMap permaneceu na versão 2.

## 8. CronJob
- CronJob `verifica-web` criado.
- Job `teste-web` executado com sucesso.
- Resultado dos logs:

```text
<h1>Simulado Cloud - Versao 2</h1>
```

## Conclusão

A atividade permitiu praticar a criação e configuração de recursos do Kubernetes, controle de acesso, escalabilidade, atualização de aplicações, recuperação de falhas e execução de tarefas automatizadas.

