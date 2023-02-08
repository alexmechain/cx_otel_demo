git switch main

set -x
NOW=$(echo '('`date +"%s.%N"` ' * 1000)/1' | bc)

API=bcaf694c-6080-aa9d-bf8b-d398e2b82b39

curl -v --location --request POST 'https://webapi.coralogix.com/api/v1/external/tags' \
--header 'Authorization: Bearer '$API'' \
--header 'Content-Type: application/json' \
--data-raw '{
"timestamp": '$NOW',
"name": "Version 1.2.2",
"application": ["AstronomyShop"],
"subsystem": ["productcatalaogservice", "cartservice"]
}'

helm upgrade demo open-telemetry/opentelemetry-demo -i -f ./cx_otel_values.yaml
