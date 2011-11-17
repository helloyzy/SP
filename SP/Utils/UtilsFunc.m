//
//  UtilsFunc.m
//  SP
//
//  Created by Jack Yang on 11/17/11.
//  Copyright 2011 Per. All rights reserved.
//

#import "UtilsFunc.h"

BOOL IS_EMPTY_STRING(NSString * str) {
    return (!str || ![str isKindOfClass:NSString.class] || [str length] == 0);
}

BOOL IS_POPULATED_STRING(NSString * str) {
    return (str && [str isKindOfClass:NSString.class] && [str length] > 0);
}