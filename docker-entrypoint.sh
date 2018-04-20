#!/bin/sh
mongod &
sleep 2

# Create collections with case-insensitive collation
mongo << EOF
use mtg;
db.createCollection("cards", { collation: { locale: "en", strength: 2 }});
db.createCollection("sets", { collation: { locale: "en", strength: 2 }});
EOF

# Import data
mongoimport -d mtg -c sets --file /data/sets.json
mongoimport -d mtg -c cards --file /data/cards.json

# Wait indefinitely so container doesn't exit
tail -f /dev/null