#import <AudioToolbox/AudioToolbox.h>

UIImpactFeedbackGenerator* hapticGenerator;

static void callFeedback(int type) {
  UIImpactFeedbackStyle hapticStyle;

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

  if([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){8, 0, 0}]) {
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

  callFeedback(1);
}

-(void)decreaseVolume {
  %orig;

  callFeedback(1);
}
%end
