//
//  AGTMoney.h
//  Billetera
//
//  Created by Vicente de Miguel on 3/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AGTMoney;
@class AGTBroker;

@protocol AGTMoney <NSObject>

-(id) initWithAmount:(NSUInteger) amount currency:(NSString *) currency;
-(id <AGTMoney>) times: (NSUInteger) multiplier;
-(id <AGTMoney>) plus: (AGTMoney *) other;
-(id <AGTMoney>) reduceToCurrency:(NSString *)currency withBroker:(AGTBroker*) broker;

@end

@interface AGTMoney : NSObject <AGTMoney>

@property (nonatomic, readonly) NSString *currency;
@property (nonatomic, strong, readonly) NSNumber *amount;

+(id) euroWithAmount:(NSInteger) amount;
+(id) dollarWithAmount:(NSInteger) amount;



@end
