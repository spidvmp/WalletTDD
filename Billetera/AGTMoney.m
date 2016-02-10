//
//  AGTMoney.m
//  Billetera
//
//  Created by Vicente de Miguel on 3/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import "AGTMoney.h"
#import "AGTBroker.h"
#import "NSObject+GNUStepAddons.h"
//#import "AGTMoney-Private.h"
//#import "AGTEuro.h"
//#import "AGTDollar.h"

@interface AGTMoney()

@property (nonatomic, strong) NSNumber *amount;

@end


@implementation AGTMoney
+(id) euroWithAmount:(NSInteger) amount{
    return [[AGTMoney alloc] initWithAmount:amount currency:@"EUR"];
    
    
}
+(id) dollarWithAmount:(NSInteger) amount{
    return [[AGTMoney alloc]initWithAmount:amount currency:@"USD"];
    
}

-(id) initWithAmount:(NSUInteger) amount currency:(NSString *)currency{
    if ( self = [super init]) {
        _amount = @(amount);
        _currency = currency;
    }
    
    return self;
    
}
-(id <AGTMoney>) plus:(AGTMoney *)other {
    NSInteger totalAmount = [self.amount integerValue] + [other.amount integerValue];
    AGTMoney *total = [[AGTMoney alloc]initWithAmount:totalAmount currency:self.currency];
    return total;
}

-(id <AGTMoney>) reduceToCurrency:(NSString *)currency withBroker:(AGTBroker*) broker{
    AGTMoney *result;
    double rate = [[broker.rates objectForKey:[broker keyFromCurrency: self.currency toCurrency:currency]] doubleValue];
    //comproibamos que la divisa de origen y destino son las misma
    if ( [self.currency isEqual: currency]) {
        result = self;
    } else if (rate == 0) {
        //no hnay tasa de conversion.excepcion
        [NSException raise:@"NoConversionRateException" format:@"Must have a conversion from %@ to %@", self.currency, currency];
    } else {
        
        //double rate = [[self.rates objectForKey:[self keyFromCurrency:money.currency toCurrency:currency]] doubleValue];
        NSInteger  newAmount = [self.amount integerValue] * rate;
        result = [[AGTMoney alloc]initWithAmount:newAmount currency:currency];
    }
    return result;
}

//-(AGTMoney* )times:(NSUInteger) multiplier{
//    //return  [[AGTMoney alloc]initWithAmount:self.amount * multiplier];
//    //no deberia de llamarse nunca, habria que sobreescribir este metodo en cada subclase
//    
//    //_cmd es un parametro oculto que recibe todo metodo de objective C y que viene con el numero del selector
//    return [self subclassResponsability:_cmd];
//    
//}



-(id <AGTMoney>)times:(NSUInteger) multiplier{
    return  [[AGTMoney alloc] initWithAmount:self.amount.integerValue * multiplier currency:self.currency];
    
}

#pragma mark - Overwritten
-(NSString *) description {
    return [NSString stringWithFormat:@"<%@: %@ %@>", [self class], self.currency, self.amount];
}

-(BOOL)isEqual:(id)object {
    if ( [self.currency isEqual: [object currency]] ){
        return [self amount] == [object amount];
    } else {
        return NO;
    }
    
}

-(NSUInteger) hash{
    return [self.amount integerValue];
}
@end
