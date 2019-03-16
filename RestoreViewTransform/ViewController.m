//
//  ViewController.m
//  RestoreViewTransform
//
//  Created by coccoc on 3/15/19.
//  Copyright © 2019 trungduc. All rights reserved.
//

#import "ViewController.h"
#import "RestorableImageView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet RestorableImageView *transformTarget;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _transformTarget.restoreIdentifier = @"_transformTarget";
    [_transformTarget restore];
}

@end
