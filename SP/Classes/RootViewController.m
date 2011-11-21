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


@interface RootViewController ()

- (void) testGetUserInfo;
- (void) testLists;
- (void) testAuthentication;
- (void) requestSubFolder: (NSString *) topListName withFolder:(NSString *) folderName;
@end
@implementation RootViewController

@synthesize firstDetailViewController, listOfItems, tableView, authenticatePopover, siteItem;



#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);

    [self setTitle:@"List Collection"];
    
    [self testLists];
}

-(void) viewDidUnload {
	[super viewDidUnload];
	
	self.firstDetailViewController = nil;
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
    

    ListInfo * listinfo = (ListInfo *)[listOfItems objectAtIndex:indexPath.row];//[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    listinfo.fileRef = [NSString stringWithFormat:@"sites/SP/%@", listinfo.title];
    firstDetailViewController.listInfo = listinfo;
    //firstDetailViewController.folderName = [NSString stringWithFormat:@"sites/SP/%@", listName];
   }

- (IBAction) logonSites:(id)sender {
    SPAuthenticationView *controller = [[SPAuthenticationView alloc] initWithNibName:@"SPAuthenticationView" bundle:nil];
    // [self presentModalViewController:controller animated:YES];
    
    UIPopoverController * popOver = [[UIPopoverController alloc] initWithContentViewController:controller];
    [popOver presentPopoverFromBarButtonItem:siteItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    controller.container = popOver;
    self.authenticatePopover = popOver;
    [controller release];
    [popOver release];
}

- (IBAction) refreshLists:(id)sender {
    [self testLists];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [firstDetailViewController release];
    [listOfItems release];
    [tableView release];
    // first dismiss
    [self.authenticatePopover dismissPopoverAnimated:NO];
    self.authenticatePopover = nil;
    self.siteItem = nil;
    [super dealloc];
}

@end
