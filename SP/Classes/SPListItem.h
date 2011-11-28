//
//  SPListItem.h
//  SP
//
//  Created by Jack Yang on 11/28/11.
//  Copyright (c) 2011 Per. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SPListItem;

@interface SPListItem : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * listDescription;
@property (nonatomic, retain) NSString * fileRef;
@property (nonatomic, retain) NSString * assignTo;
@property (nonatomic, retain) NSString * listName;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * priority;
@property (nonatomic, retain) NSString * dueDate;
@property (nonatomic, retain) NSString * percentComplete;
@property (nonatomic, retain) SPListItem *parentItem;
@property (nonatomic, retain) NSSet *subItems;
@end

@interface SPListItem (CoreDataGeneratedAccessors)
- (void)addSubItemsObject:(SPListItem *)value;
- (void)removeSubItemsObject:(SPListItem *)value;
- (void)addSubItems:(NSSet *)value;
- (void)removeSubItems:(NSSet *)value;

@end
