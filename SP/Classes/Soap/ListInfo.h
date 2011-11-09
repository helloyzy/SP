//
//  ListInfo.h
//  SP
//
//  Created by spark pan on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoapRequest.h"

@interface ListInfo : SoapRequest

@property(nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * description;
@property(nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * fileRef;

@end
