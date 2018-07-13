//
//  ViewController.m
//  TabBarPresent
//
//  Created by Trung Duc on 7/13/18.
//  Copyright © 2018 Trung Duc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnPush;
@property (weak, nonatomic) IBOutlet UIButton *btnPresent;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnPushDidTouch:(id)sender {
  ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"viewController"];
  [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnPresentDidTouch:(id)sender {
  ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"viewController"];
  vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
  [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)btnDismissDidTouch:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
