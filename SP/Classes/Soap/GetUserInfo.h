//
//  GetUserInfo.h
//  TestSharePoint
//
//  Created by Whitman Yang on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoapEntity.h"

@interface GetUserInfo : SoapEntity

@property (nonatomic, retain) NSString * userLoginName;

@end
