#line 1 "Tweak.x"
#import <AudioToolbox/AudioToolbox.h>
#import <Cephei/HBPreferences.h>

UIImpactFeedbackGenerator* hapticGenerator;

BOOL volumeSwitch;
CGFloat volumeSlider;



static void callFeedback(int type) {
  UIImpactFeedbackStyle hapticStyle;

  type = (int)volumeSlider;

  switch (type) {
    case 0:
      hapticStyle = UIImpactFeedbackStyleHeavy;
      NSLog(@"vibration heavy");
      break;
    case 1:
      hapticStyle = UIImpactFeedbackStyleLight;
      NSLog(@"vibration light");
      break;
    case 2:
      hapticStyle = UIImpactFeedbackStyleMedium;
      NSLog(@"vibration medium");
      break;
    case 3:
      hapticStyle = UIImpactFeedbackStyleRigid;
      NSLog(@"vibration rigid");
      break;
    case 4:
      hapticStyle = UIImpactFeedbackStyleSoft;
      NSLog(@"vibration soft");
      break;
    default:
      hapticStyle = UIImpactFeedbackStyleMedium;
      NSLog(@"vibration medium");
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

#line 75 "Tweak.x"


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


static __attribute__((constructor)) void _logosLocalCtor_de8539e1(int __unused argc, char __unused **argv, char __unused **envp) {
  HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"me.samhep.hapticoprefs"];
  [preferences registerBool:&volumeSwitch default:YES forKey:@"volumeSwitch"];
  [preferences registerFloat:&volumeSlider default:0 forKey:@"volumeSlider"];
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBVolumeControl = objc_getClass("SBVolumeControl"); { MSHookMessageEx(_logos_class$_ungrouped$SBVolumeControl, @selector(increaseVolume), (IMP)&_logos_method$_ungrouped$SBVolumeControl$increaseVolume, (IMP*)&_logos_orig$_ungrouped$SBVolumeControl$increaseVolume);}{ MSHookMessageEx(_logos_class$_ungrouped$SBVolumeControl, @selector(decreaseVolume), (IMP)&_logos_method$_ungrouped$SBVolumeControl$decreaseVolume, (IMP*)&_logos_orig$_ungrouped$SBVolumeControl$decreaseVolume);}} }
#line 97 "Tweak.x"
