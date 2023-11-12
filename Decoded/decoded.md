Colelction of decoded information that doesn't have its own Markdown document.

---

## Game Objectives

aka gametypes

| code | image                                                                                           | eng                 | note                        |
|------|-------------------------------------------------------------------------------------------------|---------------------|-----------------------------|
| B    | ![B](https://github.com/jupiterbjy/OpenAT/assets/45421813/513d4ec3-4d07-4582-853d-bc61c5f5d86b) | Destroy all enemies |                             |
| F    | ![F](https://github.com/jupiterbjy/OpenAT/assets/45421813/870d1cec-3143-4881-9868-a19bea3c9a24) | Defend your base    |                             |
| H    | ![H](https://github.com/jupiterbjy/OpenAT/assets/45421813/7d27022c-c8c4-4dbd-8654-f55b5fc38985) | Pick up all boxes   | actually no need to pick up |
| T    | ![T](https://github.com/jupiterbjy/OpenAT/assets/45421813/8dbbc73f-2042-4552-adbd-718ecaf5c726) | Destroy all bunkers |                             |

---

## Game Objects

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

## Map Areas

| Dirname | Stage No |
|---------|----------|
| RUIN    | 1        |
| SAND    | 2        |
| RAIN    | 3        |
| SNOW    | 4        |
| EGYPT   | 5        |
| ICE     | 6        |
| FIRE    | 7        |
| TUND    | 8        |
| CAST    | 9        |
| DUNG    | 10       |
| GROT    | 11       |
| FARO    | 12       |
| END     | 13       |

---

## Bullet types

| name            | Model.scr Entry  | texture             | usage                                      |
|-----------------|------------------|---------------------|--------------------------------------------|
| Bullet_1        | 11 BULLET1       | Bullet.JPG          | Cannon, Gatling                            | 
| Bullet_2        | 52 BULLET2       | Fire.JPG?           | Possibly a red bullet, usage unknown       |
| Bullet_Electro  | 148 BULLET3      | ?                   | Seemingly unused                           |
| ?               | ?                | Light.JPG           | Actual lighting with variable length       |
| Bullet_Fire     | 78 BULLETFIRE    | Fire.JPG            | FlameThrower                               |
| Bullet_MapShow  | 202 BLMPSH       | ?                   | Bullet used in main menu 3D Scene, no uv   |
| Bullet_Raketa   | 166 BULLETRAKETA | Tank_Head_Green.JPG | Rocket launcher                            |
| Bullet_Shock    | 167 BULLETSHOCK  | Bullet.JPG          | Shockwave cannon                           |
| Bullet_Shock_Sc | 168 BULLETSHSC   | Bullet.JPG          | Secondary projectile from Shockwave cannon |
| bullet          | 28 BULLET        | ?                   | Dummy file? no matching image              |


| code | model                    | name         | damage | damage(1up) | damage(2up) | damage(3up) |
|------|--------------------------|--------------|--------|-------------|-------------|-------------|
| 0    | BULLET1                  | Cannon       |        |             |             |             |
| 1    | BULLET1                  | Minigun      |        |             |             |             |
| 2    | BULLETRAKETA             | Rocket       |        |             |             |             |
| 3    | ?                        | Lighting     |        |             |             |             |
| 4    | BULLETFIRE               | Flamethrower |        |             |             |             |
| 5    | BULLETSHOCK + BULLETSHSC | Shock Gun    |        |             |             |             |


| Upgrade          | model | no effect | effect(1up) | effect(2up) | effect(3up) |
|------------------|-------|-----------|-------------|-------------|-------------|
| Armor            |       |           |             |             |             |
| Movement speed   |       |           |             |             |             |
| Reload time      |       |           |             |             |             |
| Projectile Speed |       |           |             |             |             |
| Damage           |       |           |             |             |             |
