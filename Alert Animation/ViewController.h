//
//  ViewController.h
//  Alert Animation
//
//  Created by Hoang Thuan on 12/7/17.
//  Copyright © 2017 Hoang Thuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbAnimation;
@property (weak, nonatomic) IBOutlet UIImageView *imgAnimation;
@property (weak, nonatomic) IBOutlet UIView *viewAnimation;
- (IBAction)startAction:(id)sender;
- (IBAction)stopAction:(id)sender;
@end

