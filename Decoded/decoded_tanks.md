## Structure

Type 1
```text
tank 12 2PPP  2 2 2D 2 1   2 1D 2 2  2 2T 1T 1DD  2 2H 1 2 3TC 2 2 2
```

Type 2
```text
tank 72  

8KC 9SC 8KC 9SCDDD 

1 2 8C 2 1C 2 1 3 1 2 8C 2 1CD

1 2 1C 2 8C 2 1 3 1 2DD 

8SC 2K 1SCDD 0

1H 2 1C 2 8C 2 1H 3 1H 2 8C 2 1C 2 1H 3 1H 2 8C 2 1CD

1 2 1C 2 8C 2 1 3 1 2 8C 2 1C 2 1 3 1 2 8C 2 1C

```

Seems to ignore newline. Might be better implementing lexical analyzer in future

```text
tank [tank count]
[tank type][tank attributes] ...
```



## type code



| code | image                                                                                            | default health | Code S(Red) | Code L(Sky) | Code K(Black) | note                    |
|------|--------------------------------------------------------------------------------------------------|----------------|-------------|-------------|---------------|-------------------------|
| 0    | ![0](https://github.com/jupiterbjy/OpenAT/assets/45421813/54048e45-9f29-4c6d-bbbf-03d16bd88b23)  |                |             |             |               | Random upgrade & weapon |
| 1    | ![1](https://github.com/jupiterbjy/OpenAT/assets/45421813/842c9f02-6b39-43e4-b87e-40416abec7a8)  | 20             | 40           | 60           | 80             |                         |
| 2    | ![2](https://github.com/jupiterbjy/OpenAT/assets/45421813/3bf1de98-4ea6-488a-8352-b754171382e4)  | 30             | 60           | 90           | 120            |                         |
| 3    | ![3](https://github.com/jupiterbjy/OpenAT/assets/45421813/52f5f127-65dd-4f32-938e-269aacf4eeaa)  | 40             | 80           | 120          | 160            |                         |
| 4    | ![4](https://github.com/jupiterbjy/OpenAT/assets/45421813/cae3af19-80c4-49fb-8660-ffc051c0b36a)  | 40             | 80           | 120          | 160            |                         |
| 5    | ![5](https://github.com/jupiterbjy/OpenAT/assets/45421813/09a4d842-cad4-4b91-b93c-6b640213a862)  | 50             | 100          | 150           | 200            |                         |
| 6    | ![6](https://github.com/jupiterbjy/OpenAT/assets/45421813/b900c2f3-49fe-42c0-a983-c3db8def67d9)  | 30             | 60          | 90          | 120           |                         |
| 7    | ![7](https://github.com/jupiterbjy/OpenAT/assets/45421813/cd6eb1ad-9aad-42cc-b87e-7161a992cbe9)  | 30             | 60           | 90           | 120            | Dummy Data              |
| 8    | ![8](https://github.com/jupiterbjy/OpenAT/assets/45421813/61a6935f-4c7b-4ad4-b6fd-74ee517f9e1e)  | 40             | 80          | 120          | 160            |                         |
| 9    | ![9](https://github.com/jupiterbjy/OpenAT/assets/45421813/b6e5798f-ae68-4505-8687-bb862b94f8a0)  | 40             | 80          | 120          | 160            |                         |
| SB   | ![SB](https://github.com/jupiterbjy/OpenAT/assets/45421813/e0f1c082-e37f-410e-b6b0-3b1cf83e6323) | 1500           | None        | None        | None          | Boss                    |
| LB   | ![LB](https://github.com/jupiterbjy/OpenAT/assets/45421813/018961e2-9ca2-429a-bd3b-ba5ae47d7529) | 2000           | None        | None        | None          | Boss                    |
| KB   | ![KB](https://github.com/jupiterbjy/OpenAT/assets/45421813/119eec7f-6e30-45a4-86ad-851ecf1f55b0) | 500            | None        | None        | None          | Boss                    |

With Code S : health 2x, points 2x (Except Boss)

With Code L : health 3x, points 3x (Except Boss)

With Code K : health 4x, points 4x (Except Boss)


---

## Tank Damage

| code  | damage |
|-------|--------|
| 1     | 25     |
| 2     | 25     |
| 3     | 25     |
| 4     | complex     |
| 5     | 40     |
| 6     | 80     |
| 7     | 25     |
| 8     | 17     |
| 9     | 20     |
| KB    | 30     |
| LB    | 13     |
| SB    | 30     |



## attributes

| code         | image                                                                                           | description |
|--------------|-------------------------------------------------------------------------------------------------|-------------|
| B            | ![B](https://github.com/jupiterbjy/OpenAT/assets/45421813/ee5047be-9788-425b-8962-8af6be69b388) | Red (Skin)  |
| S            | ![S](https://github.com/jupiterbjy/OpenAT/assets/45421813/a516b7c7-83f2-4bec-ab43-bbd4837f2b6f) | Red         |
| L            | ![L](https://github.com/jupiterbjy/OpenAT/assets/45421813/2c19b2ce-f939-409b-9a71-c4ad884398e8) | Blue        |
| K            | ![K](https://github.com/jupiterbjy/OpenAT/assets/45421813/4e53c421-6437-45c0-83ee-06fde827486d) | Black       |
| I            | ![I](https://github.com/jupiterbjy/OpenAT/assets/45421813/5803639b-4743-4d1d-a736-7e8af8b6c175) | Transparent |
| UNKNOWN      | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/b3d517b3-b539-4e86-95ae-be01d5a68679)  | Item?       |
| (WhiteSpace) | NONE                                                                                            | 1 sec wait  |
| P            | NONE                                                                                            | 5 sec wait  |
| D            | NONE                                                                                            | 30 sec wait |
| DDD          | NONE                                                                                            | 2 min wait  |
| H            |                                                                                                 | ?           |
| T            |                                                                                                 | ?           |
| C            |                                                                                                 | ?           | 

