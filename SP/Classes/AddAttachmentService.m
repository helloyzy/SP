//
//  AddAttachmentService.m
//  SP
//
//  Created by sarshern.lin on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AddAttachmentService.h"
#import "NSObject+SPExtensions.h"
#import "SPConst.h"

@implementation AddAttachmentService

-(void)prepareUrlAndHeadProps{
    [self buildServiceUrlWithName:SP_SOAP_URL_LISTS];    
    [self addSoapActionHeadProp:@"AddAttachment"];
}

- (id) parseResponse:(NSString *)responseString{
    if ([responseString rangeOfString : @"The specified name is already in use."].length > 0 ) {
        return self.errorObj = @"The specified name is already in use.";
    }
    else if ([responseString rangeOfString : @"The file or folder name contains characters that are not permitted.  Please use a different name."].length > 0){
         return self.errorObj = @"The file or folder name contains characters that are not permitted.  Please use a different name.";
    }
    else if ([responseString isEqualToString:@""]){
         return self.errorObj = @"Nothing return from server.";
    }
    
    return @"Attach Successfully!";
  }


- (void) sendNotificationOnSuccess:(id)value {
    [self postNotification:SP_NOTIFICATION_ADDATTACHMENT_SUCCESS withValue:value];
}

- (void) sendNotificationOnFailure:(id)errorInfo {
    [self postNotification:SP_NOTIFICATION_ADDATTACHMENT_FAILURE withValue:errorInfo];
}


- (void) dealloc {
    [super dealloc];
}


@end
