# deploy elastic search

helm install elasticsearch elastic/elasticsearch \
  --namespace elk \
  --create-namespace \
  --set persistence.storageClass=cinder \
  --set replicas=2

# ubuntu@kube0:~/code/elkfun/scripts$ bash elasticsearch.sh 
# NAME: elasticsearch
# LAST DEPLOYED: Wed Jan  1 11:35:15 2025
# NAMESPACE: elk
# STATUS: deployed
# REVISION: 1
# NOTES:
# 1. Watch all cluster members come up.
#   $ kubectl get pods --namespace=elk -l app=elasticsearch-master -w
# 2. Retrieve elastic user's password.
#   $ kubectl get secrets --namespace=elk elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d
# 3. Test cluster health using Helm test.
#   $ helm --namespace=elk test elasticsearch


helm upgrade elasticsearch elastic/elasticsearch -n elk \
  --set httpService.readinessProbe.scheme=https
# Release "elasticsearch" has been upgraded. Happy Helming!
# NAME: elasticsearch
# LAST DEPLOYED: Wed Jan  1 12:18:32 2025
# NAMESPACE: elk
# STATUS: deployed
# REVISION: 2
# NOTES:
# 1. Watch all cluster members come up.
#   $ kubectl get pods --namespace=elk -l app=elasticsearch-master -w
# 2. Retrieve elastic user's password.
#   $ kubectl get secrets --namespace=elk elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d
# 3. Test cluster health using Helm test.
#   $ helm --namespace=elk test elasticsearch

# Test

k get secrets --namespace=elk elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d


k port-forward -n elk svc/elasticsearch-master 9200:9200
# Forwarding from 127.0.0.1:9200 -> 9200
# Forwarding from [::1]:9200 -> 9200
# Handling connection for 9200


ubuntu@kube0:~$ curl -k -u elastic:<password> -X GET "https://localhost:9200"
{
  "name" : "elasticsearch-master-2",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "utes4wxoRpimTTYPZ6aFZg",
  "version" : {
    "number" : "8.5.1",
    "build_flavor" : "default",
    "build_type" : "docker",
    "build_hash" : "c1310c45fc534583afe2c1c03046491efba2bba2",
    "build_date" : "2022-11-09T21:02:20.169855900Z",
    "build_snapshot" : false,
    "lucene_version" : "9.4.1",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}