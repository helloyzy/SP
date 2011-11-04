//
//  SPSoapRequestBuilder.m
//  SP
//
//  Created by Whitman Yang on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SPSoapRequestBuilder.h"
#import "SPSimpleSoapRequest.h"

@implementation SPSoapRequestBuilder

+ (SoapRequest *) buildGetUserInfoRequest:(NSString *)userLoginName {
    SPSimpleSoapRequest * request = [SPSimpleSoapRequest soapRequest];
    request.rootTagName = @"GetUserInfo";
    [request addElement:@"userLoginName" withStringValue:userLoginName];
    return request;
}

+ (SoapRequest *) buildListInfoRequest {
    SPSimpleSoapRequest * request = [SPSimpleSoapRequest soapRequest];
    request.rootTagName = @"GetListCollection";
    return request;
}

@end
