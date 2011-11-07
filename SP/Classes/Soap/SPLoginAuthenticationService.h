//
//  SPLoginAuthenticationService.h
//  SP
//
//  Created by Whitman Yang on 11/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPSoapService.h"

@interface SPLoginAuthenticationService : SPSoapService

+ (void) resetAuthentication;

@end
