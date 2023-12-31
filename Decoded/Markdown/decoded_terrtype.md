[Return to previous page](/Decoded/README.md#decoded-structure)

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

| Char | Priority | Effect                                    |
|------|----------|-------------------------------------------|
| N    | Lowest   | No effect, can drive over, can shoot thru |
| W    | Mid      | Can't drive over, can shoot thru          |
| F    | Highest  | Can't drive over, can't shoot thru        |
