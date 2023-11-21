[Return to previous page](/Decoded/README.md#decoded-structure)

## Structure

```text
respawn { 
  rsp 0 8 4 
  rsp 1 12 4 
  rsp 2 2 2 
  rsp 3 2 2 
  rsp 4 5 16 
  rsp 5 8 16 
  rsp 6 13 16 
  rsp 7 15 16 
  endrespawn 
} 
```

```text
respawn {
  rsp [id] [x (from left)] [y (from bottom)]
  ...
  endrespawn
}
```


## ID

Those maps with 3 gate will have either two of 4~7 assigned to same tile.

| id | type         |
|----|--------------|
| 0  | Player spawn |
| 1  | Dummy        |
| 2  | Dummy        |
| 3  | Dummy        |
| 4  | Spawn Gate 1 |
| 5  | Spawn Gate 2 |
| 6  | Spawn Gate 3 |
| 7  | Spawn Gate 4 |

