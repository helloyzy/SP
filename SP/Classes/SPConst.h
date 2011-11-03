//
//  SPConst.h
//  SP
//
//  Created by Whitman Yang on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// URLs for SP web services
static NSString * SP_SOAP_URL_GETUSERINFO = @"https://sharepoint.perficient.com/sites/gdc/_vti_bin/UserGroup.asmx";
static NSString * SP_SOAP_URL_LISTS = @"https://sharepoint.perficient.com/sites/gdc/_vti_bin/Lists.asmx";

// Head properties for SP web services
static NSString * SP_SOAP_HEAD_KEY_SOAPACTION = @"SOAPAction";
static NSString * SP_SOAP_HEAD_SOAPACTION_PREFIX = @"http://schemas.microsoft.com/sharepoint/soap/";

// Notifications 
static NSString * SP_NOTIFICATION_KEY_USERINFO = @"VALUE";
static NSString * SP_NOTIFICATION_GETUSERINFO_SUCCESS = @"NOTIFICATION_GETUSERINFO_SUCCESS";
