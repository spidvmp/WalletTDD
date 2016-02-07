//
//  AGTNSNotificationCenter.m
//  Billetera
//
//  Created by Vicente de Miguel on 6/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AGTWallet.h"
#import "AGTFakeNotificationCenter.h"

@interface AGTNSNotificationCenter : XCTestCase

@end

@implementation AGTNSNotificationCenter

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testThatSubscribesToMemoryWarning{
    
    AGTFakeNotificationCenter *nc = [AGTFakeNotificationCenter new];
    
    AGTWallet *w = [AGTWallet new];
    [w subscribeToMemoryWarning:(NSNotificationCenter *)nc];
    
    NSDictionary *obs = [nc observers];
    id observer = [obs objectForKey:UIApplicationDidReceiveMemoryWarningNotification];
    
    XCTAssertEqualObjects(observer, w ,@"w debe sustribirse al UIApplicationDidReceiveMemoryWarningNotification");
    
}
@end
