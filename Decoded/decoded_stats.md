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


| code | model                    | name         | damage | damage(1up) | damage(2up) | damage(3up) | damage(FULL) |
|------|--------------------------|--------------|--------|-------------|-------------|-------------|--------------|
| 0    | BULLET1                  | Cannon       | 20     | 24          | 28          | 32          | 34           |
| 1    | BULLET1                  | Minigun      | 15     | 18          | 21          | 24          | 25           |
| 2    | BULLETRAKETA             | Rocket       | 8      | 9           | 11          | 12          | 13           |
| 3    | ?                        | Lighting     | 11     | 13          | 15          | 17          | 18           |
| 4    | BULLETFIRE               | Flamethrower | 9      | 10          | 12          | 14          | 15           |
| 5    | BULLETSHOCK + BULLETSHSC | Shock Gun    | 15     | 18          | 21          | 24          | 25           |


| code | model                    | name         | reload time | reload time(1up) | reload time(2up) | reload time(3up) | reload time(FULL) |
|------|--------------------------|--------------|-------------|------------------|------------------|------------------|-------------------|
| 0    | BULLET1                  | Cannon       | 0.75s       | 0.65s            | 0.59s            | 0.5s             | 0.43s             |
| 1    | BULLET1                  | Minigun      | 0.25s       | 0.21s            | 0.18s            | 0.15s            | 0.12s             |
| 2    | BULLETRAKETA             | Rocket       | 0.56s       | 0.5s             | 0.43s            | 0.37s            | 0.31s             |
| 3    | ?                        | Lighting     | 1.25s       | 1.12s            | 1.0s             | 0.87s            | 0.75s             |
| 4    | BULLETFIRE               | Flamethrower | 0.12s       | 0.09s            | 0.09s            | 0.06s            | 0.06s             |
| 5    | BULLETSHOCK + BULLETSHSC | Shock Gun    | 0.56s       | 0.5s             | 0.43s            | 0.37s            | 0.31s             |


# Upgrades

Models has 4 variants, i.e. *ADDARMOR ADDARMORI ~ III*

| Upgrade          | Model    | effect(1up)                                                                                    | effect(2up)                                                                                    | effect(3up)                                                                                    | effect(FULL)                                                                                   |
|------------------|----------|------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------|
| Armor            | ADDARMOR | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/c1d7b513-2d6d-4ae2-8c1d-e5084fedd261) | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/2b771d0f-a8d9-4315-8158-939974b47e78) | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/3f093a06-04ff-419f-943a-b0e9fa3faf5e) | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/2f2e82f5-ba18-43db-8d78-0d8cfc18d641) |
| Movement speed   | ADDSPM   | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/147cca07-92f8-4ded-896a-d35e0593e07f) | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/7b70bbf1-094f-4d4d-9b08-b6108be4fdc0) | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/943f09b5-03d0-4591-a72b-295752972798) | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/8d14c769-da17-4022-b27f-a4a8b45f427f) |
| Reload time      | ADDSPF   | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/fbff39ef-5a3a-40da-bde4-5cc7d425e74a) | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/4fd570f4-aaa3-4de8-8b1c-6951d544e546) | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/02800269-03c6-4897-9769-adcdfe0f7afe) | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/28bcb4b3-425a-4a3d-b921-cfdb30ba21bd) |
| Projectile Speed | ADDSPB   | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/1494045e-562b-4c15-a353-1abf21aec11c) | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/571f50d1-b431-4d7b-bb73-f7b706cf8ea7) | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/e81ee586-5856-4894-8cfe-8f92212839dd) | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/0edc49e0-5239-4476-961c-249ed6f5c22e) |
| Damage           | ADDUN    | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/04dc1218-84dc-4771-b351-d1bc7bbae483) | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/a6780701-2817-4b07-b121-9277fe6022d6) | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/0da6c233-7fca-43aa-a899-18ca59484396) | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/7ec4a457-19f5-4ca7-9cbc-a2446d37133c) |
