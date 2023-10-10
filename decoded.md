![3](https://github.com/jupiterbjy/OpenAT/assets/45421813/041c51e8-ade2-4eb6-abb8-7a8b11f8ff69)![M](https://github.com/jupiterbjy/OpenAT/assets/45421813/8a13de63-a7fa-4efc-bd67-86f631e43c94)## TOC

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
| 5 |![5](https://github.com/jupiterbjy/OpenAT/assets/45421813/ac906f2c-f491-4524-949a-df574406e86b)|
 Reflector Angle 0 |
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
|0|![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/bbfbc334-6509-4d8b-8653-4bb51d007313)|Random upgrade & weapon, not sure about weapon's chance - seen a lot of flamethrower and not a single pluse cannon.|
|1|![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/b81eb933-d13c-4e09-828a-303e1cbd73c5)||
|2|![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/c657e2c0-ad1e-482a-a514-2740baffcffe)||
|3|![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/66b4a990-1cae-4884-b83d-42848daff297)||
|4|![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/c87bd145-0982-422c-a337-030e9ffb08d6)||
|5|![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/de06fee0-cefe-4b59-9b9d-e61f2c4cef90)||
|6|![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/0718d3ed-a780-4a9a-9773-dc9fe48d36ff)||
|7|![image](https://github.com/jupiterbjy/OpenAT/assets/45421813/9384ce73-bfbd-4bca-b563-5820e72a0b0c)||
|8|![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/baccff0f-4160-4e85-8566-ea0b4b4b5a6b)||
|9|![image](https://github.com/jupiterbjy/OpenAT/assets/45421813/951034cd-aa1d-4ab7-ba6f-26f4391a9aa5)||


### attributes
| code | description | image |
|-|-|-|
| B, S | 빨간색 |![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/55ccef79-f540-459f-8d04-166ee15be7f9)|
| L | 하늘색 |![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/9a721677-338f-4647-84fb-11931330b2bd)|
| K | 검정색 |![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/a52f2a3f-b2f7-49d1-ad59-6daac0ac8165)|
| I | 투명 |![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/954373b5-9886-417c-b7be-2505a4205656)|
| ? | 아이템? |![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/ba46278c-b3a8-4024-888c-507a7cd1295a)|
| P | 5초간 다음 적 탱크 소환 안됨 |
| H | ? |
| D | 30초간 다음 적 탱크 소환 안됨 |
| T | ? |
| C | ? |
| DDD | 2분간 다음 적 탱크 소환 안됨 |
| HKB (2HKB?) | 특수전차(앞에 어떤 숫자가 붙던지 상관없이 HKB가 나오면 무조건 이 전차가 나옴) | ![2HKBDD](https://github.com/jupiterbjy/OpenAT/assets/45421813/1335abc2-cd91-4142-ad29-2a5dace6f832)|
| HLB (2HLB?) | EGYPT m5 에서 등장 |![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/60c3bb59-806d-48e9-96d6-395bae908592)|

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
|CAST/m4|![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/08704d01-59b8-45e4-b112-4caed68a2a6f)|![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/c43f8790-2f25-422b-8613-27956c07654a)|
|RUIN/m4|![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/ce51f49c-1518-4d7c-a91d-7b39d45d49be)|![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/27c84155-b076-46e2-98fc-0b6b45362ecd)|


### Brick walls

- Contains 4 texture groups: C / R / W / Y and each has 0~3 textures for damaged effect

| char | char(enemy target) | image | description |
| - | - | - | - |
| # | & |![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/e02dfd1d-2eb1-41a0-97e1-a49e37e18b3b)| Full health brick wall |
| 4 | 5 |![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/fe5ce410-3284-425f-92d1-c57da450481e)| Health 3 Wall |
| 2? | 7 |![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/24e1ca2c-b88f-41ff-9258-389619da3eac)| Health 2 Wall |
| 0? | 9 |![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/6fdd4f59-e31f-42db-b7f7-f45bba2036a9)| Health 1 Wall |


### Stone walls

- Contains 2 textures: TerrWall_G_O / Terr_01 - Seems like there's more dummy textures that might also is a stone wall.

| char | image | description |
| - | - | - |
| % | ![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/14335471-2a5c-48e1-8a32-3c6b02521b6f) | Stone Wall |

## Terrain Notation

There's bunch of unknown stuffs here.

![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/14f06b88-429f-4560-94ee-cba3c1c34ba3)

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
