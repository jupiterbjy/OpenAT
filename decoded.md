## TOC

1. [Game Objectives](Game-Objectives)
2. [Game Objects](Game-Objects)
3. [Event Objects](Event-Objects)
4. [Map Areas](Map-Areas)
5. [Map Notations](Map-Notations)

---

## Game Objectives (gametype)

| code | image | description kor | eng | note |
|-|-|-|-|-|
| B |![objective_destroy](https://github.com/jupiterbjy/OpenAT/assets/26041217/941b2cc2-c107-48de-9526-3c184c845d46)| 모든 적 파괴 | Destroy all enemies | |
| F |![objective_defend](https://github.com/jupiterbjy/OpenAT/assets/26041217/0c17115e-9a86-4e78-8619-18a0e95bbe91)| 기지 방어 | Defend your base | |
| H |![objective_box](https://github.com/jupiterbjy/OpenAT/assets/26041217/267bed54-3126-4786-942e-aaacc493cc45)| 모든 상자 줍기 | Pick up all boxes | 실제론 안주워도 클리어 지장 없음. 미구현? |
| T |![objective_bunker](https://github.com/jupiterbjy/OpenAT/assets/26041217/b3bc46f8-b2a8-48cc-be2c-a966c72c26c4)| 모든 벙커 파괴 | Destroy all bunkers | |

---

## Game Objects

| code | image | description |
|-|-|-|
| C |![00](https://github.com/jupiterbjy/OpenAT/assets/26041217/a388e1e9-e9e2-42ff-b623-613dbde57bfd)|! lock enemies|
| S |![01](https://github.com/jupiterbjy/OpenAT/assets/26041217/78c193eb-e4b9-41ff-a931-fbdfe02c1da1)|! invincibility|
| M |![02](https://github.com/jupiterbjy/OpenAT/assets/26041217/7b7b5bb6-c68d-4a3a-ad37-299d42d01c01)|Recovers tank hit points|
| L |![03](https://github.com/jupiterbjy/OpenAT/assets/26041217/812235bb-e13b-431d-8142-f6cf980cc778)|! construct stone walls around base|
| Z |![04](https://github.com/jupiterbjy/OpenAT/assets/26041217/0cbfb3ea-b594-49f2-aa5a-5b29e7772be4)|! lock enemy weapons|
| R |![05](https://github.com/jupiterbjy/OpenAT/assets/26041217/8d888a4a-0fd9-48b2-b781-1bc292006c94)| Temporarily improves shooting speed (does not work with max upgrade)|
| B |![08](https://github.com/jupiterbjy/OpenAT/assets/26041217/50748447-b60e-4925-b096-f6d3daad0b2e)|! damage all enemies on screen|
| I |![0](https://github.com/jupiterbjy/OpenAT/assets/26041217/5a034a77-d393-4985-9c56-f747bef81a8c)|! setup mines|
| X |![1](https://github.com/jupiterbjy/OpenAT/assets/26041217/53bcdf23-6693-4330-8b72-218a57393906)| Regenerate hit points over time |
| Y |![](https://github.com/jupiterbjy/OpenAT/assets/26041217/105c0c6c-3683-4c03-b822-827ec3fb450f)| Recovers enemy hit points |

---

## Event Objects

(Ordered by encounter during progression)

| code | image | description |
|-|-|-|
| 1 |![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/93b18098-a959-42c1-8b7b-144045bd2f47)| Bunker |
| 3 |![](https://github.com/jupiterbjy/OpenAT/assets/26041217/ca5ac4f3-92c4-47b9-8438-422a7ff820bf)| Box |
| 5 |![](https://github.com/jupiterbjy/OpenAT/assets/26041217/9eb70ec8-d86d-40e1-b58f-0ce179a1c962)| Reflector Angle 0 |
| 6 |![](https://github.com/jupiterbjy/OpenAT/assets/26041217/6f8e1e4d-d208-4c11-8dbd-7bf8d5df892a)| Reflector Angle 1 |
| 8 |![](https://github.com/jupiterbjy/OpenAT/assets/26041217/832acff0-37a3-488c-965d-e4cd1d608cea)| Heal Tower |
| 4 |![](https://github.com/jupiterbjy/OpenAT/assets/26041217/61dfdf89-d933-41d7-b785-bbf2ae26d4f4)| Turret |
| 7 |![](https://github.com/jupiterbjy/OpenAT/assets/26041217/9cff691b-6dc2-4a4d-8084-b19a278e5528)| Explosive |

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

## Map Notations

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

