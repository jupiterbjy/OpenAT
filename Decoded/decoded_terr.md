## Structure

Describes what's current tile's model alias(terrtype) & model configuration is.  

```text
terr { 
  ln 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1   
  ln 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1   
  ln 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1   
  ln 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1 6 N1   
  ...
  endterr
}
```

```text
terr {
  ln [terrtype alias] [args] ...
  ...
  endterr
}
```

Same for `terr2`, terminal is same too

```text
terr2 {
  ln [terrtype alias] [args] ...
  ...
  endterr
}
```

## Args

![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/be8102b9-2268-4a09-9418-01baf3f90c56)

| code  | effect                        | Image |
|-------|-------------------------------|-------|
| N     | Default - Bottom Right corner ||
| N1    | Clockwise 90                  ||
| N2    | Clockwise 180                 ||
| N12   | Clockwise 270                 ||
| N15   | Unknown                       ||
| N25   | Unknown                       ||
| N34   | z축으로 1칸상승                |![terr_35_N34](https://github.com/jupiterbjy/OpenAT/assets/45421813/76ac4bfa-9655-4f77-a620-a916402d9077)|
| N125  | Unknown                       ||
| N134  | Clockwise 90 + z축으로 1칸상승 |![terr_35_N134](https://github.com/jupiterbjy/OpenAT/assets/45421813/4025ca0d-bb39-4b92-92e2-6f4a59d26e87)|
| N234  | Clockwise 180 + z축으로 1칸상승|![terr_35_N234](https://github.com/jupiterbjy/OpenAT/assets/45421813/deae19dd-c7fb-492e-b0c6-c77e800373d5)|
| N235  | terr_256에만 붙음              ||
| N1234 | Clockwise 270 + z축으로 1칸상승|![terr_35_N1234](https://github.com/jupiterbjy/OpenAT/assets/45421813/4aff9592-ea34-43c1-b0f2-9fbc170ae618)|


Memo: 
- N15, N125, N25 is used with `terrtype` 0
- N34, N134, N234, N1234 is used with `terrtype` 35
- N235 is used with `terrtype` 256 which doesn't exist. Possibly alias for null.


## Unknown Args Output from RUIN/m1 in godot implementation

```text
[BaseTile] Unknown parameter N15 for (5, 0)
[BaseTile] Unknown parameter N1234 for (12, 0)
[BaseTile] Unknown parameter N134 for (15, 0)
[BaseTile] Unknown parameter N15 for (5, 1)
[BaseTile] Unknown parameter N34 for (9, 1)
[BaseTile] Unknown parameter N134 for (10, 1)
[BaseTile] Unknown parameter N1234 for (12, 1)
[BaseTile] Unknown parameter N134 for (15, 1)
[BaseTile] Unknown parameter N125 for (2, 2)
[BaseTile] Unknown parameter N25 for (3, 2)
[BaseTile] Unknown parameter N25 for (4, 2)
[BaseTile] Unknown parameter N15 for (5, 2)
[BaseTile] Unknown parameter N1234 for (9, 2)
[BaseTile] Unknown parameter N234 for (10, 2)
[BaseTile] Unknown parameter N234 for (11, 2)
[BaseTile] Unknown parameter N1234 for (12, 2)
[BaseTile] Unknown parameter N234 for (13, 2)
[BaseTile] Unknown parameter N234 for (14, 2)
[BaseTile] Unknown parameter N234 for (15, 2)
[BaseTile] Unknown parameter N25 for (17, 2)
[BaseTile] Unknown parameter N25 for (18, 2)
[BaseTile] Unknown parameter N25 for (19, 2)
[BaseTile] Unknown parameter N25 for (20, 2)
[BaseTile] Unknown parameter N25 for (0, 3)
[BaseTile] Unknown parameter N25 for (1, 3)
[BaseTile] Unknown parameter N15 for (2, 3)
[BaseTile] Unknown parameter N34 for (1, 4)
[BaseTile] Unknown parameter N134 for (2, 4)
[BaseTile] Unknown parameter N125 for (18, 4)
[BaseTile] Unknown parameter N5 for (19, 4)
[BaseTile] Unknown parameter N1234 for (1, 5)
[BaseTile] Unknown parameter N234 for (2, 5)
[BaseTile] Unknown parameter N25 for (18, 5)
[BaseTile] Unknown parameter N15 for (19, 5)
[BaseTile] Unknown parameter N125 for (0, 11)
[BaseTile] Unknown parameter N5 for (1, 11)
[BaseTile] Unknown parameter N25 for (0, 12)
[BaseTile] Unknown parameter N15 for (1, 12)
[BaseTile] Unknown parameter N125 for (18, 15)
[BaseTile] Unknown parameter N5 for (19, 15)
[BaseTile] Unknown parameter N25 for (18, 16)
[BaseTile] Unknown parameter N15 for (19, 16)
```
