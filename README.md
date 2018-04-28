# MTGDb

Mongo database containing Magic: The Gathering cards and sets.

The ```mtg``` database contains the following collections
* cards
* sets

## Usage

```
$ docker run --rm -d --name mtgdb -p 27017:27017 jdharmon/mtgdb
```

### Card Search

Find the most recent printing of Opt.

```
$ docker exec -it mtgdb mongo

> use mtg
switched to db mtg
> db.cards.find({ "name": "opt"}).sort({ "multiverseid": -1 }).limit(1).pretty()

{
        "_id" : ObjectId("5ae4e9af76d7a0b23809e6a7"),
        "artist" : "Tyler Jacobson",
        "cmc" : 1,
        "colorIdentity" : [
                "U"
        ],
        "colors" : [
                "Blue"
        ],
        "flavor" : "The crystal pulsed with the power of Teferi's planeswalker spark. Had Jhoira given him a blessing or a curse?",
        "id" : "fae3c6d55c9c4b42e5d967397de835e5bda35538",
        "imageName" : "opt",
        "layout" : "normal",
        "manaCost" : "{U}",
        "multiverseid" : 442948,
        "name" : "Opt",
        "number" : "60",
        "rarity" : "Common",
        "text" : "Scry 1. (Look at the top card of your library. You may put that card on the bottom of your library.)\nDraw a card.",
        "type" : "Instant",
        "types" : [
                "Instant"
        ],
        "set" : "DOM"
}
```
