//
//  AGTNetworkTest.m
//  Billetera
//
//  Created by Vicente de Miguel on 6/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AGTBroker.h"

@interface AGTNetworkTest : XCTestCase

@end

@implementation AGTNetworkTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testThatEmtyRatesDefaultToOneToOne {
    
    
}

-(void)testThatEmptyRatesRaisesException{
    AGTBroker *broker = [AGTBroker new];
    
    NSData *jsonData = nil;
    
    XCTAssertThrows([broker parseJSONData: jsonData], @"un json vacio provoca iuna excepcion");
    
}
@end
