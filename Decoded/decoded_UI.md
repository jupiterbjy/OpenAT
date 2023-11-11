
- Help의 경우엔 뒤에 숫자가 0,1,2,3만 들어올 수 있고, 4 이상이 들어올경우 무조건 깨진다.

- 뒤에 붙에있는 수 만큼 맨 처음 화면에서 코드에 해당하는 아이템을 설명한다.

- Help에서 나오는 아이템 외에도 필드에 다른 아이템이 나올 때도 있다.

- 모든 맵 파일에서 message는 message F 코드만 존재한다.


1-2 (RUIN -2) 에서
Help 3 X M S 일때

![1-2](https://github.com/jupiterbjy/OpenAT/assets/45421813/47fc86b7-ae07-4e1d-97d4-60041044fdce)

Help 2 X M 의 경우
![1-2 2](https://github.com/jupiterbjy/OpenAT/assets/45421813/6a094e83-45f2-49a5-8dec-be9ca355a326)


## Header Section

```text
txt [텍스트 순서] [인물]
...
```
## 인물 code

개인 설치경로\Armada Tanks\game data\BaseT\Message 폴더 내의 모든 txt파일의 경우 게임 켜질때만 로딩됨

| code | image                                                                                                      | note |
|------|------------------------------------------------------------------------------------------------------------|------|
| 0    | ![Face_trans_0](https://github.com/jupiterbjy/OpenAT/assets/45421813/4a56b845-355e-499e-b7af-e0631571a877) |      |
| 1    | ![Face_trans_1](https://github.com/jupiterbjy/OpenAT/assets/45421813/f2320563-4db6-41fa-8c17-3e2c385a3791) |      |
| 2    | ![Face_trans_2](https://github.com/jupiterbjy/OpenAT/assets/45421813/7dd06209-a793-4073-8b51-93f94fc14a2a) |      |
| 3    | ![Face_trans_3](https://github.com/jupiterbjy/OpenAT/assets/45421813/c4f28de0-a79a-4e46-958b-68e78ef9e126) | 로딩 시 UI화면 깨짐 |


## Game Objects

Help Code, items code는 아래 표 code를 그대로 사용함

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