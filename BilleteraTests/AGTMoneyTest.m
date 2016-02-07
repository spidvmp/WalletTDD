//
//  AGTMoneyTest.m
//  Billetera
//
//  Created by Vicente de Miguel on 3/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AGTMoney.h"

@interface AGTMoneyTest : XCTestCase

@end

@implementation AGTMoneyTest

//-(void)testThatTimesRaisesException{
//    AGTMoney *money = [[AGTMoney alloc]initWithAmount:5];
//    XCTAssertThrows([money times:3],@"raise an exception");
//    
//}


-(void) testCurrencies{
    XCTAssertEqualObjects(@"EUR", [[AGTMoney euroWithAmount:1] currency],@"The currency of euro should be EUR");
    XCTAssertEqualObjects(@"USD", [[AGTMoney dollarWithAmount:1] currency],@"The currency of euro should be USD");
}



-(void)testSimpleMultiplication{
    
    //me invento una clase
    AGTMoney * five = [AGTMoney euroWithAmount: 5];
    AGTMoney *ten = [AGTMoney euroWithAmount:10];
    AGTMoney *total = [five times:2];
    
    
    XCTAssertEqualObjects(ten, total, @"5€ * 2 son 10€");
    
}

-(void)testSimpleAdding{

    
    XCTAssertEqualObjects([[AGTMoney dollarWithAmount:5] plus: [AGTMoney dollarWithAmount:5]],[AGTMoney dollarWithAmount:10], @"5+5 = 10");
    XCTAssertEqualObjects([[AGTMoney euroWithAmount:5] plus: [AGTMoney euroWithAmount:5]],[AGTMoney euroWithAmount:10], @"5+5 = 10");
    
}

-(void) testEquality{
    AGTMoney *five = [AGTMoney euroWithAmount:5];
    AGTMoney *ten = [AGTMoney euroWithAmount:10];
    AGTMoney *total = [five times:2];
    XCTAssertEqualObjects(ten,total,@"objetos deberian ser iguales");
    
    XCTAssertEqualObjects([AGTMoney dollarWithAmount:4], [[AGTMoney dollarWithAmount:2] times:2], @"objetos deberian ser iguales");
}



-(void)testHash{
    AGTMoney *a = [AGTMoney euroWithAmount:3];
    AGTMoney *b = [AGTMoney euroWithAmount:3];
    
    //el hash devuelve un entero largo sin signo
    XCTAssertEqual([a hash], [b hash], @"Equal objects must have same hash");
    XCTAssertEqual([[AGTMoney dollarWithAmount:4] hash], [[AGTMoney dollarWithAmount:4] hash], @"Equal objects must have same hash");
}

-(void)testAmountStorage{
    AGTMoney *euro = [AGTMoney euroWithAmount:2];
    
    //para acceder a la propiedad amount que es privada con @select
    
    //estos prgama son para eliminar warnong indicado en e segundo pargama
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    XCTAssertEqual(2, [[euro performSelector:@selector(amount)] integerValue],@"Value retrieve should be the same as the stored");
#pragma clang diagnostic pop
}

-(void)testThesHashIsAmount{
    
    AGTMoney *one = [AGTMoney dollarWithAmount:1];
    XCTAssertEqual([one hash], 1,@"El has debe ser igual al amount");
}

-(void)testDescription{
    AGTMoney *one = [AGTMoney dollarWithAmount:1];
    NSString *desc = @"<AGTMoney: USD 1>";
    XCTAssertEqualObjects(desc, [one description], "Description debe coincidir");
    
}

@end
