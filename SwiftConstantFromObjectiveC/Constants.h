//
//  Constants.h
//  demoswift
//
//  Created by Trung Duc on 4/3/18.
//  Copyright © 2018 Trung Duc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DefinedObject NSObject
#define DefinedObjectString  NSStringFromClass(DefinedObject.class)

@interface Constants : NSObject

+ (NSString*)definedObjectString;

@end
