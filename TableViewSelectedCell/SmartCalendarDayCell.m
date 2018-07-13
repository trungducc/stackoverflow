//
//  SmartCalendarDayCell.m
//  DemoSelectedCell
//
//  Created by Trung Duc on 3/31/18.
//  Copyright © 2018 Trung Duc. All rights reserved.
//

#import "SmartCalendarDayCell.h"

@implementation SmartCalendarDayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

  self.day.textColor = [UIColor lightGrayColor];
}

- (void)setSelected:(BOOL)selected {
  [super setSelected:selected];

  if (selected) {
    self.day.textColor = [UIColor redColor];
  } else {
    self.day.textColor = [UIColor lightGrayColor];
  }
}

@end
