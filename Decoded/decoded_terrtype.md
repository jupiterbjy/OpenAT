## Structure

Acts as alias lookup table converting 0~111 model ID to name in `model.scr`.

We assume this probably was done so resulting map size be smaller and (relatively) easier to read.

Also defines which model is allowed to be drivable, shoot-able or not.

```text
terrtype { 
  type 0 TERR0 NWF
  type 1 TERR1 NWF
  ... 
}
```

```text
terrtype {
    type [idx] [model name in model.scr] [args]
}
```

## Args

Higher priority overrides lower priority

| Char | Priority | Possible Alias | Effect                                    |
|------|----------|----------------|-------------------------------------------|
| N    | Lowest   | Normal?        | No effect, can drive over, can shoot thru |
| W    | Mid      | Water?         | Can't drive over, can shoot thru          |
| F    | Highest  | BulletProof?   | Can't drive over, can't shoot thru        |
