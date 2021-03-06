//
//  SPComplexSoapRequest.h
//  SP
//
//  Created by spark pan on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPSoapRequest.h"

@interface SPGetListItemsRequest : SPSoapRequest {

    NSString * listName;
    NSString * folderName;
    
}

@property(nonatomic, retain) NSString * listName;
@property(nonatomic, retain) NSString * folderName;

+ (SPGetListItemsRequest *) soapRequest;


@end
