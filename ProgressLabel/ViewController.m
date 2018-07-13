//
//  ViewController.m
//  ProgressLabel
//
//  Created by Trung Duc on 7/13/18.
//  Copyright © 2018 Trung Duc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *trackLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressLabelWidthConstraint;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat currentProgress;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  self.progressLabel.lineBreakMode = NSLineBreakByClipping;
}

- (void)setProgress:(CGFloat)percent {
  percent = MAX(0, percent);
  percent = MIN(percent, 1);

  _currentProgress = percent;

  [UIView animateWithDuration:0.01f delay:0.f options:UIViewAnimationOptionRepeat animations:^{
    self.progressLabelWidthConstraint.constant = percent * self.trackLabel.frame.size.width;
    [self.progressLabel layoutIfNeeded];
  } completion:nil];
}

- (IBAction)btnStartDidTouch:(id)sender {
  self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f repeats:YES block:^(NSTimer * _Nonnull timer) {
    [self setProgress:self.currentProgress];

    if (self.currentProgress < 1) {
      self.currentProgress += 0.01f;
    } else {
      [self.timer invalidate];
    }
  }];
}

- (IBAction)btnPauseDidTouch:(id)sender {
  [self.timer invalidate];
}

- (IBAction)btnClearDidTouch:(id)sender {
  [self.timer invalidate];
  [self setProgress:0];
}

@end
