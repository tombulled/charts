# charts

helm repo add argo https://argoproj.github.io/argo-helm
kubectl create namespace argocd
helm install argo-cd argo/argo-cd --version 8.1.3 --namespace argocd
kubectl port-forward service/argo-cd-argocd-server -n argocd 8080:443
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d