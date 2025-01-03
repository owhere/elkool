kubectl create secret generic elastic-credentials -n elk \
  --from-literal=username=elastic \
  --from-literal=password=<your-elasticsearch-password>


curl -k -u elastic:<your-elasticsearch-password> https://elasticsearch-master:9200/logstash-*/_search?pretty