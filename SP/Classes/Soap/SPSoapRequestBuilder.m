//
//  SPSoapRequestBuilder.m
//  SP
//
//  Created by Whitman Yang on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SPSoapRequestBuilder.h"
#import "SPSimpleSoapRequest.h"
#import "SPCachedData.h"
#import "SPSoapRequest.h"
#import "SPGetListItemsRequest.h"

@implementation SPSoapRequestBuilder

+ (SoapRequest *) buildModeRequest {
    SPSimpleSoapRequest * request = [SPSimpleSoapRequest soapRequest];
    request.rootTagName = @"Mode";
    return request;
}

+ (SoapRequest *) buildAuthenticationRequest {
    SPSimpleSoapRequest * request = [SPSimpleSoapRequest soapRequest];
    request.rootTagName = @"Login";
    NSURLCredential * credential = [SPCachedData credential];
    [request addElement:@"username" withStringValue:[credential user]];
    [request addElement:@"password" withStringValue:[credential password]];
    return request;
}

+ (SoapRequest *) buildGetUserInfoRequest:(NSString *)userLoginName {
    SPSimpleSoapRequest * request = [SPSimpleSoapRequest soapRequestWithDirectoryNS];
    request.rootTagName = @"GetUserInfo";
    [request addElement:@"userLoginName" withStringValue:userLoginName];
    return request;
}

+ (SoapRequest *) buildListInfoRequest {
    SPSimpleSoapRequest * request = [SPSimpleSoapRequest soapRequest];
    request.rootTagName = @"GetListCollection";
    return request;
}

+ (SoapRequest *) buildGetListItemsRequest: (NSString *)listName withFolder: (NSString *)folder {
    if (!listName) {
        return nil;
    }
    SPGetListItemsRequest * request = [SPGetListItemsRequest soapRequest];
    request.listName = listName;
    request.folderName = folder;
    return request;
}                     

@end
