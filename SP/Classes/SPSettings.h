//
//  SPSettings.h
//  SP
//
//  Created by Jack Yang on 11/28/11.
//  Copyright (c) 2011 Per. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SPSettings : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * siteUrl;

@end
