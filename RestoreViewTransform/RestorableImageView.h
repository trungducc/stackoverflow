//
//  RestorableImageView.h
//  RestoreViewTransform
//
//  Created by trungduc on 3/16/19.
//  Copyright © 2019 trungduc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RestorableImageView : UIImageView

@property (nonatomic, copy) NSString* restoreIdentifier;

- (void)restore;

@end

NS_ASSUME_NONNULL_END
