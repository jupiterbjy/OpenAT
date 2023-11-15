

## Structure

```text
items XM

help 2 X M  

message F
```

- In the case of Help, only the following numbers are 0, 1, 2, and 3

- If the following number is more than 4, it will break the game

- Describe the item corresponding to the code on the first screen as many as the number of postscripts. (Ignore any additional item codes that appear later)

- In addition to the items that come out of Help, there are times when there are other items in the field

- All map files, Message Only have following code F




In Map RUIN-2 (1-2)




Case 1: Help 3 X M S 


![1-2](https://github.com/jupiterbjy/OpenAT/assets/45421813/47fc86b7-ae07-4e1d-97d4-60041044fdce)


Case 2: Help 2 X M 


![1-2 2](https://github.com/jupiterbjy/OpenAT/assets/45421813/6a094e83-45f2-49a5-8dec-be9ca355a326)


## Header Section

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
