#import "FirstDetailViewController.h"
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
#import "ASIWebPageRequest.h"
#import "ASIDownloadCache.h"
#import "ASIHTTPRequest.h"

@interface FirstDetailViewController ()

- (void) testGetUserInfo;
- (void) testLists;
- (void) testAuthentication;
- (void) requestSubFolder: (NSString *) topListName withFolder: (NSString *) folder;
- (void) loadImage:(NSString *) url;
@end




@implementation FirstDetailViewController

@synthesize toolbar, listOfItems, tableview, popoverController, listInfo, item, webView;


#pragma mark -
#pragma mark View lifecycle


/**
When setting the detail item, update the view and dismiss the popover controller if it's showing.
*/
- (void)setListInfo:(ListInfo *) newlistInfo {
    	
    if (listInfo != newlistInfo) {
        [listInfo release];
        listInfo = [newlistInfo retain];
        
    }

    [self requestSubFolder:listInfo.title withFolder:listInfo.fileRef];
  
    
    
    if (popoverController != nil) {
        [popoverController dismissPopoverAnimated:YES];
    }        
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [self setTitle:listInfo.title];
        
}

- (void)viewDidUnload {
	[super viewDidUnload];
    
	self.toolbar = nil;
}
#pragma mark -
#pragma mark Split view support


- (void)splitViewController:(UISplitViewController*)svc 
     willHideViewController:(UIViewController *)aViewController 
          withBarButtonItem:(UIBarButtonItem*)barButtonItem 
       forPopoverController:(UIPopoverController*)pc
{
    
    [barButtonItem setTitle:@"List"];
    [[self navigationItem] setLeftBarButtonItem:barButtonItem];
    [self setPopoverController:pc];
}


- (void)splitViewController:(UISplitViewController*)svc 
     willShowViewController:(UIViewController *)aViewController 
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [[self navigationItem] setLeftBarButtonItem:nil];
    [self setPopoverController:nil];
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

- (void) requestSubFolder: (NSString *) topListName withFolder: (NSString *) folder{
    SoapRequest * request = [SPSoapRequestBuilder buildGetListItemsRequest:topListName withFolder:folder];
    GetListItemsService* listItemsService = [[GetListItemsService alloc]init];
    listItemsService.soapRequestParam = request;    
    listItemsService.delegate = self;
    [listItemsService request];    
    [listItemsService release];
}

- (void) dataSourceReturn:(NSMutableArray *)datasource {
    self.listOfItems = datasource;
    [self.tableview reloadData];
}

- (void) ListsReturn:(NSMutableArray *)datasource {
    self.listOfItems = datasource;
    [self.tableview reloadData];
}

- (void)onNotification:(NSNotification *)notification {
    NSDictionary * dict = [notification userInfo];
    RXMLElement * ele = (RXMLElement *) [dict objectForKey:SP_NOTIFICATION_KEY_USERINFO];
    NSLog(@"%@", [ele attribute:@"LoginName"]);
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
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
	NSString *title = [(ListInfo *)[listOfItems objectAtIndex:indexPath.row] title];
    //NSString *type = [(ListInfo *)[listOfItems objectAtIndex:indexPath.row] type];
    //NSString *fileRef = [(ListInfo *)[listOfItems objectAtIndex:indexPath.row] fileRef];
    
    
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
    NSString *type = [(ListInfo *)[listOfItems objectAtIndex:indexPath.row] type];
    NSString *fileRef = [(ListInfo *)[listOfItems objectAtIndex:indexPath.row] fileRef];
      
   if ([type isEqualToString:@"1"]) {
        FirstDetailViewController *controller = [[FirstDetailViewController alloc] init];
       listInfo.fileRef = fileRef;
       controller.listInfo = listInfo;
        [[self navigationController] pushViewController:controller animated:YES];
        
    } else {
        NSString * url = [NSString stringWithFormat:@"https://sharepoint.perficient.com/%@", fileRef];
        
        [self loadImage:url];
    }
    
}

- (void)loadImage: (NSString *) url {
    NSURL *targetURL = [NSURL URLWithString:url];
    NSString* theFileName = [url lastPathComponent];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:targetURL];
    NSString * destinationPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:theFileName];
    
    NSLog(@"%@", destinationPath);
    
    [request setDelegate:self];
    [request setDownloadDestinationPath:destinationPath];
    [request setDidFailSelector:@selector(webPageFetchFailed:)];
    [request setDidFinishSelector:@selector(webPageFetchSucceeded:)];
    
    [request setUsername:@"Perficient\\spark.pan"];
    [request setPassword:@"zhe@812Bl"];
    [request setUseSessionPersistence:YES];
    
    [request startAsynchronous];  

}

- (void)webPageFetchFailed:(ASIHTTPRequest *)theRequest
{
    // Obviously you should handle the error properly...
    NSLog(@"%@",[theRequest error]);
}

- (void)webPageFetchSucceeded:(ASIHTTPRequest *)theRequest
{
    NSLog(@"%@",[theRequest downloadDestinationPath]);
    NSFileManager* myManager = [NSFileManager defaultManager];  
    
    if([myManager fileExistsAtPath:[theRequest downloadDestinationPath]]){
        
        NSLog(@"Loading Saved Copy!");
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 786, 960)];
        //Create a URL object.
        NSURL *url = [NSURL fileURLWithPath:[theRequest downloadDestinationPath] isDirectory:NO];
        //URL Requst Object
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        //Load the request in the UIWebView.
        [webView loadRequest:requestObj];
        [self.view addSubview:webView];
        UIBarButtonItem *infoButton = [[UIBarButtonItem alloc] 
                                       initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(info_clicked:)];
        
        self.navigationItem.leftBarButtonItem = infoButton;


    }

}

- (void) info_clicked:(id)sender {
    
    self.navigationItem.leftBarButtonItem = nil;
    [webView removeFromSuperview];
}




- (IBAction)toggleMasterView:(id)sender {
    
}

#pragma mark -
#pragma mark Rotation support

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [toolbar release];
    [tableview release];
    [listInfo release];
    [listOfItems release];
    [webView release];
    [super dealloc];
}	


@end
