//
//  AGTControllerTest.m
//  Billetera
//
//  Created by Vicente de Miguel on 6/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AGTSimpleViewController.h"
#import "AGTWalletTableViewController.h"
#import "AGTWallet.h"

@interface AGTControllerTest : XCTestCase
@property (strong,nonatomic) AGTSimpleViewController *simpleVC;
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) UILabel *label;

@property (strong,nonatomic) AGTWalletTableViewController *walletVC;
@property (strong,nonatomic) AGTWallet *wallet;


@end

@implementation AGTControllerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.simpleVC = [[AGTSimpleViewController alloc]initWithNibName:nil bundle:nil];
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button setTitle:@"Hola" forState:UIControlStateNormal];
    self.label = [[UILabel alloc]initWithFrame:CGRectZero];
    self.simpleVC.displayLabel = self.label;
    
    self.wallet = [[AGTWallet alloc]initWithAmount:1 currency:@"USD"];
    [self.wallet plus:[AGTMoney euroWithAmount:1]];
    self.walletVC = [[AGTWalletTableViewController alloc]initWithModel:self.wallet];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.simpleVC = nil;
    self.button = nil;
    self.label = nil;
    
    self.wallet = nil;
    self.walletVC = nil;
}

-(void)testThanTextOnLabelIsEqualToTextonButton{
    
    //somulamo el tocar el boton
    [self.simpleVC displayText:self.button];
    
    XCTAssertEqualObjects(self.button.titleLabel.text, self.label.text,@"button yu label tienen que tener el mismo valor");
    
    
}

-(void)testThanTableHasOneSection{
    
    NSInteger sections = [self.walletVC numberOfSectionsInTableView:nil];
    
    XCTAssertEqual(sections,1, @"sections debe de ser 1");
    
}

-(void)testThatNumberOfCellIsnumberOfMoneysPlusOne{
    
    XCTAssertEqual(self.wallet.count + 1, [self.walletVC tableView:nil numberOfRowsInSection:0], @"numero de celdas es el numero de monedas +1");
    
    
}


@end
