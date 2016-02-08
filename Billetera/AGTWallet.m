//
//  AGTWallet.m
//  Billetera
//
//  Created by Vicente de Miguel on 6/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import "AGTWallet.h"

@interface AGTWallet ()
@property (strong,nonatomic) NSMutableArray *moneys;

@end

@implementation AGTWallet
-(NSUInteger ) count {
    return [self.moneys count];
}

-(id) initWithAmount:(NSUInteger)amount currency:(NSString *)currency {
    if ( self = [super init] ) {
        AGTMoney *money = [[AGTMoney alloc] initWithAmount:amount currency:currency];
        _moneys = [NSMutableArray array];
        [_moneys addObject:money];
    }
    return self;
}


-(id<AGTMoney>) plus:(AGTMoney *)other {
    [self.moneys addObject:other];
    return self;
}

-(id<AGTMoney>) times:(NSUInteger)multiplier{
    NSMutableArray *newMoneys = [NSMutableArray arrayWithCapacity:self.moneys.count];
    for (AGTMoney *each in self.moneys){
        AGTMoney *newMoney = [each times:multiplier];
        [newMoneys addObject:newMoney];
    }
    self.moneys = newMoneys;
    return self;
}

-(id <AGTMoney>) reduceToCurrency:(NSString *)currency withBorker:(AGTBroker *)broker {
    
    AGTMoney *result = [[AGTMoney alloc]initWithAmount:0 currency:currency];
    for (AGTMoney *each in self.moneys) {
        result = [result plus: [each reduceToCurrency:currency withBorker:broker]];
    }
    
    return result;
}

-(AGTMoney*) objectAtIndexPath:(NSIndexPath *)ip {
    //teniendo el indexpath, devuelvo el billete que hay en esa posicion
    if ( ip.row >= [self.moneys count])
        return nil;
    else
    return [self.moneys objectAtIndex:ip.row];
}

-(NSArray* )currencies {
    //no es la forma mas efectiva, pero no es lo que estamospracticando
    //recorre todo el wallet y se queda con las monedas distintas que hay, despues las ordena alfabetocamente y devuelve el array, asi que con esto tb sacamos lo nombres de las secciones
    //creo un NSSet para poner todas las distintas monedas que hay, pueden haber monedas repetidas, asi me las quito de un plumazo
    NSMutableSet *monedas =[[NSMutableSet alloc]init];
    for (AGTMoney *each in self.moneys) {
        [monedas addObject:each.currency];
    }
    //ahor genero el array ordenado por el currency
    NSArray *res = [[monedas allObjects] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] ;
    return res;
}

//esto es para la prueba del singleton
-(void)subscribeToMemoryWarning:(NSNotificationCenter *)nc {
    [nc addObserver:self
           selector:@selector(dumpToDisk:)
               name: UIApplicationDidReceiveMemoryWarningNotification
             object:nil];
    
    
}

-(void)dumpToDisk:(NSNotification *) notification {
    
}
@end
