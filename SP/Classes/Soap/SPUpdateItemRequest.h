//
//  SPUpdateItemRequest.h
//  SP
//
//  Created by spark pan on 11/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SPSoapRequest.h"
#import "ListInfo.h"

@interface SPUpdateItemRequest : SPSoapRequest {
    NSString * listName;
    ListInfo * taskInfo;
    
}

@property(nonatomic, retain) NSString * listName;
@property(nonatomic, retain) ListInfo * taskInfo;

+ (SPUpdateItemRequest *) soapRequest;

@end
