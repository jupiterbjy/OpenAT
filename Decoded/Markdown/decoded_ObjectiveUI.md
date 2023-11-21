[Return to previuos page](/Decoded/Readme.md)

## ObjectiveUI Structure

```text
gametype  BF HT

.
.
.

items XM

help 2 X M  

message F
```

```text
gametype [game modes] [dummy data if any]

.
.
.

items [item codes] [dummy data if any]

help [help ID] [item breifing]  [dummy data if any]
```

- In the case of Help, only the following numbers are 0, 1, 2, and 3

- If the following number is more than 4, it will break the game

- Describe the item corresponding to the code on the first screen as many as the number of postscripts. (Ignore any additional item codes that appear later)

- In addition to the items that come out of Help, there are times when there are other items in the field

- All map files, Message Only have following code F

---

## Game Objectives

In map file, it names gametype

| code | image                                                                                           | eng                 | note                        |
|------|-------------------------------------------------------------------------------------------------|---------------------|-----------------------------|
| B    | ![B](https://github.com/jupiterbjy/OpenAT/assets/45421813/513d4ec3-4d07-4582-853d-bc61c5f5d86b) | Destroy all enemies |                             |
| F    | ![F](https://github.com/jupiterbjy/OpenAT/assets/45421813/870d1cec-3143-4881-9868-a19bea3c9a24) | Defend your base    |                             |
| H    | ![H](https://github.com/jupiterbjy/OpenAT/assets/45421813/7d27022c-c8c4-4dbd-8654-f55b5fc38985) | Pick up all boxes   | actually no need to pick up |
| T    | ![T](https://github.com/jupiterbjy/OpenAT/assets/45421813/8dbbc73f-2042-4552-adbd-718ecaf5c726) | Destroy all bunkers |                             |



---




## Game Objects

Help Code, items code use below code Table

| code | image                                                                                           | description                                                          |
|------|-------------------------------------------------------------------------------------------------|----------------------------------------------------------------------|
| C    | ![C](https://github.com/jupiterbjy/OpenAT/assets/45421813/6e792a72-85b0-4076-bebe-432f1cc010f1) | ! lock enemies                                                       |
| S    | ![S](https://github.com/jupiterbjy/OpenAT/assets/45421813/02deccf2-cd0e-4978-a3f0-412e564b09ff) | ! invincibility                                                      |
| M    | ![M](https://github.com/jupiterbjy/OpenAT/assets/45421813/93088393-b98d-4d54-b025-22ba78e8769f) | Recovers tank hit points                                             |
| L    | ![L](https://github.com/jupiterbjy/OpenAT/assets/45421813/272936d8-18d7-4a2e-b29c-20c780ddcf44) | ! construct stone walls around base                                  |
| Z    | ![Z](https://github.com/jupiterbjy/OpenAT/assets/45421813/106aaaa3-3c21-4193-8b11-3bcda32c2387) | ! lock enemy weapons                                                 |
| R    | ![R](https://github.com/jupiterbjy/OpenAT/assets/45421813/da6bcd91-8e47-4fc6-a761-69828fe84ee3) | Temporarily improves shooting speed (does not work with max upgrade) |
| B    | ![B](https://github.com/jupiterbjy/OpenAT/assets/45421813/97b6bb11-b89a-47a4-b7d9-d8b6aee9a1f4) | ! damage all enemies on screen                                       |
| I    | ![I](https://github.com/jupiterbjy/OpenAT/assets/45421813/2c854d87-479d-46bf-a567-fd75c4d7efd9) | ! setup mines                                                        |
| X    | ![X](https://github.com/jupiterbjy/OpenAT/assets/45421813/2a885c67-1203-4ee1-864a-c55c16a9f6d4) | Regenerate hit points over time                                      |
| Y    | ![Y](https://github.com/jupiterbjy/OpenAT/assets/45421813/78e90725-1a16-4af9-a255-ded8e45b3525) | Recovers enemy hit points                                            |

---


In Map RUIN-2 (1-2)




- Case 1:

  gametype BF

  help 3 X M S 


![](https://github.com/jupiterbjy/OpenAT/assets/45421813/f1fee086-18b9-4197-b372-1937337c8a67)




- Case 2:

  gametype HT

  Help 2 X M 


![](https://github.com/jupiterbjy/OpenAT/assets/45421813/83adcbe2-b168-4394-a5e7-38b4fa5e7ef8)


---

## Character Structure

```text
txt [Script] [Character]
...
```

## Character code

.\Armada Tanks\game data\BaseT\Message 

All txt files in that folder are loaded only when the game is on


| code | image                                                                                                      | note                           |
|------|------------------------------------------------------------------------------------------------------------|--------------------------------|
| 0    | ![Face_trans_0](https://github.com/jupiterbjy/OpenAT/assets/45421813/4a56b845-355e-499e-b7af-e0631571a877) | Partner                        |
| 1    | ![Face_trans_1](https://github.com/jupiterbjy/OpenAT/assets/45421813/f2320563-4db6-41fa-8c17-3e2c385a3791) | Enemy                          |
| 2    | ![Face_trans_2](https://github.com/jupiterbjy/OpenAT/assets/45421813/7dd06209-a793-4073-8b51-93f94fc14a2a) | Commander                      |
| 3    | ![Face_trans_3](https://github.com/jupiterbjy/OpenAT/assets/45421813/c4f28de0-a79a-4e46-958b-68e78ef9e126) | When loads, It crush UI Screen |



