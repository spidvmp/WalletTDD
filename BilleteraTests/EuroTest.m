//
//  EuroTest.m
//  Billetera
//
//  Created by Vicente de Miguel on 1/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AGTEuro.h"
#import "AGTMoney.h"

@interface EuroTest : XCTestCase

@end

@implementation EuroTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


-(void)testSimpleMultiplication{
    
    //me invento una clase
    AGTEuro * five = [AGTMoney euroWithAmount: 5];
    AGTEuro *ten = [AGTMoney euroWithAmount:10];
    AGTEuro *total = [five times:2];

    
    XCTAssertEqualObjects(ten, total, @"5€ * 2 son 10€");

}


-(void) testEquality{
    AGTEuro *five = [AGTMoney euroWithAmount:5];
    AGTEuro *ten = [AGTMoney euroWithAmount:10];
    AGTEuro *total = [five times:2];
    XCTAssertEqualObjects(ten,total,@"objetos deberian ser iguales");
    XCTAssertEqualObjects([AGTMoney dollarWithAmount:4], [[AGTMoney dollarWithAmount:2] times:2],@"objetos deberian ser iguales");
}

-(void) testDifferentCurrenies{
    AGTMoney *euro = [AGTMoney euroWithAmount:1];
    AGTMoney *dolar = [AGTMoney dollarWithAmount:1];
    
    XCTAssertNotEqualObjects(euro, dolar,@"differnets currenies");
    
}


-(void)testHash{
    AGTEuro *a = [AGTMoney euroWithAmount:3];
    AGTEuro *b = [AGTMoney euroWithAmount:3];
    
    //el hash devuelve un entero largo sin signo
    XCTAssertEqual([a hash], [b hash], @"Equal objects must have same hash");
}

-(void)testAmountStorage{
    AGTEuro *euro = [AGTMoney euroWithAmount:2];
    
    //para acceder a la propiedad amount que es privada con @select

    //estos prgama son para eliminar warnong indicado en e segundo pargama
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    XCTAssertEqual(2, [[euro performSelector:@selector(amount)] integerValue],@"Value retrieve should be the same as the stored");
#pragma clang diagnostic pop
}







@end
