#! /bin/bash

kubectl get pods --all-namespaces --field-selector spec.nodeName=kube3 -o jsonpath='{range .items[*]}{.metadata.namespace}{" "}{.metadata.name}{"\n"}{end}' | \
while read namespace name; do
  kubectl delete pod $name -n $namespace --force --grace-period=0
done