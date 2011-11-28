//
//  SPCoreDataUtil.m
//  SP
//
//  Created by Jack Yang on 11/28/11.
//  Copyright 2011 Per. All rights reserved.
//

#import "SPCoreDataUtil.h"
#import "CoreDataStore.h"

@implementation SPCoreDataUtil

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (void) initCoreDataEnv {
    [[CoreDataStore mainStore] clearAllData];
}

@end
