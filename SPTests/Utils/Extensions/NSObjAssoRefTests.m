//
//  NSObjAssoRefTests.m
//  SP
//
//  Created by Whitman Yang on 10/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSObjAssoRefTests.h"
#import "NSObject+AssociativeReferences.h"
#import "Macros.h"

@implementation NSObjAssoRefTests

static char key;
static char key2;

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    refObject = [[NSObject alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    SAFE_RELEASE(refObject);
    [super tearDown];
}

- (void) testHappyPath {
    NSString * value = @"test";
    [refObject associateRetainedObject:value withKey: &key];
    NSString * retrievedValue = (NSString *)[refObject associatedObject: &key];
    STAssertEqualObjects(value, retrievedValue, @"Value should be the same");
    STAssertTrue(value == retrievedValue, @"Value address should be the same");
    [refObject removeAssociatedObject: &key];
    retrievedValue = (NSString *)[refObject associatedObject: &key];
    STAssertNil(retrievedValue, @"Value should be set to nil");
}

- (void) testRemoveAll {
    NSString * value1 = @"test1";
    NSString * value2 = @"test2";
    
    [refObject associateRetainedObject:value1 withKey: &key];
    [refObject associateRetainedObject:value2 withKey: &key2];
    
    NSString * retrievedValue = (NSString *)[refObject associatedObject: &key];
    NSString * retrievedValue2 = (NSString *)[refObject associatedObject: &key2];
    
    STAssertEqualObjects(value1, retrievedValue, @"Value1 (test1) should be the same");
    STAssertEqualObjects(value2, retrievedValue2, @"Value2 (test2) should be the same");
    
    [refObject removeAssociatedObject: &key];
    
    // get values again
    retrievedValue = (NSString *)[refObject associatedObject: &key];
    retrievedValue2 = (NSString *)[refObject associatedObject: &key2];
    STAssertNil(retrievedValue, @"Value1 should be set to nil");
    STAssertNotNil(retrievedValue2, @"Value2 should still hold the value");
    
    [refObject removeAllAssociatedObject];
    
    // both values should be set to nil
    retrievedValue = (NSString *)[refObject associatedObject: &key];
    retrievedValue2 = (NSString *)[refObject associatedObject: &key2];
    STAssertNil(retrievedValue, @"Value1 should be set to nil");
    STAssertNil(retrievedValue2, @"Value2 should be set to nil");
}

@end
