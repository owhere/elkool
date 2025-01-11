# deploy elastic search

helm install elasticsearch elastic/elasticsearch \
  --namespace elk \
  --create-namespace \
  --set resources.requests.memory="1024Mi" \
  --set resources.requests.cpu="500m" \
  --set replicas=1