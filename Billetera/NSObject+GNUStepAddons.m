//
//  NSObject+GNUStepAddons.m
//  Billetera
//
//  Created by Vicente de Miguel on 3/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import "NSObject+GNUStepAddons.h"
#import <objc/runtime.h>

@implementation NSObject (GNUStepAddons)


-(id) subclassResponsability: (SEL)aSel {
    char prefix = class_isMetaClass(object_getClass(self)) ? '+' : '-';
    [NSException raise: NSInvalidArgumentException format:@"%@%c%@ sould be overriden by its subclass",
     NSStringFromClass([self class]), prefix, NSStringFromSelector(aSel)];
    return self;
}
@end
