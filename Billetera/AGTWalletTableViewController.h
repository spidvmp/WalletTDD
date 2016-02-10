//
//  AGTWalletTableViewController.h
//  Billetera
//
//  Created by Vicente de Miguel on 6/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGTWallet;

@protocol AddMoneyProtocol <NSObject>

-(void) dismissWithCurrency:(NSString *) currency amount:(NSInteger) amount andRate: (NSInteger) rate;

@end

@interface AGTWalletTableViewController : UITableViewController <AddMoneyProtocol>

-(id)initWithModel:(AGTWallet *) model;

@end
