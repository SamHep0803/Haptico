#import <AudioToolbox/AudioToolbox.h>
#import <Cephei/HBPreferences.h>

UIImpactFeedbackGenerator* hapticGenerator;

BOOL volumeSwitch;
CGFloat volumeSlider;

static void callFeedback(int type) {
  UIImpactFeedbackStyle hapticStyle;

  type = (int)roundf(volumeSlider);

  if (type == 0) {
    hapticStyle = UIImpactFeedbackStyleHeavy;
    NSLog(@"heavy");
  } else if (type == 1) {
    hapticStyle = UIImpactFeedbackStyleLight;
    NSLog(@"light");
  } else if (type == 2) {
    hapticStyle = UIImpactFeedbackStyleMedium;
    NSLog(@"medium");
  } else if (type == 3) {
    hapticStyle = UIImpactFeedbackStyleRigid;
    NSLog(@"rigid");
  } else if (type == 4) {
    hapticStyle = UIImpactFeedbackStyleSoft;
    NSLog(@"soft");
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

%hook SBVolumeControl

-(void)increaseVolume {
  %orig;
  if (volumeSwitch) {
    callFeedback(volumeSlider);
  }
}

-(void)decreaseVolume {
  %orig;
  if (volumeSwitch) {
    callFeedback(volumeSlider);
  }
}
%end

%ctor {
  HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"me.samhep.vibrationsplusprefs"];
  [preferences registerBool:&volumeSwitch default:YES forKey:@"volumeSwitch"];
  [preferences registerFloat:&volumeSlider default:1 forKey:@"volumeSlider"];
}
