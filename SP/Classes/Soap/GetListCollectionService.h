//
//  GetListCollectionService.h
//  SP
//
//  Created by spark pan on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SoapServiceBase.h"

@protocol DataSourceDelegate <NSObject>
- (void) dataSourceReturn: (NSMutableArray*) datasource;
@end

@class ListInfo;


@interface GetListCollectionService : SoapServiceBase {
    
    NSMutableArray * listOfItems;
     id<DataSourceDelegate> delegate;
}


@property (nonatomic ,retain) NSMutableArray *listOfItems;
@property (nonatomic, retain) ListInfo *listInfo;
@property (nonatomic, assign) id delegate;

@end
