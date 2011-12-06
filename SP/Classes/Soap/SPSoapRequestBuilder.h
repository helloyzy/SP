//
//  SPSoapRequestBuilder.h
//  SP
//
//  Created by Whitman Yang on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SoapRequest;
@class ListInfo;

@interface SPSoapRequestBuilder : NSObject

+ (SoapRequest *) buildAuthenticationRequest;
+ (SoapRequest *) buildListInfoRequest;
+ (SoapRequest *) buildGetUserInfoRequest:(NSString *)userLoginName;
+ (SoapRequest *) buildModeRequest;

+ (SoapRequest *) buildGetListItemsRequest: (NSString *)listName withFolder: (NSString *)folder;
+ (SoapRequest *) buildUpdateItemsRequest: (NSString *)listName withFolder: (ListInfo *)itemDetail;
<<<<<<< HEAD


+ (SoapRequest *) buildAddAttachmentRequest:(NSString *)fileName;

=======
>>>>>>> d07b8c437311d3ee422c1ea1e7ba78bca0a66184
+ (SoapRequest *) buildGetUserForSiteRequest;
@end
