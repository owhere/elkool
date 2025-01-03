#! /bin/bash

# curl -k -u elastic:<password> -X POST "https://<elasticsearch-service-ip>:9200/_bulk" -H 'Content-Type: application/json' --data-binary @output.ndjson
curl -k -u elastic:<password> -X POST "https://localhost:9200/_bulk" -H 'Content-Type: application/json' --data-binary @/home/ubuntu/code/elkfun/data/zammad-prod-20250102.ndjson