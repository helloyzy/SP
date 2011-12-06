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
@property (nonatomic, retain) NSString * listDescription;
@property(nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * fileRef;

@property (nonatomic, retain) NSString * listName;

@property (nonatomic, retain) NSString * assignTo;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * priority;
@property (nonatomic, retain) NSString * dueDate;
@property (nonatomic, retain) NSString * percentComplete;


@end
