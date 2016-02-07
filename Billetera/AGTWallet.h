//
//  AGTWallet.h
//  Billetera
//
//  Created by Vicente de Miguel on 6/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
#import "AGTMoney.h"


@interface AGTWallet : NSObject <AGTMoney>
@property (nonatomic, readonly) NSUInteger count;


-(void) subscribeToMemoryWarning:(NSNotificationCenter *)nc;
@end