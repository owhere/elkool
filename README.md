# Deploy ELK on Openstack k8s

## Prerequisites

- Kubernetes Cluster: Ensure your Kubernetes cluster is running and accessible.
- Storage Class: A provisioner for persistent volumes (e.g., OpenStack Cinder) should be available.
- kubectl: Ensure you can interact with your cluster using kubectl.
- Helm: Install Helm for easier chart management.

## Deploy Elasticsearch and Kibana via helm

### Setup Helm 

```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
helm repo add elastic https://helm.elastic.co
helm repo update
```

### Deploy Elasticsearch
Ref: [elasticsearch.sh](scripts/elasticsearch.sh)

- Install

```bash
helm install elasticsearch elastic/elasticsearch \
  --namespace elk \
  --create-namespace \
  --set persistence.storageClass=cinder \
  --set replicas=2
```

- Update
```bash
helm upgrade elasticsearch elastic/elasticsearch -n elk \
  --set httpService.readinessProbe.scheme=https
```

- Retrieve Password
```bash
k get secrets --namespace=elk elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d
```

- Test
```bash
k port-forward -n elk svc/elasticsearch-master 9200:9200
```

```bash
curl -k -u elastic:<password> -X GET "https://localhost:9200"
```

### Deploy Kibana
Ref: [kibana.sh](scripts/kibana.sh)

- Install

```bash
helm install kibana elastic/kibana \
  --namespace elk \
  --set service.type=NodePort \
  --set service.nodePort=30961 \
  --set elasticsearch.username=elastic \
  --set elasticsearch.password=<elasticsearch-password>
```

## Deploy Logstash via kustomize

- create secret

```bash
kubectl create secret generic elastic-credentials -n elk \
  --from-literal=username=elastic \
  --from-literal=password=<your-elasticsearch-password>
```

- Prepare file under manifests/logstash

- Deploy

```bash
k apply -k manifests/logstash
```

## Visualise data

- Convert json to ndjson
```bash
cd pipeline
python json_to_ndjson.py input.json output.ndjson my-index
```

- Upload data

```bash
cd pipeline
bash upload.sh
```

- Check Index 

Kibana > Management > Stack Management > Index Management

- Check Mapping 

Kibana > Managment > Dev Tools

- Make Visualisations 

Kibana > Analytics > Visualize Library

- Create Dashboard
