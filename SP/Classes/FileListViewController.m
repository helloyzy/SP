//
//  FileListViewController.m
//  SP
//
//  Created by sarshern.lin on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FileListViewController.h"
#import "Base64.h"
#import "NSObject+SPExtensions.h"
#import "SPConst.h"
#import "AddAttachmentService.h"
#import "SoapRequest.h"
#import "SPSoapRequestBuilder.h"

@implementation FileListViewController
@synthesize fileList;
@synthesize myTable;
@synthesize indexPathForSelectRow;
@synthesize indicator;
@synthesize myAlertView;
@synthesize taskInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerNotification:SP_NOTIFICATION_ADDATTACHMENT_SUCCESS withSelector:@selector(onVerificationSuccess:)];
    [self registerNotification:SP_NOTIFICATION_ADDATTACHMENT_FAILURE withSelector:@selector(onVerificationFailure:)];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self unregisterNotification];
}

- (void)onVerificationSuccess:(NSNotification *)notification {
    [self.indicator stopAnimating];
    [self.myAlertView dismissWithClickedButtonIndex:1 animated:YES];
    
    NSString * successMsg = (NSString *) [self valueFromSPNotification:notification];
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:successMsg 
                                                       delegate:nil 
                                              cancelButtonTitle:nil 
                                              otherButtonTitles:@"OK",nil];
    [alertview show];
    [alertview release];
}

- (void)onVerificationFailure:(NSNotification *)notification {
    [self.indicator stopAnimating];
    [self.myAlertView dismissWithClickedButtonIndex:1 animated:YES];
    
    NSString * errorMsg = (NSString *) [self valueFromSPNotification:notification];
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:errorMsg 
                                                       delegate:nil 
                                              cancelButtonTitle:nil 
                                              otherButtonTitles:@"OK",nil];
    [alertview show];
    [alertview release];
}

//-------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.fileList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"FILE_LIST_CELL";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.fileList objectAtIndex:[indexPath row]];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.indexPathForSelectRow = indexPath;
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"Are you sure to attach the file" 
                         delegate:self 
                         cancelButtonTitle:@"cancel" 
                         otherButtonTitles:@"OK",nil];
    [alertview show];
    [alertview release];
        
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.indexPathForSelectRow = nil;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"] && 
          self.indexPathForSelectRow != nil){
        
        self.myAlertView = [[[UIAlertView alloc] initWithTitle:@"The file is being attaching" message:@"Please wait...." delegate:nil cancelButtonTitle:nil  otherButtonTitles:nil] autorelease];
		[myAlertView show];
		
		self.indicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
        
		[myAlertView addSubview:indicator];
        indicator.center = CGPointMake(myAlertView.bounds.size.width + 150, myAlertView.bounds.size.height + 90);
		[indicator startAnimating];
  
        
        [self attachSelectFile];

     }
}

-(void)attachSelectFile{
    UITableViewCell *cell=[myTable  cellForRowAtIndexPath:self.indexPathForSelectRow];
    NSString *fileName = [[cell textLabel] text];               
    SoapRequest *request = [SPSoapRequestBuilder buildAddAttachmentRequest:fileName withListName:[taskInfo listName] andListItem:[taskInfo listItemID]];    
 
    //NSLog(@"attachment request is : %@",request);
    
    AddAttachmentService * addAttachmentService = [[AddAttachmentService alloc] init];
    addAttachmentService.soapRequestParam = request;    
    [addAttachmentService request];    
    [addAttachmentService release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    NSError *error = nil;
    self.fileList = [fileManager contentsOfDirectoryAtPath:documentDir error:&error];    
    
    NSLog(@"fileList:%@-----",fileList);
    NSLog(@"error:%@-----",error);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.myTable = nil;
    self.fileList = nil;
    self.indexPathForSelectRow = nil;
    self.indicator = nil;
    self.myAlertView = nil;
}

- (void)dealloc {
    [myTable release];
    [fileList release];
    [indexPathForSelectRow release];
    [indicator release];
    [myAlertView release];
    [taskInfo release];
    [super dealloc];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
