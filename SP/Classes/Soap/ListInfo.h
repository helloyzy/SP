//
//  ListInfo.h
//  SP
//
//  Created by spark pan on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoapEntity.h"

@interface ListInfo : SoapEntity

@property(nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * description;

@end
