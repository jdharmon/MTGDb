#!/bin/sh
mongoimport -d mtg -c sets --file /docker-entrypoint-initdb.d/sets.json
mongoimport -d mtg -c cards --file /docker-entrypoint-initdb.d/cards.json