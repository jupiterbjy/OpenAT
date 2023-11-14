# Bullet data

| name            | Model.scr Entry  | texture             | texture entry | usage                                      |
|-----------------|------------------|---------------------|---------------|--------------------------------------------|
| Bullet_1        | 11 BULLET1       | Bullet.JPG          | 64 BULLET     | Cannon, Gatling                            | 
| Bullet_2        | 52 BULLET2       | Fire.JPG?           | 8 FIRE        | Possibly a red bullet, usage unknown       |
| Bullet_Electro  | 148 BULLET3      | ?                   | ?             | Model unused                               |
| ?               | ?                | Light.JPG           | 68 BLIGHT     | Actual lighting with variable length       |
| Bullet_Fire     | 78 BULLETFIRE    | Fire.JPG            | 8 FIRE        | FlameThrower                               |
| Bullet_MapShow  | 202 BLMPSH       | ?                   | ?             | Bullet used in main menu 3D Scene, no uv   |
| Bullet_Raketa   | 166 BULLETRAKETA | Tank_Head_Green.JPG | 59 PLHEAD     | Rocket launcher                            |
| Bullet_Shock    | 167 BULLETSHOCK  | Bullet.JPG          | 64 BULLET     | Shockwave cannon                           |
| Bullet_Shock_Sc | 168 BULLETSHSC   | Bullet.JPG          | 64 BULLET     | Secondary projectile from Shockwave cannon |
| bullet          | 28 BULLET        | ?                   | ?             | Dummy file? no matching image              |


# Bullet sounds

| model        | name         | fire sound      |
|--------------|--------------|-----------------|
| BULLET1      | Cannon       | Fire.wav        |
| BULLET1      | Minigun      | A_otcannon.wav  |
| BULLETRAKETA | Rocket       | an_misslaun.wav |
| ?            | Lightning    | an_light-3.wav  |
| BULLETFIRE   | Flamethrower | an_fire.wav     |
| BULLETSHOCK  | Shock Gun    | an_shock.wav    |
| BULLETSHSC   |              |                 |


# Bullet wall damage

| Namse               | wall damage  | splash shape                                                                                   |
|---------------------|--------------|------------------------------------------------------------------------------------------------|
| Cannon              | 2            | ![](https://github.com/jupiterbjy/OpenAT/assets/26041217/4139d481-abf8-4cc0-ae7d-a83c2dd91b40) |
| Minigun             | 1            | ![](https://github.com/jupiterbjy/OpenAT/assets/26041217/4fd7997f-6ec2-47ad-a08f-a7e040703cba) |
| Rocket              | 2 (1 splash) | ![](https://github.com/jupiterbjy/OpenAT/assets/26041217/5882d4f8-fac5-43db-ad65-1d64752e200a) |
| Lightning           | 4 (2 splash) | ![](https://github.com/jupiterbjy/OpenAT/assets/26041217/35e7c0bf-4e63-4ac7-8ad2-0163941396c7) |
| Flamethrower        | 1 (1 splash) | ![](https://github.com/jupiterbjy/OpenAT/assets/26041217/5708f38a-5ad7-4aaf-ab15-666b472596d2) |
| Shock Gun           | 1 (1 splash) | ![](https://github.com/jupiterbjy/OpenAT/assets/26041217/5708f38a-5ad7-4aaf-ab15-666b472596d2) |
| Shock Gun secondary | 1            | ![](https://github.com/jupiterbjy/OpenAT/assets/26041217/4fd7997f-6ec2-47ad-a08f-a7e040703cba) |

