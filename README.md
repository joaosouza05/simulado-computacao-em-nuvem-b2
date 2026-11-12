# simulado-computacao-em-nuvem-b2

1. Qual é a diferença entre Container, Pod e Deployment?

O Container é onde a aplicação é executada, contendo a imagem e os recursos necessários para funcionar. O Pod é a menor unidade do Kubernetes e pode conter um ou mais containers. Já o Deployment é responsável por controlar os Pods, mantendo a quantidade de réplicas configurada e substituindo aqueles que apresentam problemas ou são excluídos.

2. Qual é a diferença entre ConfigMap e Secret?

O ConfigMap é utilizado para armazenar configurações que não são sigilosas, como arquivos e informações da aplicação. O Secret é utilizado para armazenar informações confidenciais, como senhas, tokens e credenciais. Nesta atividade, utilizei o ConfigMap para armazenar a página HTML e o Secret para guardar um token fictício.

3. Qual é a diferença entre Readiness Probe e Liveness Probe?

A Readiness Probe verifica se a aplicação está pronta para receber requisições. Caso não esteja pronta, o Pod deixa de receber tráfego pelo Service. A Liveness Probe verifica se a aplicação continua funcionando corretamente. Caso identifique uma falha, o Kubernetes pode reiniciar o container.

4. O que acontece quando um Pod é excluído manualmente?

Quando um Pod gerenciado por um Deployment é excluído manualmente, o Kubernetes identifica que a quantidade de réplicas está abaixo do valor configurado e cria outro Pod para substituir o excluído. Durante a atividade, excluí um dos Pods e confirmei que outro foi criado automaticamente.

5. Como funciona o rollback e a página voltou para a Versão 1?

O rollback permite retornar uma versão anterior da configuração de um Deployment. Durante a atividade, simulei uma falha alterando a imagem do Nginx para uma imagem inexistente. Depois, executei o comando de rollback e o Deployment voltou a utilizar a imagem nginx:alpine.

A página não voltou para a Versão 1, pois o rollback recuperou a configuração anterior do Deployment, mas não desfez a alteração do ConfigMap. Por isso, a página continuou apresentando a Versão 2.

6. Qual é a diferença entre Deployment, Job e CronJob?

O Deployment é utilizado para manter aplicações em execução, controlando a quantidade de Pods e substituindo aqueles que apresentam falhas. O Job executa uma tarefa até que ela seja concluída com sucesso. Já o CronJob permite executar tarefas automaticamente em horários ou intervalos programados. Nesta atividade, utilizei um CronJob para verificar o acesso à página web a cada cinco minutos.
