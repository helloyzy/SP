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


@interface RootViewController ()

- (void) testGetUserInfo;
- (void) testLists;
- (void) testAuthentication;
- (void) requestSubFolder: (NSString *) topListName withFolder:(NSString *) folderName;
@end
@implementation RootViewController

@synthesize popoverController, splitViewController, rootPopoverButtonItem, listOfItems;



#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Set the content size for the popover: there are just two rows in the table view, so set to rowHeight*2.
    self.contentSizeForViewInPopover = CGSizeMake(310.0, self.tableView.rowHeight*2.0);
    
    [self testLists];
}

-(void) viewDidUnload {
	[super viewDidUnload];
	
	self.splitViewController = nil;
	self.rootPopoverButtonItem = nil;
}


- (void) testAuthentication {
    SoapRequest * request = [SPSoapRequestBuilder buildAuthenticationRequest];
    SPLoginAuthenticationService * authService = [[SPLoginAuthenticationService alloc] init];
    authService.soapRequestParam = request;
    [authService request];
    [authService release];
    
}

- (void) testGetUserInfo {
    SoapRequest * request = [SPSoapRequestBuilder buildGetUserInfoRequest:@"Perficient\\spark.pan"];
    GetUserInfoService * userInfoService = [[GetUserInfoService alloc] init];
    userInfoService.soapRequestParam = request;
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(onNotification:) name:SP_NOTIFICATION_GETUSERINFO_SUCCESS object:userInfoService];
    [userInfoService request];
    [userInfoService release];
}

- (void) testLists {
    SoapRequest * request = [SPSoapRequestBuilder buildListInfoRequest];
    GetListCollectionService * listInfoService = [[GetListCollectionService alloc] init];
    listInfoService.soapRequestParam = request;    
    listInfoService.delegate = self;
    [listInfoService request];    
    [listInfoService release];
}

- (void) requestSubFolder: (NSString *) topListName withFolder:(NSString *)folderName {
    SoapRequest * request = [SPSoapRequestBuilder buildGetListItemsRequest:topListName withFolder:folderName];
    GetListItemsService* listItemsService = [[GetListItemsService alloc]init];
    listItemsService.soapRequestParam = request;    
    listItemsService.delegate = self;
    [listItemsService request];    
    [listItemsService release];
}

- (void) dataSourceReturn:(NSMutableArray *)datasource {
    self.listOfItems = datasource;
    [[self tableView] reloadData];
}

- (void) ListsReturn:(NSMutableArray *)datasource {
    self.listOfItems = datasource;
    [[self tableView]reloadData];
}

- (void)onNotification:(NSNotification *)notification {
    NSDictionary * dict = [notification userInfo];
    RXMLElement * ele = (RXMLElement *) [dict objectForKey:SP_NOTIFICATION_KEY_USERINFO];
    NSLog(@"%@", [ele attribute:@"LoginName"]);
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

#pragma mark -
#pragma mark Rotation support

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)splitViewController:(UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController:(UIPopoverController*)pc {
    
    // Keep references to the popover controller and the popover button, and tell the detail view controller to show the button.
    barButtonItem.title = @"Top Level Lists";
    self.popoverController = pc;
    self.rootPopoverButtonItem = barButtonItem;
    UIViewController <SubstitutableDetailViewController> *detailViewController = [splitViewController.viewControllers objectAtIndex:1];
    [detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
}


- (void)splitViewController:(UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
 
    // Nil out references to the popover controller and the popover button, and tell the detail view controller to hide the button.
    UIViewController <SubstitutableDetailViewController> *detailViewController = [splitViewController.viewControllers objectAtIndex:1];
    [detailViewController invalidateRootPopoverButtonItem:rootPopoverButtonItem];
    self.popoverController = nil;
    self.rootPopoverButtonItem = nil;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    
    // Two sections, one for each detail view controller.
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
    
    /*
     Create and configure a new detail view controller appropriate for the selection.
     */
      
    UIViewController <SubstitutableDetailViewController> *detailViewController = nil;

    NSString * listName = [(ListInfo *)[listOfItems objectAtIndex:indexPath.row] title];//[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    
    FirstDetailViewController *newDetailViewController = [[FirstDetailViewController alloc] initWithNibName:@"FirstDetailView" bundle:nil];
        newDetailViewController.listName = listName;
        detailViewController = newDetailViewController;


    // Update the split view controller's view controllers array.
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:self.navigationController, detailViewController, nil];
    splitViewController.viewControllers = viewControllers;
    [viewControllers release];
    
    // Dismiss the popover if it's present.
    if (popoverController != nil) {
        [popoverController dismissPopoverAnimated:YES];
    }

    // Configure the new view controller's popover button (after the view has been displayed and its toolbar/navigation bar has been created).
    if (rootPopoverButtonItem != nil) {
        [detailViewController showRootPopoverButtonItem:self.rootPopoverButtonItem];
    }

    [detailViewController release];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [popoverController release];
    [rootPopoverButtonItem release];
    [listOfItems release];
    [super dealloc];
}

@end
