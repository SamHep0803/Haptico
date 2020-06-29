#import <AudioToolbox/AudioToolbox.h>
#import <Cephei/HBPreferences.h>

UIImpactFeedbackGenerator* hapticGenerator;

BOOL volumeSwitch;
CGFloat volumeSlider;


// Feedback shit that somehow actually works.
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

  /*if (type == 0) {
    hapticStyle = UIImpactFeedbackStyleHeavy;
    NSLog(@"vibration heavy");
  } else if (type == 1) {
    hapticStyle = UIImpactFeedbackStyleLight;
    NSLog(@"vibration light");
  } else if (type == 2) {
    hapticStyle = UIImpactFeedbackStyleMedium;
    NSLog(@"vibration medium");
  } else if (type == 3) {
    hapticStyle = UIImpactFeedbackStyleRigid;
    NSLog(@"vibration rigid");
  } else if (type == 4) {
    hapticStyle = UIImpactFeedbackStyleSoft;
    NSLog(@"vibration soft");
  }*/
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
  HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"me.samhep.hapticoprefs"];
  [preferences registerBool:&volumeSwitch default:YES forKey:@"volumeSwitch"];
  [preferences registerFloat:&volumeSlider default:0 forKey:@"volumeSlider"];
}
