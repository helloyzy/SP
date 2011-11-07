//
//  GetListItemsService.h
//  SP
//
//  Created by spark pan on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPSoapService.h"

@protocol ListItemsDelegate <NSObject>

- (void) ListsReturn: (NSMutableArray*) datasource;

@end

@interface GetListItemsService : SPSoapService {
    
}

@property (nonatomic, assign) id delegate;

@end
