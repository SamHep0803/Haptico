#line 1 "Tweak.x"
#import <AudioToolbox/AudioToolbox.h>
#import <Cephei/HBPreferences.h>

UIImpactFeedbackGenerator* hapticGenerator;

BOOL volumeSwitch;
CGFloat volumeSlider;

static void callFeedback(int type) {
  UIImpactFeedbackStyle hapticStyle;
  volumeSlider = volumeSlider - 1;

  if (type == 0) {
    hapticStyle = UIImpactFeedbackStyleHeavy;
  } else if (type == 1) {
    hapticStyle = UIImpactFeedbackStyleLight;
  } else if (type == 2) {
    hapticStyle = UIImpactFeedbackStyleMedium;
  } else if (type == 3) {
    hapticStyle = UIImpactFeedbackStyleRigid;
  } else if (type == 4) {
    hapticStyle = UIImpactFeedbackStyleSoft;
  }
  if (hapticGenerator == nil) {
    hapticGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:hapticStyle];
  }

  if([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){13, 0, 0}]) {
    [hapticGenerator impactOccurred];
  } else {
    if (type == 0) {
      AudioServicesPlaySystemSound(1521);
    } else if (type == 1) {
      AudioServicesPlaySystemSound(1520);
    } else if (type == 2) {
      AudioServicesPlaySystemSound(1519);
    }
  }
}


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SBVolumeControl; 
static void (*_logos_orig$_ungrouped$SBVolumeControl$increaseVolume)(_LOGOS_SELF_TYPE_NORMAL SBVolumeControl* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBVolumeControl$increaseVolume(_LOGOS_SELF_TYPE_NORMAL SBVolumeControl* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$SBVolumeControl$decreaseVolume)(_LOGOS_SELF_TYPE_NORMAL SBVolumeControl* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBVolumeControl$decreaseVolume(_LOGOS_SELF_TYPE_NORMAL SBVolumeControl* _LOGOS_SELF_CONST, SEL); 

#line 41 "Tweak.x"


static void _logos_method$_ungrouped$SBVolumeControl$increaseVolume(_LOGOS_SELF_TYPE_NORMAL SBVolumeControl* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
  _logos_orig$_ungrouped$SBVolumeControl$increaseVolume(self, _cmd);
  if (volumeSwitch) {
    callFeedback(volumeSlider);
  }
}

static void _logos_method$_ungrouped$SBVolumeControl$decreaseVolume(_LOGOS_SELF_TYPE_NORMAL SBVolumeControl* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
  _logos_orig$_ungrouped$SBVolumeControl$decreaseVolume(self, _cmd);
  if (volumeSwitch) {
    callFeedback(volumeSlider);
  }
}


static __attribute__((constructor)) void _logosLocalCtor_7c1b35e5(int __unused argc, char __unused **argv, char __unused **envp) {
  HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"me.samhep.vibrationsplusprefs"];
  [preferences registerBool:&volumeSwitch default:YES forKey:@"volumeSwitch"];
  [preferences registerFloat:&volumeSlider default:1 forKey:@"volumeSlider"];
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBVolumeControl = objc_getClass("SBVolumeControl"); { MSHookMessageEx(_logos_class$_ungrouped$SBVolumeControl, @selector(increaseVolume), (IMP)&_logos_method$_ungrouped$SBVolumeControl$increaseVolume, (IMP*)&_logos_orig$_ungrouped$SBVolumeControl$increaseVolume);}{ MSHookMessageEx(_logos_class$_ungrouped$SBVolumeControl, @selector(decreaseVolume), (IMP)&_logos_method$_ungrouped$SBVolumeControl$decreaseVolume, (IMP*)&_logos_orig$_ungrouped$SBVolumeControl$decreaseVolume);}} }
#line 63 "Tweak.x"
