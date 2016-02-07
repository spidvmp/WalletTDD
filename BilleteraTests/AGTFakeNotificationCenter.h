//
//  AGTFakeNotificationCenter.h
//  Billetera
//
//  Created by Vicente de Miguel on 6/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGTFakeNotificationCenter : NSObject

@property (nonatomic, strong) NSMutableDictionary *observers;
-(void)addObserver:(id)observer selector:(nonnull SEL)aSelector name:(nullable NSString *)aName object:(nullable id)anObject;

@end
