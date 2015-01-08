# Nexus 4 navigation buttons fix
Fix making Nexus 4 navigation buttons alive after enigmatic hardware issue

Prebuilts available!

1. LRX22C (Android 5.0.1)

See [Releases](github.com/gkraynov/nexus-4-navfix/releases) to download `UPDATE.zip`. Verify your build number carefully! Wrong builds will not work.

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

Don't forget to save `UPDATE_ROLLBACK.zip` in a safe place. Once you see OTA update alert, flash rollback, update and repeat. Never try to apply OTA for patched files, rollback first!

Prerequesties:

1. Broken Nexus 4 (as on video)
2. Linux machine (tested on fresh Ubuntu)
3. ADB installed
4. Custom recovery (no root required)
