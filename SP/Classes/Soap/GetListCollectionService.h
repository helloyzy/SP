//
//  GetListCollectionService.h
//  SP
//
//  Created by spark pan on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SoapServiceBase.h"
#import "SPSoapService.h"

@protocol DataSourceDelegate <NSObject>

- (void) dataSourceReturn: (NSMutableArray*) datasource;

@end

@interface GetListCollectionService : SPSoapService

@property (nonatomic, retain) id delegate;

@end
