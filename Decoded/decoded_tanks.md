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

| code | image                                                                                          | health | note                    |
|------|------------------------------------------------------------------------------------------------|--------|-------------------------|
| 0    | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/65894c31-59a1-4b7f-9678-6bcafbe616e2) |        | Random upgrade & weapon |
| 1    | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/87a13735-3753-4137-8cf9-e078517c63e4) | 20     |                         |
| 2    | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/8a1c9219-a9f8-4095-9fd1-5549a36d408c) | 30     |                         |
| 3    | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/1870fb17-5b7a-4932-9101-3b7812c08972) | 40     |                         |
| 4    | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/7937a46e-c465-4ef9-b4d4-03dbfca90874) | 40     |                         |
| 5    | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/86a583ed-5ae8-40be-8d14-d012527599fb) | 50     |                         |
| 6    | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/34c952c4-86bc-47ea-b76d-59dc5fbfd863) | 30     |                         |
| 7    | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/03d551c2-a491-4e1c-aa4e-d5272c36ffb9) | 30     | Dummy Data              |
| 8    | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/135cd1cd-3a82-49be-a98a-8a9b51d93758) | 40     |                         |
| 9    | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/07779d3b-cfe9-4258-a831-39afcc2c31e0) | 40     |                         |
| KB   | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/e1da3596-a607-475c-a681-069ae002cfc6) | 1500   | Boss                    |
| LB   | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/d86a7840-97a1-4273-b800-2c002d2e169f) | 2000   | Boss                    | 
| SB   | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/eea5c4da-afea-40b5-b1d9-e38f1755a586) | 500    | Boss                    |

With Code S : health 2x, points 2x (Except Boss)

With Code L : health 3x, points 3x (Except Boss)

With Code K : health 4x, points 4x (Except Boss)

## attributes

| code         | image                                                                                          | description |
|--------------|------------------------------------------------------------------------------------------------|-------------|
| B            | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/9fe1739e-ab7b-4022-94a4-193e36833497) | Red (Skin)  |
| S            | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/9fe1739e-ab7b-4022-94a4-193e36833497) | Red         |
| L            | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/0d07b150-6d34-4fb1-ad5b-6f675b108ab3) | Blue        |
| K            | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/17308f7d-59e4-41c6-9853-d1a0942c7e6e) | Black       |
| I            | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/3af3344f-556e-44b3-8a95-75cb4814a71f) | Transparent |
| UNKNOWN      | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/2dd95927-4e0d-4ca1-874a-2a932481365a) | Item?       |
| (WhiteSpace) | NONE                                                                                           | 1 sec wait  |
| P            | NONE                                                                                           | 5 sec wait  |
| D            | NONE                                                                                           | 30 sec wait |
| H            |                                                                                                | ?           |
| T            |                                                                                                | ?           |
| C            |                                                                                                | ?           | 

