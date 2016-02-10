//
//  AddMoney.h
//  Billetera
//
//  Created by Vicente de Miguel on 10/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGTWalletTableViewController.h"
@class AGTMoney;
@interface AddMoney : UIViewController

@property (strong,nonatomic) AGTMoney *money;
@property (weak,nonatomic) AGTWalletTableViewController *delegate;

@end
