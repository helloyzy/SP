//
//  SPViewController.m
//  SP
//
//  Created by Whitman Yang on 10/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SPViewController.h"
#import "GetUserInfo.h"
#import "GetUserInfoService.h"
#import "ListInfo.h"
#import "GetListCollectionService.h"
#import "SPConst.h"
#import "RXMLElement.h"

@interface SPViewController ()

- (void) testGetUserInfo;
- (void) testLists;

@end

@implementation SPViewController

@synthesize tableview;
@synthesize listOfItems;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {       
    [super viewDidLoad];
    [self testGetUserInfo];
}

- (void) testGetUserInfo {
    GetUserInfo * userInfo = [[GetUserInfo alloc] init];
    userInfo.userLoginName = @"Perficient\\spark.pan";
    GetUserInfoService * userInfoService = [[GetUserInfoService alloc] init];
    userInfoService.soapRequestParam = userInfo;
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(onNotification:) name:SP_NOTIFICATION_GETUSERINFO_SUCCESS object:userInfoService];
    [userInfoService request];
    [userInfo release];
    [userInfoService release];
}

- (void) testLists {
    ListInfo * listInfo = [[ListInfo alloc] init];
    //userInfo.userLoginName = @"Perficient\\spark.pan";
    GetListCollectionService * listInfoService = [[GetListCollectionService alloc] init];
    listInfoService.soapRequestParam = listInfo;
    [listInfoService request];
    
    listInfoService.delegate = self;
    
    [listInfo release];
    [listInfoService release];
}

- (void) dataSourceReturn:(NSMutableArray *)datasource {
    self.listOfItems = datasource;
    [tableview reloadData];
}

- (void)onNotification:(NSNotification *)notification {
    NSDictionary * dict = [notification userInfo];
    RXMLElement * ele = (RXMLElement *) [dict objectForKey:SP_NOTIFICATION_KEY_USERINFO];
    NSLog(@"%@", [ele attribute:@"LoginName"]);
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listOfItems count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
    
    // Set up the cell...
	NSString *cellValue = [(ListInfo *)[listOfItems objectAtIndex:indexPath.row] title];
	cell.textLabel.text = cellValue;
    
    return cell;
}


- (void)dealloc {
    
    [tableview release];
    [listOfItems release];
    [super release];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
