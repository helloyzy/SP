//
//  SPConst.h
//  SP
//
//  Created by Whitman Yang on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// URLs for SP web services
static NSString * SP_SOAP_URL_GETUSERINFO = @"UserGroup.asmx";
static NSString * SP_SOAP_URL_LISTS = @"Lists.asmx";
static NSString * SP_SOAP_URL_AUTHENTICATION = @"authentication.asmx";
static NSString * SP_SOAP_URL_MODE = @"authentication.asmx";

// Head properties for SP web services
static NSString * SP_SOAP_HEAD_KEY_SOAPACTION = @"SOAPAction";
static NSString * SP_SOAP_HEAD_SOAPACTION_PREFIX = @"http://schemas.microsoft.com/sharepoint/soap/";

// Namespaces
static NSString * SP_SOAP_NS_DEFAULT = @"http://schemas.microsoft.com/sharepoint/soap/";

// Notifications 
static NSString * SP_NOTIFICATION_KEY_USERINFO = @"VALUE";
static NSString * SP_NOTIFICATION_GETUSERINFO_SUCCESS = @"NOTIFICATION_GETUSERINFO_SUCCESS";
static NSString * SP_NOTIFICATION_GETUSERINFO_FAILURE = @"NOTIFICATION_GETUSERINFO_FAILURE";
static NSString * SP_NOTIFICATION_GETLISTCOLLECTION_SUCCESS = @"NOTIFICATION_GETLISTCOLLECTION_SUCCESS";
static NSString * SP_NOTIFICATION_GETLISTCOLLECTION_FAILURE = @"NOTIFICATION_GETLISTCOLLECTION_FAILURE";
static NSString * SP_NOTIFICATION_GETLISTITEMS_SUCCESS  =@"NOTIFICATION_GETLISTITEMS_SUCCESS";
static NSString * SP_NOTIFICATION_GETLISTITEMS_FAILURE = @"NOTIFICATION_GETLISTITEMS_FAILURE";
static NSString * SP_NOTIFICATION_UPDATEITEM_SUCCESS = @"NOTIFICATION_UPDATEITEM_SUCCESS";
static NSString * SP_NOTIFICATION_UPDATEITEM_FAILURE = @"NOTIFICATION_UPDATEITEM_FAILURE";
static NSString * SP_NOTIFICATION_GETUSERCOLLCTION__SUCCESS = @"NOTIFICATION_GETUSERCOLLCTION__SUCCESS";
static NSString * SP_NOTIFICATION_GETUSERCOLLCTION__FAILURE = @"NOTIFICATION_GETUSERCOLLCTION__FAILURE";
<<<<<<< HEAD

static NSString * SP_NOTIFICATION_ADDATTACHMENT_SUCCESS = @"SP_NOTIFICATION_ADDATTACHMENT_SUCCESS";
static NSString * SP_NOTIFICATION_ADDATTACHMENT_FAILURE = @"SP_NOTIFICATION_ADDATTACHMENT_FAILURE";

=======
>>>>>>> d07b8c437311d3ee422c1ea1e7ba78bca0a66184

// Notification on site settings changed
static NSString * SP_NOTIFICATION_SITESETTINGS_CHANGED = @"NOTIFICATION_SITESETTINGS_CHANGED";