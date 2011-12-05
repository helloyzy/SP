//
//  UserInfo.h
//  SP
//
//  Created by spark pan on 12/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoapEntity.h"

@interface UserInfo : SoapEntity {
    NSString * userID;
    NSString * userName;
    NSString * loginName;
    NSString * email;
}

@property(nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSString * userName;
@property(nonatomic, retain) NSString * loginName;
@property (nonatomic, retain) NSString * email;


@end
