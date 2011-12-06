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
#import "SPUpdateItemRequest.h"
#import "Base64.h"

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

+ (SoapRequest *) buildUpdateItemsRequest: (NSString *)listName withFolder: (ListInfo *)itemDetail {
    if (!listName) {
        return nil;
    }
    SPUpdateItemRequest * request = [SPUpdateItemRequest soapRequest];
    request.listName = listName;
    request.taskInfo = itemDetail;
    return request;
}


+ (SoapRequest *) buildAddAttachmentRequest:(NSString *)fileName {
    SPSimpleSoapRequest * request = [SPSimpleSoapRequest soapRequest];
    request.rootTagName = @"AddAttachment";
    [request addElement:@"listName" withStringValue:@"74C84711-4EDB-4DF2-952F-413A176EA0CC"];
    [request addElement:@"listItemID" withStringValue:@"1"];
    [request addElement:@"fileName" withStringValue:fileName];
    [request addElement:@"attachment" withStringValue:[Base64 encodeWithFileName:fileName]];
    return request;
}

+ (SoapRequest *) buildGetUserForSiteRequest {
    SPSimpleSoapRequest * request = [SPSimpleSoapRequest soapRequest];
    request.rootTagName = @"GetUserCollectionFromSite";
    return request;
}

@end
