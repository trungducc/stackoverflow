//
//  DetectTouchWindow.m
//  DemoDetectTouch
//
//  Created by Trung Duc on 11/6/17.
//  Copyright © 2017 Trung Duc. All rights reserved.
//

#import "DetectTouchWindow.h"

@implementation DetectTouchWindow

- (void)sendEvent:(UIEvent *)event {
  UITouch *touch = [[event allTouches] anyObject];

  switch ([touch phase]) {
    case UITouchPhaseBegan:
      NSLog(@"Touch Began");
      break;
    case UITouchPhaseMoved:
      NSLog(@"Touch Move");
      break;
    case UITouchPhaseEnded:
      NSLog(@"Touch End");
      break;
    case UITouchPhaseCancelled:
      NSLog(@"Touch Cancelled");
      break;
    default:
      break;
  }

  [super sendEvent:event];
}

@end
