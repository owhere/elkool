helm install kibana elastic/kibana \
  --namespace elk \
  --set service.type=NodePort \
  --set service.nodePort=30961 \
  --set elasticsearch.username=elastic \
  --set elasticsearch.password=<elasticsearch-password>

# NAME: kibana
# LAST DEPLOYED: Wed Jan  1 14:54:11 2025
# NAMESPACE: elk
# STATUS: deployed
# REVISION: 1
# TEST SUITE: None
# NOTES:
# 1. Watch all containers come up.
#   $ kubectl get pods --namespace=elk -l release=kibana -w
# 2. Retrieve the elastic user's password.
#   $ kubectl get secrets --namespace=elk elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d
# 3. Retrieve the kibana service account token.
#   $ kubectl get secrets --namespace=elk kibana-kibana-es-token -ojsonpath='{.data.token}' | base64 -d

# ubuntu@kube0:~$ k get svc -n elk
# NAME                            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)             AGE
# elasticsearch-master            ClusterIP   10.233.44.183   <none>        9200/TCP,9300/TCP   122m
# elasticsearch-master-headless   ClusterIP   None            <none>        9200/TCP,9300/TCP   122m
# kibana-kibana                   NodePort    10.233.26.171   <none>        5601:30961/TCP      108m