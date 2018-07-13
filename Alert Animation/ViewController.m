//
//  ViewController.m
//  Alert Animation
//
//  Created by Hoang Thuan on 12/7/17.
//  Copyright © 2017 Hoang Thuan. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _viewAnimation.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    _viewAnimation.layer.cornerRadius = 25.0f;
    _imgAnimation.layer.cornerRadius = _imgAnimation.frame.size.height/2;
    _imgAnimation.layer.masksToBounds = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)startAction:(id)sender {
    
    NSString * htmlString = @"<html>"
    "  <head>"
    "    <style type='text/css'>"
    "      body { font: 16pt 'Gill Sans'; color: #1a004b; }"
    "      i { color: #822; }"
    "    </style>"
    "  </head>"
    "  <body>Here is some <i>formatting!</i> <a href='#'><font color='green'>Google</font></a><font color='red'> example text</font><a href='#'>YouTube</a><b> bold</b> and <i>italic</i></body>"
    "</html>";
    NSError *err = nil;
    NSAttributedString * attrStr = [[NSAttributedString alloc]
                                    initWithData: [htmlString dataUsingEncoding:NSUTF8StringEncoding]
                                    options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                    documentAttributes: nil
                                    error: &err];
    
    _viewAnimation.frame = CGRectMake(self.view.frame.size.width, _viewAnimation.frame.origin.y, _viewAnimation.frame.size.width, _viewAnimation.frame.size.height);
    _viewAnimation.hidden = NO;
    _lbAnimation.hidden = YES;
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(FLT_MAX, _lbAnimation.frame.size.height)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
        _viewAnimation.frame=CGRectMake(0, _viewAnimation.frame.origin.y, _viewAnimation.frame.size.width, _viewAnimation.frame.size.height);
    } completion:^(BOOL finished)
     {
         _lbAnimation.hidden = NO;
         _lbAnimation.attributedText = attrStr;
         _lbAnimation.frame = CGRectMake(self.view.frame.size.width, _lbAnimation.frame.origin.y, rect.size.width, _viewAnimation.frame.size.height);

       CGFloat duration = 6;
       CGFloat ratio = _viewAnimation.frame.size.width / (rect.size.width + _viewAnimation.frame.size.width);

       [UIView animateWithDuration:duration * ratio delay:duration * (1-ratio) + 0.1f options:UIViewAnimationOptionCurveLinear animations:^{
         _viewAnimation.frame = CGRectMake(_viewAnimation.frame.origin.x, _viewAnimation.frame.origin.y, 0, _viewAnimation.frame.size.height);
       } completion:^(BOOL finished) {
         _viewAnimation.hidden = YES;
       }];
         
       [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
         _lbAnimation.frame=CGRectMake(-rect.size.width, _lbAnimation.frame.origin.y, rect.size.width, _lbAnimation.frame.size.height);

       } completion:^(BOOL finished)
        {

        }];
         
     }];
}

- (IBAction)stopAction:(id)sender {
    _viewAnimation.hidden = YES;
}
@end
