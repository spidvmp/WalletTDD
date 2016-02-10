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

-(id <AGTMoney>) reduceToCurrency:(NSString *)currency withBroker:(AGTBroker *)broker {
    
    AGTMoney *result = [[AGTMoney alloc]initWithAmount:0 currency:currency];
    for (AGTMoney *each in self.moneys) {
        result = [result plus: [each reduceToCurrency:currency withBroker:broker]];
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

-(NSArray *) billsFromCurrency:(NSString *)currency {
    //filtro de moneys todos los billetes de una divisa y los devuelvo ordenados de mayor a menor
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"self.currency == %@",currency];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"amount" ascending:NO];
    NSArray *res = [[self.moneys filteredArrayUsingPredicate:pred] sortedArrayUsingDescriptors: @[descriptor]] ;
    return res;
}

-(NSInteger) sumCurrency:(NSString*) currency {
    //saco los billetes que hay de una divisa
    NSArray *hay = [self billsFromCurrency:currency];
    //hecho en falta un .reduce
    int sum = 0;
    for (AGTMoney *each in hay) {
        sum+=[each.amount intValue];
    }
    return sum;
}
-(NSInteger) sumWalletInCurrency:(NSString *)currency andBroker:(AGTBroker *) broker{
    //suma todos los valores traducidos a la divisa, solo lo haremos para euros

    AGTMoney *suma = [self reduceToCurrency:currency withBroker:broker];
    
    return [suma.amount integerValue];
}
-(void)deleteMoneyWithCurrency:(NSString *)currency andAmount:(NSInteger)amount{
    //hago la busqueda directamente sobre el self.moneys, ya que he de quitarlo de ahi. No puedo haceruna bisqueda xq el resultado es un array diferente, asi que me lo recorro a pelo. Algo muy efectivo
    for (int i=0; i< self.moneys.count ;i++){
        AGTMoney *each = [self.moneys objectAtIndex:i];
        if ( [each.currency isEqual: currency] && ( [each.amount intValue] == amount))
        {
            [self.moneys removeObjectAtIndex:i];
            i = self.moneys.count + 1;
        }
    }
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
