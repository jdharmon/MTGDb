FROM mongo
RUN apt-get update \
 && apt-get install -y curl zip
COPY import-data.sh /docker-entrypoint-initdb.d/
WORKDIR /root
RUN curl -O https://mtgjson.com/json/AllSets.json.zip
RUN unzip AllSets.json.zip \
 && jq -r 'to_entries[] | .value | del(.cards)' AllSets.json > /docker-entrypoint-initdb.d/sets.json \
 && jq -r 'to_entries[] | .value.cards[] + {set: .key}' AllSets.json > /docker-entrypoint-initdb.d/cards.json \
 && rm *
RUN apt-get remove -y curl zip \
 && rm -rf /var/lib/apt/lists/*