## TOC

1. [Game Objectives](Game-Objectives)
2. [Game Objects](Game-Objects)
3. [Event Objects](Event-Objects)
4. [Map Areas](Map-Areas)
5. [Map Notations](Map-Notations)

---

## Game Objectives

aka gametypes

| code | image | description kor | eng | note |
|-|-|-|-|-|
| B |![B](https://github.com/jupiterbjy/OpenAT/assets/45421813/513d4ec3-4d07-4582-853d-bc61c5f5d86b)| 모든 적 파괴 | Destroy all enemies | |
| F |![F](https://github.com/jupiterbjy/OpenAT/assets/45421813/870d1cec-3143-4881-9868-a19bea3c9a24)| 기지 방어 | Defend your base | |
| H |![H](https://github.com/jupiterbjy/OpenAT/assets/45421813/7d27022c-c8c4-4dbd-8654-f55b5fc38985)| 모든 상자 줍기 | Pick up all boxes | 실제론 안주워도 클리어 지장 없음. 미구현? |
| T |![T](https://github.com/jupiterbjy/OpenAT/assets/45421813/8dbbc73f-2042-4552-adbd-718ecaf5c726)| 모든 벙커 파괴 | Destroy all bunkers | |

---

## Game Objects

| code | image | description |
|-|-|-|
| C |![C](https://github.com/jupiterbjy/OpenAT/assets/45421813/6e792a72-85b0-4076-bebe-432f1cc010f1)|! lock enemies|
| S |![S](https://github.com/jupiterbjy/OpenAT/assets/45421813/02deccf2-cd0e-4978-a3f0-412e564b09ff)|! invincibility|
| M |![M](https://github.com/jupiterbjy/OpenAT/assets/45421813/93088393-b98d-4d54-b025-22ba78e8769f)|Recovers tank hit points|
| L |![L](https://github.com/jupiterbjy/OpenAT/assets/45421813/272936d8-18d7-4a2e-b29c-20c780ddcf44)|! construct stone walls around base|
| Z |![Z](https://github.com/jupiterbjy/OpenAT/assets/45421813/106aaaa3-3c21-4193-8b11-3bcda32c2387)|! lock enemy weapons|
| R |![R](https://github.com/jupiterbjy/OpenAT/assets/45421813/da6bcd91-8e47-4fc6-a761-69828fe84ee3)| Temporarily improves shooting speed (does not work with max upgrade)|
| B |![B](https://github.com/jupiterbjy/OpenAT/assets/45421813/97b6bb11-b89a-47a4-b7d9-d8b6aee9a1f4)|! damage all enemies on screen|
| I |![I](https://github.com/jupiterbjy/OpenAT/assets/45421813/2c854d87-479d-46bf-a567-fd75c4d7efd9)|! setup mines|
| X |![X](https://github.com/jupiterbjy/OpenAT/assets/45421813/2a885c67-1203-4ee1-864a-c55c16a9f6d4)| Regenerate hit points over time |
| Y |![Y](https://github.com/jupiterbjy/OpenAT/assets/45421813/78e90725-1a16-4af9-a255-ded8e45b3525)| Recovers enemy hit points |

---

## Event Objects

(Ordered by encounter during progression)

| code | image | description |
|-|-|-|
| 1 |![1](https://github.com/jupiterbjy/OpenAT/assets/45421813/0fc38aa6-1e0c-49c4-8663-084b0270b76e)| Bunker |
| 3 |![3](https://github.com/jupiterbjy/OpenAT/assets/45421813/9520ee8e-bb93-479a-936a-88f33e8979ee)| Box |
| 4 |![4](https://github.com/jupiterbjy/OpenAT/assets/45421813/6658eccf-7c71-4bf3-95ba-2580f23b89be)| Turret |
| 5 |![5](https://github.com/jupiterbjy/OpenAT/assets/45421813/ac906f2c-f491-4524-949a-df574406e86b)| Reflector Angle 0 |
| 6 |![6](https://github.com/jupiterbjy/OpenAT/assets/45421813/9f9448e6-350a-46d9-bf67-b6b1f9f66e03)| Reflector Angle 1 |
| 7 |![7](https://github.com/jupiterbjy/OpenAT/assets/45421813/23c2423f-3c99-452b-a34b-a9fd875c6126)| Explosive |
| 8 |![8](https://github.com/jupiterbjy/OpenAT/assets/45421813/20e0b7e5-ea23-4932-af6c-8e15c4a2e8d6)| Heal Tower |

---

## weather
- NONE : 맑음
- RAIN : 비
- SNOW : 눈

---

## tank code

### type code

| code | image | note |
|-|-|-|
|0|![0](https://github.com/jupiterbjy/OpenAT/assets/45421813/65894c31-59a1-4b7f-9678-6bcafbe616e2)|Random upgrade & weapon, not sure about weapon's chance - seen a lot of flamethrower and not a single pluse cannon.|
|1|![1](https://github.com/jupiterbjy/OpenAT/assets/45421813/87a13735-3753-4137-8cf9-e078517c63e4)||
|2|![2](https://github.com/jupiterbjy/OpenAT/assets/45421813/8a1c9219-a9f8-4095-9fd1-5549a36d408c)||
|3|![3](https://github.com/jupiterbjy/OpenAT/assets/45421813/1870fb17-5b7a-4932-9101-3b7812c08972)||
|4|![4](https://github.com/jupiterbjy/OpenAT/assets/45421813/7937a46e-c465-4ef9-b4d4-03dbfca90874)||
|5|![5](https://github.com/jupiterbjy/OpenAT/assets/45421813/86a583ed-5ae8-40be-8d14-d012527599fb)||
|6|![6](https://github.com/jupiterbjy/OpenAT/assets/45421813/34c952c4-86bc-47ea-b76d-59dc5fbfd863)||
|7|![7](https://github.com/jupiterbjy/OpenAT/assets/45421813/03d551c2-a491-4e1c-aa4e-d5272c36ffb9)||
|8|![8](https://github.com/jupiterbjy/OpenAT/assets/45421813/135cd1cd-3a82-49be-a98a-8a9b51d93758)||
|9|![9](https://github.com/jupiterbjy/OpenAT/assets/45421813/07779d3b-cfe9-4258-a831-39afcc2c31e0)||

### attributes
| code | description | image |
|-|-|-|
| B, S | 빨간색 |![B, S](https://github.com/jupiterbjy/OpenAT/assets/45421813/9fe1739e-ab7b-4022-94a4-193e36833497)|
| L | 하늘색 |![L](https://github.com/jupiterbjy/OpenAT/assets/45421813/0d07b150-6d34-4fb1-ad5b-6f675b108ab3)|
| K | 검정색 |![K](https://github.com/jupiterbjy/OpenAT/assets/45421813/17308f7d-59e4-41c6-9853-d1a0942c7e6e)|
| I | 투명 |![I](https://github.com/jupiterbjy/OpenAT/assets/45421813/3af3344f-556e-44b3-8a95-75cb4814a71f)|
| ? | 아이템? |![물음표](https://github.com/jupiterbjy/OpenAT/assets/45421813/2dd95927-4e0d-4ca1-874a-2a932481365a)|
| P | 5초간 다음 적 탱크 소환 안됨 |
| H | ? |
| D | 30초간 다음 적 탱크 소환 안됨 |
| T | ? |
| C | ? |
| DDD | 2분간 다음 적 탱크 소환 안됨 |
| HKB (2HKB?) | 특수전차(앞에 어떤 숫자가 붙던지 상관없이 HKB가 나오면 무조건 이 전차가 나옴) |![HKB](https://github.com/jupiterbjy/OpenAT/assets/45421813/e1da3596-a607-475c-a681-069ae002cfc6)|
| HLB (2HLB?) | EGYPT m5 에서 등장 |![HLB](https://github.com/jupiterbjy/OpenAT/assets/45421813/d86a7840-97a1-4273-b800-2c002d2e169f)|

---

## Map Areas

| Dirname | Stage No |
| - | - |
| RUIN | 1 |
| SAND | 2 |
| RAIN | 3 |
| SNOW | 4 |
| EGYPT | 5 |
| ICE | 6 |
| FIRE | 7 |
| TUND | 8 |
| CAST | 9 |
| DUNG | 10 |
| GROT | 11 |
| FARO | 12 |
| END | 13 |

---

## Wall Notations

- NOTE: Sometimes & Sign Spawn walls, sometimes not - this is core reason we're creating new notations.

### Note regarding & sign

Here's things (probably) sure about & sign:
- Instructs enemy tanks to shoot at it when in-sight or next to it, whether it's empty or not.
- This is part of how enemy attacks base or shoot mirrors - it's probably not programmed into AI logic, but just shooting at this sign

But we're not sure why it sometimes spawn walls and sometimes not. I can't find any details seems to be specifying this behavior.

| Map | Map notation | Actual |
| - | - | - |
|CAST/m4|![CASTm4 Map notation](https://github.com/jupiterbjy/OpenAT/assets/45421813/4fc428e3-027a-49b1-b471-9ef69d7f76c3)|![CASTm4 Actual](https://github.com/jupiterbjy/OpenAT/assets/45421813/caad79f8-a305-4c5e-a6fa-8fc33e3ee642)|
|RUIN/m4|![RUINm4 Map notation](https://github.com/jupiterbjy/OpenAT/assets/45421813/39ad9d51-06eb-4cdc-b495-3a4245520e90)|![RUINm4 Actual](https://github.com/jupiterbjy/OpenAT/assets/45421813/749d13bc-2f08-424a-9b68-930be50dbda1)|

### Brick walls

- Contains 4 texture groups: C / R / W / Y and each has 0~3 textures for damaged effect

| char | char(enemy target) | image | description |
| - | - | - | - |
| # | & |![Brick walls # image](https://github.com/jupiterbjy/OpenAT/assets/45421813/b5db0908-622a-4e84-acab-9b7e0410ffab)| Full health brick wall |
| 4 | 5 |![Brick walls 4 image](https://github.com/jupiterbjy/OpenAT/assets/45421813/fb42a0ba-7f6b-4bc6-be9d-605cfd1705a4)| Health 3 Wall |
| 2? | 7 |![Brick walls 2 image](https://github.com/jupiterbjy/OpenAT/assets/45421813/23b5b447-c530-40b6-8dc7-d20c93aad017)| Health 2 Wall |
| 0? | 9 |![Brick walls 0 image](https://github.com/jupiterbjy/OpenAT/assets/45421813/ea8615e9-2be7-4109-a605-361af4d8332a)| Health 1 Wall |

### Stone walls

- Contains 2 textures: TerrWall_G_O / Terr_01 - Seems like there's more dummy textures that might also is a stone wall.

| char | image | description |
| - | - | - |
| % |![Stone walls % image](https://github.com/jupiterbjy/OpenAT/assets/45421813/af138505-a547-4f4a-8b8f-3e1bb239a504)| Stone Wall |

## Terrain Notation

There's bunch of unknown stuffs here.

![Terrain Notation](https://github.com/jupiterbjy/OpenAT/assets/45421813/dbdff2ff-ed22-4747-bcaa-f86cea20ab37)

### Terr

| head | description |
| - | - |

| Tail | description |
| - | - |
| N | Default rotation / Bottom-Right corner |
| N1 | Bottom-Left corner |
| N2 | Top-Left corner |
| N12 | Top-Right corner |

### Terr2

| head | description |
| - | - |

| Tail | description |
| - | - |
| N15 |  |
| N1234 |  |
| N134 |  |
| N235 |  |

---

## Bullet types

| name | texture | usage |
| - | - | - |
| Bullet_1 | Bullet.JPG | Cannon, Gattling | 
| Bullet_2 | ? | ? |
| Bullet_Electro | Light.JPG | Lighting |
| Bullet_Fire | Fire.JPG | FlameThrower |
| Bullet_MapShow | ? | Probably bullet used in main menu 3D Scene |
| Bullet_Raketa | ? | Rocket launcher |
| Bullet_Shock | Bullet.JPG | Shockwave cannon |
| Bullet_Shock_Sc | Bullet.JPG | Secondary projectile from Shockwave cannon |

---

## Tile coordinate
| NAME | TYPE | POSITION | SIZE |
| - | - | - | - |
| terr_0 | F | | |		
| terr_1 | F | | |	
| terr_2 | F | | |		
| terr_3 | F | | |		
| terr_4 | F | [0 0] | 3X3 |
| terr_5 | T | | 1X4 |
| terr_6 | T | | |		
| terr_7 | T | | |	
| terr_8 | T | | |	
| terr_9 | T | | |
| terr_10 | W | | |
| terr_11 |	F | | |
| terr_12 |	F | | |
| terr_13 |	T | | |
| terr_14 |	F | | |
| terr_15 |	T | | |
| terr_16 |	T | | |
| terr_17 |	T | | |
| terr_18 |	T | | |
| terr_19 |	F | | |
| terr_20 |	F | | |
| terr_21 |	T | | |
| terr_22 |	T | | |
| terr_23 |	T | | |
| terr_24 |	T | | |
| terr_25 |	T	| | 4X1 |
| terr_26 |	T | | 4X2 |
| terr_27 |	F | | |
| terr_28 |	T | | |
| terr_29 |	T | | |
| terr_30 |	T | | |
| terr_31 |	T | | |
| terr_32 |	T | | |
| terr_33 |	T | | |
| terr_34 |	F | | |
| terr_35 |	F | | |
| terr_36 |	T | | |
| terr_37 |	T | | |
| terr_38 |	F | | |
| terr_39 |	NULL | | |
| terr_40 |	NULL | | |
| terr_41 |	F | | |
| terr_42 |	T | | |
| terr_43 |	T | | 3X2 |
| terr_44 |	T | | |
| terr_45 |	T | | |
| terr_46 |	T | | |
| terr_47 |	T | | |
| terr_48 |	T | | |
| terr_49 |	F | | |
| terr_50 |	F |	[1 0] | 1X1 |
| terr_51 |	T | | |
| terr_52 |	T | | |
| terr_53 |	T | | |
| terr_54 |	T | | |
| terr_55 |	T | | 2X1 |
| terr_56 |	T | | |
| terr_57 |	T | | 2X2 |
| terr_58 |	T | | |
| terr_59 |	T | | |
| terr_60 |	NULL | | |
| terr_61 |	T | | |
| terr_62 |	F | [0 0] | 1X5 |
| terr_63 |	F | [-1 -1] [-1 0] [0 -1] [0 0] | 2X2 |
| terr_64 |	T | | |
| terr_65 |	T | | |
| terr_66 |	F | | |
| terr_67 |	T | | |
| terr_68 |	F | | |
| terr_69 |	F | | |
| terr_70 |	F | | |
| terr_71 |	F | | |
| terr_72 |	NULL | | |	
| terr_73 |	NULL | | |
| terr_74 |	F | | |
| terr_75 |	F	| [0 0] [0 1] [1 0] [1 1] [2 0] [2 1] |	3X2 |
| terr_76 |	T | | |
| terr_77 |	T | | |
| terr_78 |	T | | |
| terr_79 |	T | | |
| terr_80 |	NULL | | |
| terr_81 |	F | | |
| terr_82 |	F | | |
| terr_83 |	F | [0 0] [0 1] [0 2] [1 0] [1 1] [1 2] [2 0] [2 1] [2 2] |	3X3 |
| terr_84 |	T | | |
| terr_85 |	F | | |
| terr_86 |	F	| [-1 0] [1 0] | 3X1 |
| terr_87 |	F | | |
| terr_88 |	F | | |
| terr_89 |	NULL | | |
| terr_90 |	F | | |
| terr_91 |	F | | |
| terr_92 |	F | | |
| terr_93 |	F | | |
| terr_94 |	F | | |
| terr_95 |	F	| [-1 -1] [-1 0] [0 -1] [0 0] | 2X2 |
| terr_96 |	F | | |
| terr_97 |	F | | |
| terr_98 |	T | | |
| terr_99 |	F | | |
| terr_100 | T | | |
| terr_101 | T | | |
| terr_102 | T | | |
| terr_103 | T | | |
| terr_104 | F | | |
| terr_105 | F | | |
| terr_106 | F | | |
| terr_107 | F | | |
| terr_108 | F | | |
| terr_109 | F | | |
| terr_110 | T | | |
