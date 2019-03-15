//
//  ViewController.m
//  RestoreViewTransform
//
//  Created by coccoc on 3/15/19.
//  Copyright © 2019 trungduc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *transformTarget;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self restoreFromSavedState];

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGesture.maximumNumberOfTouches = 1;
    panGesture.delegate = self;
    [_transformTarget addGestureRecognizer:panGesture];

    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationGesture:)];
    rotationGesture.delegate = self;
    [_transformTarget addGestureRecognizer:rotationGesture];

    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    pinchGesture.delegate = self;
    [_transformTarget addGestureRecognizer:pinchGesture];
}

- (void)restoreFromSavedState {
    NSString *transformString = [[NSUserDefaults standardUserDefaults] objectForKey:@"_transformTarget.transform"];
    CGAffineTransform transform = transformString ? CGAffineTransformFromString(transformString) : CGAffineTransformIdentity;

    NSString *centerString = [[NSUserDefaults standardUserDefaults] objectForKey:@"_transformTarget.center"];
    CGPoint center = centerString ? CGPointFromString(centerString) : self.view.center;

    _transformTarget.center = center;
    _transformTarget.transform = transform;
}

- (void)saveCurrentState {
    [[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGAffineTransform(_transformTarget.transform) forKey:@"_transformTarget.transform"];
    [[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGPoint(_transformTarget.center) forKey:@"_transformTarget.center"];
}

#pragma mark - Handle gestures

- (void)handlePanGesture:(UIPanGestureRecognizer*)gesture {
    CGPoint translation = [gesture translationInView:self.view];
    CGPoint newCenter = CGPointMake(_transformTarget.center.x + translation.x, _transformTarget.center.y + translation.y);

    if (CGRectContainsPoint(self.view.frame, newCenter)) {
        _transformTarget.center = newCenter;
        [gesture setTranslation:CGPointZero inView:self.view];

        [self saveCurrentState];
    }
}

- (void)handleRotationGesture:(UIRotationGestureRecognizer*)gesture {
    _transformTarget.transform = CGAffineTransformRotate(_transformTarget.transform, gesture.rotation);
    gesture.rotation = 0;

    [self saveCurrentState];
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer*)gesture {
    _transformTarget.transform = CGAffineTransformScale(_transformTarget.transform, gesture.scale, gesture.scale);
    gesture.scale = 1;

    [self saveCurrentState];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
