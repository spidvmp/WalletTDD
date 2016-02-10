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
#import "AGTMoney.h"
#import "AGTBroker.h"

@interface AGTControllerTest : XCTestCase
@property (strong,nonatomic) AGTSimpleViewController *simpleVC;
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) UILabel *label;

@property (strong,nonatomic) AGTWalletTableViewController *walletVC;
@property (strong,nonatomic) AGTWallet *wallet;
@property (strong,nonatomic) AGTBroker *broker;


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
    
    self.broker = [AGTBroker new];
    
    //valores de wallet
    self.wallet = [[AGTWallet alloc]initWithAmount:1 currency:@"USD"];
    [self.wallet plus:[AGTMoney euroWithAmount:1]];
    [self.wallet plus:[AGTMoney euroWithAmount:4]];
    [self.wallet plus:[[AGTMoney alloc] initWithAmount:54 currency:@"JPY"]];
    
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
    
    XCTAssertEqualObjects(self.button.titleLabel.text, self.label.text,@"button y label tienen que tener el mismo valor");
    
    
}

//-(void)testThanTableHasOneSection{
//    Este test ya no sirve, habra tantas secciones como divisas + 1
//    
//    NSInteger sections = [self.walletVC numberOfSectionsInTableView:nil];
//    
//    XCTAssertEqual(sections,1, @"sections debe de ser 1");
//
//}

//-(void)testThatNumberOfCellIsnumberOfMoneysPlusOne{
//    
//    XCTAssertEqual(self.wallet.count + 1, [self.walletVC tableView:nil numberOfRowsInSection:0], @"numero de celdas es el numero de monedas +1");
// 
//}

-(void)testSameSectionsThanCurrencies{
    
    NSInteger sections = [self.walletVC numberOfSectionsInTableView:nil];
    
    
    XCTAssertEqual(sections, 4, "Las secciones de la tabla deben ser 4");
}

-(void)testNumberOfCurrencies{
    NSInteger sections = [[self.wallet currencies] count];
    XCTAssertEqual(sections, 3, "Deben haber 3 secciones");
}
-(void)testNumberOfRowsForCurrency{
    
    NSInteger rowseuro = [self.walletVC tableView:nil numberOfRowsInSection:0];
    XCTAssertEqual(rowseuro, 3,@"Deben haber 3 rows en Euro, 2 de monedas y una de total");
    NSInteger rowsdollar = [self.walletVC tableView:nil numberOfRowsInSection:2];
    XCTAssertEqual(rowsdollar, 2, @"Deben habr 2 rows en Dollar, 1 de moneda y otra de total");
    
}

-(void)testTitleForCurrency{
    
    AGTMoney *primera  = [[self.wallet currencies] objectAtIndex:0];
    AGTMoney *segunda  = [[self.wallet currencies] objectAtIndex:1];
    
    XCTAssertEqualObjects(primera, @"EUR",@"euro deberia ir primero");
    XCTAssertEqualObjects(segunda, @"JPY", @"JPY deberia ir segunda");
}

-(void)testNumberOfBillsInCurrrency{
    
    NSArray *eur = [self.wallet billsFromCurrency:@"EUR"];
    NSArray *dol = [self.wallet billsFromCurrency:@"USD"];
    
    XCTAssertEqual([eur count], 2, @"tienen que haber 2 billetes de euro");
    XCTAssertEqual([dol count], 1, @"tiene que haber un billete de dolar");
}

-(void)testSumAmount{
    NSInteger sum = [self.wallet sumCurrency:@"EUR"];
    XCTAssertEqual(sum, 5, @"deben sumar 5 los euros");

    
}

-(void)testsumWallet{
    //devuelve la suma de todas las monedas en una divisa, solo lo haremos para euros
    
    [self.broker addRate:2 fromCurrency:@"USD" toCurrency:@"EUR"];
    [self.broker addRate:3 fromCurrency:@"JPY" toCurrency:@"EUR"];
    NSInteger eur = [self.wallet sumWalletInCurrency:@"EUR" andBroker:self.broker];
    XCTAssertEqual(eur, 169, "Las suma de divisas debe ser 169");
}

-(void)testdeleteMoney{
    
    NSUInteger hay = self.wallet.count;
    [self.wallet deleteMoneyWithCurrency:@"EUR" andAmount:1];

    XCTAssertEqual(self.wallet.count, hay - 1, @"He borrado el otro bollete");
}


@end
