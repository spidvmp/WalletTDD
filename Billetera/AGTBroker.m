//
//  AGTBroker.m
//  Billetera
//
//  Created by Vicente de Miguel on 4/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import "AGTBroker.h"



@implementation AGTBroker
-(id)init {
    if (self == [super init]) {
        _rates = [@{} mutableCopy];
    }
    return self;
}

-(id <AGTMoney>) reduced:(id<AGTMoney>)money toCurrency:(NSString *)currency {
    
    return [money reduceToCurrency: currency withBroker: self];
}

-(void) addRate:(NSInteger)rate fromCurrency:(NSString *)fromCurrency toCurrency:(NSString *)toCurrency{
    [self.rates setObject:@(rate) forKey:[self keyFromCurrency:fromCurrency toCurrency:toCurrency]];
    [self.rates setObject:@(1.0/rate) forKey:[self keyFromCurrency:toCurrency toCurrency:fromCurrency]];
    
}

-(NSString *)keyFromCurrency:(NSString*) fromCurrency toCurrency:toCurrecy{
    return [NSString stringWithFormat:@"%@%-@",fromCurrency, toCurrecy];
    
}

-(void)parseJSONData:(NSData *)json{
    NSError *err = nil;
    id obj = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:&err];
    if ( obj != nil) {
        //pillamos los rates los añadimos al broker
    } else {
        //no hemos recibido nada
        [NSException raise:@"NoRatesInJSONException" format:@"JSON debe llevar algo de informacion"];
    }
}


@end
