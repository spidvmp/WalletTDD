//
//  AGTDollarTest.m
//  Billetera
//
//  Created by Vicente de Miguel on 3/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AGTDollar.h"
#import "AGTMoney.h"


@interface AGTDollarTest : XCTestCase


@end

@implementation AGTDollarTest

-(void) testMultiplication {
    
    AGTDollar *five = [AGTMoney dollarWithAmount:5];
    AGTDollar *ten = [five times:2];
    AGTDollar *total = [AGTMoney dollarWithAmount:10];
    
    XCTAssertEqualObjects(total, ten, @"$5 *2 = 10$");
}

-(void) testEquality{
    AGTDollar *five = [AGTMoney dollarWithAmount:5];
    AGTDollar *ten = [AGTMoney dollarWithAmount:10];
    AGTDollar *total = [five times:2];
    XCTAssertEqualObjects(ten,total,@"objetos deberian ser iguales");
    
    XCTAssertFalse([total isEqual:five], @"los valores no son igules");
}

-(void)testHash{
    AGTDollar *a =[AGTMoney dollarWithAmount:3];
    AGTDollar *b = [AGTMoney dollarWithAmount:3];
    
    //el hash devuelve un entero largo sin signo
    XCTAssertEqual([a hash], [b hash], @"Equal objects must have same hash");
}


-(void)testAmountStorage{
    AGTDollar *dollar = [AGTMoney dollarWithAmount:2];
    
    //para acceder a la propiedad amount que es privada con @select
    
    //estos prgama son para eliminar warning indicado en el segundo pragma
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    XCTAssertEqual(2, [[dollar performSelector:@selector(amount)] integerValue],@"Value retrieve should be the same as the stored");
#pragma clang diagnostic pop
}
@end
