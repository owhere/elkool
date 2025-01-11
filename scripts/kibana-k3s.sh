# deploy kibana

helm install kibana elastic/kibana \
  --namespace elk \
  --set service.type=NodePort \
  --set service.nodePort=30961 \
  --set elasticsearch.username=elastic \
  --set elasticsearch.password=<elasticsearch-password>

  
curl -k u elastic:hj6E98jXwc8REj4y -X GET "https://localhost:9200"