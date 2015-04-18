# Nexus 4 navigation buttons fix

## Android 5.1

Resource file format was a little bit changed in Android 5.1 and **this SCPIRT is not functional anymore for 5.1+ images**. Despite the fact I've completed UPDATE for LMY47O (5.1) stock image (yes, you CAN flash UPDATE.zip if you run official 5.1 Nexus image). I hope to pass code review for persistent patch and this sh*t will remain as history.

Update for 5.1 in prebuils/releases section uses another approach to fix this problem and irrelevant with patching manual. If you have any 5.1 image differ from Google's one, I'm sorry there is no easy solution for you. I've posted [Patch](https://android-review.googlesource.com/#/c/147266) into AOSP and awaiting response from maintainers. I can't really predict outcome of this review but upon success it will cover the problem for all users aofter OTA update (obviously after merging the patch by Google).

## Prebuilts ##

1. LMY47O (Android 5.1)
2. LRX22C (Android 5.0.1)
3. LRX21T (Android 5.0)

See [Releases](https://github.com/gkraynov/nexus-4-navfix/releases) to download `UPDATE.zip`. Verify your build number carefully! Wrong builds will not work.

If you are not familiar with flashing zips on you phone, there is comprehensive [Tutuorial](http://status301.net/how-to-fix-nexus-4-unresponsive-soft-navigation-menu-buttons), thanks RavanH.

## About

Fix making Nexus 4 navigation buttons alive after enigmatic hardware issue

About the issue http://www.youtube.com/watch?v=Gu_CF4X9xOI (not my video)

Creepy solution http://www.androidpure.com/fix-nexus-4-soft-touch-buttons-keys-working

## The root of issue

I had no believe on hardware-only root of issue. During digging inside touchscreen driver inside AOSP I've found deadzone processing. What does it mean? Immagine that you're typing a message and accidentialy clicks on navigation bar. This click could cause undesirable experience, but deadzone have some timeout after your last action and accidential touches should be ignored.

~~Unfortunately, Nexus 4 touchscreen could process deadzone in a wrong way after enigmatic hardware issue. This cause that deadzone locking locks same touch region forever. The easiest way to overcome this damn is disabling deadzone at all. It's exactly my script does!~~

The root of issue is flooring tiny strip of touchscreen down to permanent deadzone. But I can't predict outcome of code review for permanent anti-bug woorkaround.

## Automated solution

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

N.B. If you still having problems, try to install the following packages on your system
```
curl libc6-i386 lib32z1
```

## Manual patching

If you are hacker in mind or automated solution didn't work for you there is alternative option:

1. Pull exact copies of the following files (from phone or system image)
```
/system/framework/framework-res.apk
/system/priv-app/SystemUI/SystemUI.apk
```
2. Place these files into `stock` directory alongside the scripts
3. Run `./patch.sh`
4. Extract `UPDATE.zip`
5. Replace `/system/priv-app/SystemUI/SystemUI.apk` with the new one
6. Reboot

## Bugs and feedback

If you've found bug the ideal way is making pull request ;) But you can also contact me directly.

Since I'm very limited in testing set please try the following environment before claiming the bug:

1. Common Linux distribution (tested on Ubuntu and Arch)
2. Bash shell
3. LRX22C build without any patches (from [Google Nexus](https://developers.google.com/android/nexus/images))
4. Unlocked bootloader
5. ClockworkMod recovery (tested on 6.0.4.7 non-touch)

Please try manual patching as well for troubleshooting. Obviously, you're very welcome to report minor bugs.

**Please send me experience feedback on Mac OS X, I don't now anything about Mac compatibily.**

Contact email: [github@gkraynov.com](mailto:github@gkraynov.com)
