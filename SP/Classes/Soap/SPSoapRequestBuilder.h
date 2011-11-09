//
//  SPSoapRequestBuilder.h
//  SP
//
//  Created by Whitman Yang on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SoapRequest;

@interface SPSoapRequestBuilder : NSObject

+ (SoapRequest *) buildAuthenticationRequest;
+ (SoapRequest *) buildListInfoRequest;
+ (SoapRequest *) buildGetUserInfoRequest:(NSString *)userLoginName;
+ (SoapRequest *) buildModeRequest;

+ (SoapRequest *) buildGetListItemsRequest: (NSString *)listName withFolder: (NSString *)folder;

@end
