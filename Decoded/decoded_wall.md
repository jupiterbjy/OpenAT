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
| #    | &             | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/b5db0908-622a-4e84-acab-9b7e0410ffab) | Full health brick wall |
| 4    | 5             | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/fb42a0ba-7f6b-4bc6-be9d-605cfd1705a4) | Health 3 Wall          |
| 2?   | 7             | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/23b5b447-c530-40b6-8dc7-d20c93aad017) | Health 2 Wall          |
| 0?   | 9             | ![](https://github.com/jupiterbjy/OpenAT/assets/45421813/ea8615e9-2be7-4109-a605-361af4d8332a) | Health 1 Wall          |

### Stone walls

- Contains 2 textures: TerrWall_G_O / Terr_01 - Seems like there's more dummy textures that might also is a stone wall.

| char | image                                                                                                             | description |
|------|-------------------------------------------------------------------------------------------------------------------|-------------|
| %    | ![Stone walls % image](https://github.com/jupiterbjy/OpenAT/assets/45421813/af138505-a547-4f4a-8b8f-3e1bb239a504) | Stone Wall  |
