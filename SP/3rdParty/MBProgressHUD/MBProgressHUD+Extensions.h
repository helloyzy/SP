//
//  MBProgressHUD+Extensions.h
//  SP
//
//  Created by Whitman Yang on 12/2/11.
//  Copyright (c) 2011 Per. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Extensions)

+ (void) showConfirmationMsg:(NSString *)msg withDelegate:(id<MBProgressHUDDelegate>)delegate;

@end
