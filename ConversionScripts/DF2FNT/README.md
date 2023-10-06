## Armada Tanks *.df Font type converter

Fonts used in-game is like this:

![](https://github.com/jupiterbjy/OpenAT/assets/26041217/de60ab2d-9263-45d3-938f-9b30cb65afb8)


And some font type I never managed to search online about:

- [FontAdv_FD.df](df_fonts/224/FontAdv_FD_224.df)

---

Now I managed to somewhat reconstruct `.df` into AngelCode's BMFont format `.fnt`

![](output/FontAdv_FD_224_bordered.png)

Converted fonts are in [output](output) dir.


![](https://github.com/jupiterbjy/ProjectIncubator/assets/26041217/7318312f-a395-44d1-8679-20438a1b78bd)

Pretty similar, ey?

Unfortunately can't seem to adjust padding. Padding parameter does absolutely nothing in godot.

Maybe I need to adjust xadvance instead.
