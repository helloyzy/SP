//
//  GetUserInfoService.h
//  TestSharePoint
//
//  Created by Whitman Yang on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoapServiceBase.h"

@class GetUserInfo;

@interface GetUserInfoService : SoapServiceBase

@property (nonatomic, retain) GetUserInfo * userInfo;

- (void) request;

@end
