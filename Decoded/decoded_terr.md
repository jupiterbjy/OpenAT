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

These codes stack, so N12 is N1 then N2, thus being 270-degree rotation.

| N code | effect             |
|--------|--------------------|
| (None) | Default            |
| 1      | Clockwise +90 deg  |
| 2      | Clockwise +180 deg |
| 3      | Vert. Pos. +?      |
| 4      | Vert. Pos. +?      |
| 5      | Vert. Pos. +?      |
