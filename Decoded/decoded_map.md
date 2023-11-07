## Structure

```text
map 3 

cost 100

gametype  BF HT

texscript BaseT\Script\texture-forest.scr
mdlscript BaseT\Script\model.scr
weather NONE

fog 0

music {
  track modf BaseT\Music\game.it rain_00.mid
  track modf BaseT\Music\game.it rain_00.mid
  endmusic
}

nextmap 1 BaseT\Map\RUIN\m2.map

items XM

help 2 X M   1 I C Z R L B S

message F
 
tank 12 2PPP  2 2 2D 2 1   2 1D 2 2  2 2T 1T 1DD  2 2H 1 2 3TC 2 2 2

size 21 21 

flag 10 4 FLAGI FLAG123 FLAG FLAG 

eventobj { 
  endeventobj 
} 

respawn { 
  rsp 0 8 4 
  rsp 1 12 4 
  rsp 2 2 2 
  rsp 3 2 2 
  rsp 4 5 16 
  rsp 5 8 16 
  rsp 6 13 16 
  rsp 7 15 16 
  endrespawn 
} 

terrtype { 
  type 0 TERR0 NWF 
  type 1 TERR1 NWF 
  ...
  type 110 TERR47 N 
  type 111 TERR47 N 
  endterr 
} 

wall { 
  ln "        ##        &&&&&&  ####            " 
  ln "        ##        &&&&&&  ####            " 
  ln "            ##    &&  &&  ##    ##        " 
  ln "            ##    &&  &&  ##    ##        " 
  ln "                                          " 
  ln "                                          " 
  ...
  endwall 
} 

terr { 
  ln 31 N12 31 N12 31 N12 ... 0 N12   
  ...   
  endterr 
} 

terr2 { 
  ln 1 N25 1 N25 0 N15 256 N235 256 N235 ... 1 N25   
  ...   
  endterr 
} 
```

Has a bit of trailing whitespaces, that is not a mistake.

entire music section is dummy data.

```text
map [map # starting from 1]


cost [reward after clear]


gametype [game modes] [dummy data if any]


texscript [override textures' definition path]


mdlscript [model definition path]


weather [NONE | RAIN | SNOW - weathers]


# dummy data? every map uses value 0
fog 0


# Entire music section is dummy - there's no midi files
music { 
  track [modf] [music path] [midi file name/alias]
  ...
  endmusic
}


nextmap [0 if no next map else 1] [next map path if exists]


items [item codes] [dummy data if any]


help [help ID] [item breifing]  [dummy data if any]


message [UNKNOWN]


tanks - in decoded_tanks.md


size [width] [height]


flag [X] [Y] [flag model entry name] [flag texture entry name] [dummy data if any]


eventobj - in decoded_events.md


# ID 0: player respawn point, 1~3: Unknown, 4~7: Enemy respawn points. gates are just decoration.
respawn {  
  rsp 0 [x] [y]
  ...
  rsp [id] [x] [y]
  ...
  rsp 7 [x] [y]
  endrespawn
}


terrtype - in decoded_terrtype.md

wall - in decoded_wall.md

terr - in decoded_terr.md

terr2 - in decoded_terr.md
```
