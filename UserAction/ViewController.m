//
//  ViewController.m
//  UserAction
//
//  Created by Trung Duc on 7/13/18.
//  Copyright © 2018 Trung Duc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  UIBarButtonItem* backButton = [[UIBarButtonItem alloc] initWithTitle:@"Click me" style:UIBarButtonItemStylePlain target:self action:@selector(buttonClickMeDidTouch:)];
  self.navigationItem.leftBarButtonItem = backButton;
}

- (IBAction)buttonClickMeDidTouch:(id)sender {
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
