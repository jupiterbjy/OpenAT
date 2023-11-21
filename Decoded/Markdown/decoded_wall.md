[Return to previous page](/Decoded/README.md#decoded-structure)

## Wall Notations

### Note regarding & sign

Here's things (probably) sure about `& / 5 / 7 / 9` sign:
- Instructs enemy tanks to shoot at it when in-sight or next to it
- Acts as pathfinding lighthouse for tanks

But we're not sure why it sometimes spawn walls and sometimes not. I can't find any details seems to be specifying this behavior.

### Brick walls

- Contains 4 texture groups: C / R / W / Y and each has 0~3 textures for damaged effect

| code | code (target) | image                                                                                          | description            |
|------|---------------|------------------------------------------------------------------------------------------------|------------------------|
| #    | &             | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/2ffc2e0a-cbdd-415d-93d4-23a220e497ed) | Full health brick wall |
| 4    | 5             | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/77416ea4-6a40-47bc-ad77-741df339a14f) | Health 3 Wall          |
| 2?   | 7             | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/100960bf-d5f2-4b08-898d-b0d5283d6aae) | Health 2 Wall          |
| 0?   | 9             | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/d58aec7a-6893-4c92-b9f9-333434cbccc9) | Health 1 Wall          |

### Stone walls

- Contains 2 textures: TerrWall_G_O / Terr_01 - Seems like there's more dummy textures that might also is a stone wall.

| char | image                                                                                         | description |
|------|-----------------------------------------------------------------------------------------------|-------------|
| %    | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/ddea7d39-eec3-4052-8fcb-4d8cdb44d804)| Stone Wall  |
