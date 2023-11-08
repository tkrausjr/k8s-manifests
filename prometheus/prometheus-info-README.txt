https://semaphoreci.com/blog/prometheus-grafana-kubernetes-helm
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus

