FROM alpine AS seed
RUN apk --no-cache add curl zip jq
WORKDIR /tmp/data
RUN curl -sO https://mtgjson.com/json/AllSets.json.zip \
 && unzip AllSets.json.zip \
 && mkdir /data \
 && jq -r 'to_entries[] | .value | del(.cards)' AllSets.json > /data/sets.json \
 && jq -r 'to_entries[] | .value.cards[] + {set: .key}' AllSets.json > /data/cards.json
 
FROM alpine
RUN apk --no-cache add mongodb mongodb-tools
COPY --from=seed /data /data
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
VOLUME /data/db
EXPOSE 27017
CMD docker-entrypoint.sh