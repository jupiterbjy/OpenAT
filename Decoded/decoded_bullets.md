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

| code | wall damage  | splash shape image |
|------|--------------|--------------------|
| 0    | 2            |                    |
| 1    | 1            |                    |
| 2    | 2 (1 splash) |                    |
| 3    | 4 (2 splash) |                    |
| 4    | 1 (1 splash) |                    |
| 5    | 1 (1 splash) |                    |
