//
//  CustomWindow.m
//  UserAction
//
//  Created by Trung Duc on 11/12/17.
//  Copyright © 2017 Trung Duc. All rights reserved.
//

#import "CustomWindow.h"

@implementation CustomWindow

- (void)sendEvent:(UIEvent *)event {
  UITouch *touch = [[event allTouches] anyObject];

  switch ([touch phase]) {
    case UITouchPhaseBegan:
    {
      NSLog(@"Touch Began");
    }
      break;
    case UITouchPhaseMoved:
      NSLog(@"Touch Move");
      break;
    case UITouchPhaseEnded:
    {
      NSLog(@"Touch End");
      // Check if touch ends inside view (UIControlEventTouchUpInSide)
      if (CGRectContainsPoint(CGRectMake(0, 0, touch.view.frame.size.width, touch.view.frame.size.height), [touch locationInView:touch.view])) {

        // Only log info of UIControl objects
        if ([touch.view isKindOfClass:[UIControl class]]) {
          [self logViewInfo:(UIControl *)touch.view];
        }
      }
    }
      break;
    case UITouchPhaseCancelled:
      NSLog(@"Touch Cancelled");
      break;
    default:
      break;
  }
  [super sendEvent:event];
}

- (void)logViewInfo:(UIControl *)clickedButton {
  NSString *frontMostViewcontrollerClassName = NSStringFromClass(self.topViewController.class);
  NSString *targetClassName = NSStringFromClass([[clickedButton.allTargets anyObject] class]);
  NSString *selectorName =[[clickedButton actionsForTarget:[clickedButton.allTargets anyObject] forControlEvent:UIControlEventTouchUpInside] firstObject];
  NSString *senderClassName = NSStringFromClass(clickedButton.class);

  NSLog(@"UI Front-most view controller: %@\nInteraction Action [%@ %@] by sender %@ control event UIControlEventTouchUpInSide", frontMostViewcontrollerClassName, targetClassName, selectorName, senderClassName);
}

- (UIViewController*)topViewController {
  return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)viewController {
  if ([viewController isKindOfClass:[UITabBarController class]]) {
    UITabBarController* tabBarController = (UITabBarController*)viewController;
    return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
  } else if ([viewController isKindOfClass:[UINavigationController class]]) {
    UINavigationController* navContObj = (UINavigationController*)viewController;
    return [self topViewControllerWithRootViewController:navContObj.visibleViewController];
  } else if (viewController.presentedViewController && !viewController.presentedViewController.isBeingDismissed) {
    UIViewController* presentedViewController = viewController.presentedViewController;
    return [self topViewControllerWithRootViewController:presentedViewController];
  }
  else {
    for (UIView *view in [viewController.view subviews])
    {
      id subViewController = [view nextResponder];
      if ( subViewController && [subViewController isKindOfClass:[UIViewController class]])
      {
        if ([(UIViewController *)subViewController presentedViewController]  && ![subViewController presentedViewController].isBeingDismissed) {
          return [self topViewControllerWithRootViewController:[(UIViewController *)subViewController presentedViewController]];
        }
      }
    }
    return viewController;
  }
}

@end
