
#!/bin/bash

# 1. Conferir os nós do cluster
kubectl get nodes

# 2. Criar namespace
kubectl create namespace simulado-nuvem

# 3. Criar ConfigMap versão 1
kubectl apply -f manifests/01-configmap-v1.yaml

# 4. Criar Secret
kubectl -n simulado-nuvem create secret generic senha-app \
  --from-literal=token=valor-ficticio-2026

# 5. Criar RBAC
kubectl apply -f manifests/03-rbac.yaml

# 6. Conferir permissões
kubectl auth can-i list pods -n simulado-nuvem \
  --as=system:serviceaccount:simulado-nuvem:leitor-web

kubectl auth can-i delete pods -n simulado-nuvem \
  --as=system:serviceaccount:simulado-nuvem:leitor-web

# 7. Criar Deployment e Service
kubectl apply -f manifests/04-web.yaml

# 8. Criar cliente para testar a aplicação
kubectl -n simulado-nuvem run cliente \
  --image=busybox:1.36 --restart=Never --command -- sleep 3600

kubectl -n simulado-nuvem wait --for=condition=Ready pod/cliente --timeout=120s

# 9. Testar acesso
kubectl -n simulado-nuvem exec cliente -- wget -qO- http://web

# 10. Conferir Deployment, eventos e logs
kubectl -n simulado-nuvem describe deployment web
kubectl -n simulado-nuvem get events --sort-by=.lastTimestamp
kubectl -n simulado-nuvem logs deployment/web

# 11. Escalar aplicação
kubectl -n simulado-nuvem scale deployment web --replicas=3
kubectl -n simulado-nuvem get pods

kubectl -n simulado-nuvem scale deployment web --replicas=2
kubectl -n simulado-nuvem get pods

# 12. Atualizar ConfigMap para versão 2
kubectl apply -f manifests/02-configmap-v2.yaml
kubectl -n simulado-nuvem rollout restart deployment/web
kubectl -n simulado-nuvem rollout status deployment/web

# 13. Testar versão 2
kubectl -n simulado-nuvem exec cliente -- wget -qO- http://web

# 14. Simular falha de imagem
kubectl -n simulado-nuvem set image deployment/web nginx=nginx:tag-inexistente-simulado
kubectl -n simulado-nuvem get pods
kubectl -n simulado-nuvem get events --sort-by=.lastTimestamp

# 15. Executar rollback
kubectl -n simulado-nuvem rollout undo deployment/web
kubectl -n simulado-nuvem rollout status deployment/web
kubectl -n simulado-nuvem get deployment web -o wide

# 16. Conferir ConfigMap e aplicação após rollback
kubectl -n simulado-nuvem get configmap pagina -o yaml
kubectl -n simulado-nuvem exec cliente -- wget -qO- http://web

# 17. Criar CronJob
kubectl apply -f manifests/05-cronjob.yaml

# 18. Criar Job manualmente a partir do CronJob
kubectl -n simulado-nuvem create job teste-web --from=cronjob/verifica-web

# 19. Aguardar e conferir resultado
kubectl -n simulado-nuvem wait --for=condition=complete job/teste-web --timeout=120s
kubectl -n simulado-nuvem logs job/teste-web

# 20. Conferir os arquivos YAML
kubectl apply --dry-run=client -f manifests/

