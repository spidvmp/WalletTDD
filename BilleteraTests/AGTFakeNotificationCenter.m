//
//  AGTFakeNotificationCenter.m
//  Billetera
//
//  Created by Vicente de Miguel on 6/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import "AGTFakeNotificationCenter.h"

@implementation AGTFakeNotificationCenter

-(id)init {
    if ( self = [super init]){
        _observers = [NSMutableDictionary dictionary];
    }
    return self;
}

-(void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject {
    
    [self.observers setObject:observer forKey:aName];
}

@end
