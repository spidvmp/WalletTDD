//
//  AGTBroker.h
//  Billetera
//
//  Created by Vicente de Miguel on 4/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGTMoney.h"

@interface AGTBroker : NSObject
@property ( nonatomic, strong) NSMutableDictionary *rates;

-(id<AGTMoney>) reduced:(id<AGTMoney>) money toCurrency:(NSString *) currency;
-(void)addRate:(NSInteger) rate fromCurrency:(NSString *)fromCurrency toCurrency:(NSString*) toCurrency;
-(NSString *)keyFromCurrency:(NSString*) fromCurrency toCurrency:toCurrecy;

-(void)parseJSONData:(NSData *) json;
@end
