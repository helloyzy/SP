//
//  RootViewController.m
//  SP
//
//  Created by spark pan on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
#import "RootViewController.h"
#import "FirstDetailViewController.h"
#import "GetUserInfoService.h"
#import "ListInfo.h"
#import "GetListCollectionService.h"
#import "SPConst.h"
#import "RXMLElement.h"
#import "UTLDebug.h"
#import "SPSimpleSoapRequest.h"
#import "SPSoapRequestBuilder.h"
#import "SPLoginAuthenticationService.h"
#import "SPAuthenticationView.h"
#import "NSObject+SPExtensions.h"
#import "SPConst.h"

@interface RootViewController ()
- (void) fetchTopListCollection;
@end

@implementation RootViewController

@synthesize firstDetailViewController, listOfItems, topListTableView, authenticatePopover, siteItem;



#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {    
    [super viewDidLoad];
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    [self setTitle:@"List Collection"];
    [self fetchTopListCollection];
}

-(void) viewDidUnload {
	[super viewDidUnload];	
	self.firstDetailViewController = nil;
    [self.authenticatePopover dismissPopoverAnimated:NO];
    self.authenticatePopover = nil;
    self.siteItem = nil;
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self registerNotification:SP_NOTIFICATION_GETLISTCOLLECTION_SUCCESS withSelector:@selector(onVerificationSuccess:)];
    [self registerNotification:SP_NOTIFICATION_GETLISTCOLLECTION_FAILURE withSelector:@selector(onVerificationFailure:)];
    [self registerNotification:SP_NOTIFICATION_SITESETTINGS_CHANGED withSelector:@selector(fetchTopListCollection)];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self unregisterNotification];
}

#pragma mark -
#pragma sharepoint soap web service call method

- (void) fetchTopListCollection {
    SoapRequest * request = [SPSoapRequestBuilder buildListInfoRequest];
    GetListCollectionService * listInfoService = [[GetListCollectionService alloc] init];
    listInfoService.soapRequestParam = request;    
    [listInfoService request];    
    [listInfoService release];
}

- (void)onVerificationSuccess:(NSNotification *)notification {
    NSMutableArray * lists = (NSMutableArray *) [self valueFromSPNotification:notification];
    NSLog(@"%@", lists);
    self.listOfItems = lists;
    [self.topListTableView reloadData];
}

- (void)onVerificationFailure:(NSNotification *)notification {
    NSString * errorMsg = (NSString *) [self valueFromSPNotification:notification];
    NSLog(@"%@", errorMsg);
    //[self showError:errorMsg];
}

#pragma mark -
#pragma mark Rotation support

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [listOfItems count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath { 
    static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
       
    // Set up the cell...
	NSString *title = [(ListInfo *)[listOfItems objectAtIndex:indexPath.row] title];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 25)];
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
    [cell.contentView addSubview:titleLabel];
    [titleLabel release];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


#pragma mark -
#pragma mark Table view selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ListInfo * listinfo = (ListInfo *)[listOfItems objectAtIndex:indexPath.row];
    firstDetailViewController.listInfo = listinfo;
}


#pragma mark -
#pragma mark the bottom toolbar buttons' call method


- (IBAction) refreshLists:(id)sender {
    [self fetchTopListCollection];
}

- (IBAction) logonSites:(id)sender {
    
    if (!authenticatePopover) { 
        SPAuthenticationView *controller = [[SPAuthenticationView alloc] initWithNibName:@"SPAuthenticationView" bundle:nil];
        UIPopoverController * popOver = [[UIPopoverController alloc] initWithContentViewController:controller];
        self.authenticatePopover = popOver;        
        controller.container = authenticatePopover;
        [controller release];
        [popOver release];
    } 
    if (authenticatePopover.isPopoverVisible) {
        [authenticatePopover dismissPopoverAnimated:YES];
    } else {
        [authenticatePopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [firstDetailViewController release];
    [listOfItems release];
    [topListTableView release];
    [super dealloc];
}

@end
