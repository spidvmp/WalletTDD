//
//  AGTBrokenTest.m
//  Billetera
//
//  Created by Vicente de Miguel on 4/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AGTMoney.h"
#import "AGTBroker.h"

@interface AGTBrokenTest : XCTestCase
@property(nonatomic, strong) AGTBroker *emptyBroker;
@property (nonatomic, strong) AGTMoney *oneDollar;
@end

@implementation AGTBrokenTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.emptyBroker = [AGTBroker new];
    self.oneDollar = [AGTMoney dollarWithAmount:1];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.emptyBroker = nil;
    self.oneDollar = nil;
}

-(void)testSimpleReduction{
    

    AGTMoney *sum = [[AGTMoney dollarWithAmount:5] plus:[AGTMoney dollarWithAmount:5]];
    
    AGTMoney *reduced = [self.emptyBroker reduced:sum toCurrency: @"USD"];
    XCTAssertEqualObjects(sum, reduced, @"Conversion to same currency should be a NOP");
}

-(void)testReduction{
    

    [self.emptyBroker addRate:2 fromCurrency:@"EUR" toCurrency:@"USD"];
    
    
    AGTMoney *dollars = [AGTMoney dollarWithAmount:10];
    AGTMoney *euros = [AGTMoney euroWithAmount:5];
    
    AGTMoney *converted = [self.emptyBroker reduced:dollars toCurrency:@"EUR"];
    
    XCTAssertEqualObjects(converted, euros, @"$10 = €5");
    
}

-(void)testThatNoRatesException{
    XCTAssertThrows([self.emptyBroker reduced:self.oneDollar toCurrency:@"EUR"], "Sin ratios hay una excepcion");
    
}

-(void)testThatNilConversionDoesNotChangeMoney{
    
    XCTAssertEqualObjects(self.oneDollar, [self.emptyBroker reduced:self.oneDollar toCurrency:@"USD"], "cambio a la misma moneda debe devuelvee lo mismo");
    
}

@end
