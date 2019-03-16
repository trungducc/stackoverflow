//
//  RestorableImageView.m
//  RestoreViewTransform
//
//  Created by trungduc on 3/16/19.
//  Copyright © 2019 trungduc. All rights reserved.
//

#import "RestorableImageView.h"

@interface RestorableImageView () <UIGestureRecognizerDelegate>

@end

@implementation RestorableImageView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGesture.maximumNumberOfTouches = 1;
    panGesture.delegate = self;
    [self addGestureRecognizer:panGesture];
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationGesture:)];
    rotationGesture.delegate = self;
    [self addGestureRecognizer:rotationGesture];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    pinchGesture.delegate = self;
    [self addGestureRecognizer:pinchGesture];
}

#pragma mark - Restore

- (void)restore {
  if (!_restoreIdentifier || !self.superview) {
    return;
  }

  NSString* transformString = [[NSUserDefaults standardUserDefaults]
      objectForKey:[NSString
                       stringWithFormat:@"%@.transform", _restoreIdentifier]];
  CGAffineTransform transform =
      transformString ? CGAffineTransformFromString(transformString)
                      : CGAffineTransformIdentity;

  NSString* centerString = [[NSUserDefaults standardUserDefaults]
      objectForKey:[NSString
                       stringWithFormat:@"%@.center", _restoreIdentifier]];
  CGPoint center =
      centerString ? CGPointFromString(centerString) : self.superview.center;

  self.center = center;
  self.transform = transform;
}

- (void)saveCurrentState {
  if (!_restoreIdentifier) {
    return;
  }
  [[NSUserDefaults standardUserDefaults]
      setObject:NSStringFromCGAffineTransform(self.transform)
         forKey:[NSString
                    stringWithFormat:@"%@.transform", _restoreIdentifier]];
  [[NSUserDefaults standardUserDefaults]
      setObject:NSStringFromCGPoint(self.center)
         forKey:[NSString stringWithFormat:@"%@.center", _restoreIdentifier]];
}

#pragma mark - Handle gestures

- (void)handlePanGesture:(UIPanGestureRecognizer*)gesture {
    CGPoint translation = [gesture translationInView:self.superview];
    CGPoint newCenter = CGPointMake(self.center.x + translation.x, self.center.y + translation.y);
    
    if (CGRectContainsPoint(self.superview.frame, newCenter)) {
        self.center = newCenter;
        [gesture setTranslation:CGPointZero inView:self.superview];
        [self saveCurrentState];
    }
}

- (void)handleRotationGesture:(UIRotationGestureRecognizer*)gesture {
    self.transform = CGAffineTransformRotate(self.transform, gesture.rotation);
    gesture.rotation = 0;
    
    [self saveCurrentState];
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer*)gesture {
    self.transform = CGAffineTransformScale(self.transform, gesture.scale, gesture.scale);
    gesture.scale = 1;
    
    [self saveCurrentState];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
