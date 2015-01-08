# Nexus 4 navigation buttons fix
Fix making Nexus 4 navigation buttons alive after enigmatic hardware issue

About the issue http://www.youtube.com/watch?v=Gu_CF4X9xOI (not my video)

Creepy solution http://www.androidpure.com/fix-nexus-4-soft-touch-buttons-keys-working

I had no believe on hardware-only root of issue. During digging inside touchscreen driver inside AOSP I've found deadzone processing. What does it mean? Immagine that you're typing a message and accidentialy clicks on navigation bar. This click could cause undesirable experience, but deadzone have some timeout after your last action and accidential touches should be ignored.

Unfortunately, Nexus 4 touchscreen could process deadzone in a wrong way after enigmatic hardware issue. This cause that deadzone locking locks same touch region forever. The easiest way to overcome this damn is disabling deadzone at all. It's exactly my script does!

I think that no deadzone is better than permanent dead area :D

To fix your phone, just connect it via ADB (Developer Options - USB debugging) and
```
$ git clone ...
$ ./all.sh
```

Flash `UPDATE.zip` via custom recovery. Enjoy!

Prerequesties:

1. Broken Nexus 4 (as on video)
2. Linux machine (tested on fresh Ubuntu)
3. ADB installed
4. Custom recovery (no root required)
