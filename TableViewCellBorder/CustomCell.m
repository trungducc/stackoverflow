//
//  CustomCell.m
//  DemoTableViewCellBorder
//
//  Created by Trung Duc on 12/13/17.
//  Copyright © 2017 Trung Duc. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
  [super awakeFromNib];

  self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)layoutIfNeeded {
  [super layoutIfNeeded];

  self.containerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
  self.containerView.layer.borderWidth = 1.f;
  self.containerView.layer.cornerRadius = self.containerView.frame.size.height / 2;
}

@end
