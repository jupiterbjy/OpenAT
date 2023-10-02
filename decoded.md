## game objectives (gametype)

| code | image | description kor | eng | note |
|-|-|-|-|-|
| B |![objective_destroy](https://github.com/jupiterbjy/OpenAT/assets/26041217/941b2cc2-c107-48de-9526-3c184c845d46)| 모든 적 파괴 | Destroy all enemies | |
| F |![objective_defend](https://github.com/jupiterbjy/OpenAT/assets/26041217/0c17115e-9a86-4e78-8619-18a0e95bbe91)| 기지 방어 | Defend your base | |
| H |![objective_box](https://github.com/jupiterbjy/OpenAT/assets/26041217/267bed54-3126-4786-942e-aaacc493cc45)| 모든 상자 줍기 | Pick up all boxes | 실제론 안주워도 클리어 지장 없음. 미구현? |
| T |![objective_bunker](https://github.com/jupiterbjy/OpenAT/assets/26041217/b3bc46f8-b2a8-48cc-be2c-a966c72c26c4)| 모든 벙커 파괴 | Destroy all bunkers | |

---

## game objects

### items
| code | image | description |
|-|-|-|
| C |![00](https://github.com/jupiterbjy/OpenAT/assets/26041217/a388e1e9-e9e2-42ff-b623-613dbde57bfd)|! lock enemies|
| S |![01](https://github.com/jupiterbjy/OpenAT/assets/26041217/78c193eb-e4b9-41ff-a931-fbdfe02c1da1)|! invincibility|
| M |![02](https://github.com/jupiterbjy/OpenAT/assets/26041217/7b7b5bb6-c68d-4a3a-ad37-299d42d01c01)|Recovers tank hit points|
| L |![03](https://github.com/jupiterbjy/OpenAT/assets/26041217/812235bb-e13b-431d-8142-f6cf980cc778)|! construct stone walls around base|
| Z |![04](https://github.com/jupiterbjy/OpenAT/assets/26041217/0cbfb3ea-b594-49f2-aa5a-5b29e7772be4)|! lock enemy weapons|
| R |![05](https://github.com/jupiterbjy/OpenAT/assets/26041217/8d888a4a-0fd9-48b2-b781-1bc292006c94)|! Faster firing rate (does not work with max upgrade)|
| B |![08](https://github.com/jupiterbjy/OpenAT/assets/26041217/50748447-b60e-4925-b096-f6d3daad0b2e)|! damage all enemies on screen|
| I |![0](https://github.com/jupiterbjy/OpenAT/assets/26041217/5a034a77-d393-4985-9c56-f747bef81a8c)|! setup mines|
| X |![1](https://github.com/jupiterbjy/OpenAT/assets/26041217/53bcdf23-6693-4330-8b72-218a57393906)|Regenerate hit points over time|

- R : 총탄(일시적으로 장전 속도 증가)
- M : 메디킷(체력 회복)
- C : 시계(적 움직임 정지)
- B : 폭탄(적 전체 데미지)
- S : 방패(일시적 적 공격 무효화)

### event objects
| code | image | description |
|-|-|-|
| Y |![2](https://github.com/jupiterbjy/OpenAT/assets/26041217/105c0c6c-3683-4c03-b822-827ec3fb450f)|! heal enmeies|

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
|9?|![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/43b905a6-4505-41b2-9a48-9f80994e2e1d)|todo: 파란 개틀링 찾기|

### attributes
| code | description | image |
|-|-|-|
| S | 빨간색 |![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/55ccef79-f540-459f-8d04-166ee15be7f9)|
| ? | 하늘색 |![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/9a721677-338f-4647-84fb-11931330b2bd)|
| K | 검정색 |![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/a52f2a3f-b2f7-49d1-ad59-6daac0ac8165)|
| I | 투명 |![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/954373b5-9886-417c-b7be-2505a4205656)|
| ? | 아이템? |![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/ba46278c-b3a8-4024-888c-507a7cd1295a)|
| P | 다음 전차 스폰 1초 지연? |
| H | ? |
| B | ? |
| D | ? |
| T | ? |
| C | ? |
| L | ? |
| HKB | 특수전차(앞에 어떤 숫자가 붙던지 상관없이 HKB가 나오면 무조건 이 전차가 나옴) | ![2HKBDD](https://github.com/jupiterbjy/OpenAT/assets/45421813/1335abc2-cd91-4142-ad29-2a5dace6f832)|

### bosses
| combined code | image | note |
|-|-|-|
|2HLBD|![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/60c3bb59-806d-48e9-96d6-395bae908592)|EGYPT m5 에서 등장|
|2HKBDD?|![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/9b498a50-7f9d-4226-8a18-141c34ccf708)|todo: 이미지가 코드와 동일한 차량인지 확인|
