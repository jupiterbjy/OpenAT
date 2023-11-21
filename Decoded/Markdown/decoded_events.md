[Return to previous page](/Decoded/README.md#decoded-structure)

## Structure

```text
eventobj { 
  evob 7 13 15 
  evob 7 13 13 
  evob 7 13 11 
  evob 7 17 8 
  evob 7 13 5 
  evob 7 9 5 
  evob 7 5 5 
  evob 7 5 7 
  evob 7 9 10 
  evob 7 6 11 
  evob 7 8 14 
  evob 7 15 7 
  evob 7 7 8 
  evob 7 18 4 
  evob 7 18 6 
  endeventobj 
} 
```

```text
eventobj {
  evob [Event Object Type] [X] [Y]
  ...
  endeventobj
}
```


## Event Object Types

When Bunker, Turret and Heal Tower break, play Explosion.wav

| code | image                                                                                           | description       | sound |
|------|-------------------------------------------------------------------------------------------------|-------------------|-------|
| 1    | ![1](https://github.com/jupiterbjy/OpenAT/assets/45421813/3036cde4-4039-4d31-9f55-65be5f97fc85) | Bunker            | Dest-FT.wav |
| 3    | ![3](https://github.com/jupiterbjy/OpenAT/assets/45421813/1e683755-ab45-422d-9f31-a8c7d000480d) | Box               | BoxTake.wav |
| 4    | ![4](https://github.com/jupiterbjy/OpenAT/assets/45421813/c73da44e-0e95-4d81-97cb-d9f1ab9554d6) | Turret            | Dest-FT.wav |
| 5    | ![5](https://github.com/jupiterbjy/OpenAT/assets/45421813/4628c865-abf8-465a-8776-8a562ddffdf8) | Reflector Angle 0 | Dest-FT.wav |
| 6    | ![6](https://github.com/jupiterbjy/OpenAT/assets/45421813/60e29598-6ab2-4817-b6c0-31308e29255c) | Reflector Angle 1 | Dest-FT.wav |
| 7    | ![7](https://github.com/jupiterbjy/OpenAT/assets/45421813/e05d55fb-6afa-4e1d-b878-43e75105dc7b) | Explosive         | ExplosionNuc.wav |
| 8    | ![8](https://github.com/jupiterbjy/OpenAT/assets/45421813/4348e3ff-b351-4d44-b702-dd60ef624e13) | Heal Tower        | Dest-FT.wav |



