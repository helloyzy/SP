//
//  AttachmentGalleryViewController.m
//  SP
//
//  Created by sarshern.lin on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AttachmentGalleryViewController.h"
#import "Item.h"
#import "AddAttachmentService.h"
#import "SoapRequest.h"
#import "SPSoapRequestBuilder.h"
@implementation AttachmentGalleryViewController

@synthesize myTableView;
@synthesize sections;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [sections count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //if(!sections || ![sections count]) return 0;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {  
    return 130.0;
} 


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    static NSString *CELL_ID = @"hlCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if(cell == nil) {
        cell =  [[[UITableViewCell alloc] 
                    initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_ID] autorelease];
    }

    NSMutableArray *sectionItems = [sections objectAtIndex:indexPath.section];
    
    int count = sectionItems.count;
    int index=0;
    while(index<count){
        Item *item = [sectionItems objectAtIndex:index];
        CGRect rect = CGRectMake(15+120*index, 4, 110, 110);
        UIButton *button=[[UIButton alloc] initWithFrame:rect];
        [button setFrame:rect];
        UIImage *buttonImageNormal=[UIImage imageWithContentsOfFile:item.name];
        [button setImage:buttonImageNormal	forState:UIControlStateNormal];
        [button setContentMode:UIViewContentModeCenter];
        
        [button setTitle:item.name forState:UIControlStateNormal] ;
        //NSLog(@"....SHOW IMAGE ....%@", [button titleForState:UIControlStateNormal]);
        
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
        [button release];        
        
        index++;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


-(void)buttonPressed:(id)sender {
     UIButton *button = (UIButton*)sender;
     //NSLog(@"....CLICK IMAGE ....%@", [button titleForState:UIControlStateNormal]);
     UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:[button titleForState:UIControlStateNormal] 
                                                       delegate:nil 
                                              cancelButtonTitle:nil 
                                              otherButtonTitles:@"OK",nil];
     [alertview show];
     [alertview release];
    
    
    
    
    
//    NSString *fileName = [button titleForState:UIControlStateNormal];           
//    
//    SoapRequest * request = [SPSoapRequestBuilder buildAddAttachmentRequest:fileName];
//    
//    //NSLog(@"attachment request is : %@",request);
//    
//    AddAttachmentService * addAttachmentService = [[AddAttachmentService alloc] init];
//    addAttachmentService.soapRequestParam = request;    
//    [addAttachmentService request];    
//    [addAttachmentService release];

}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];	
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
    [myTableView reloadData];
}

-(void)loadData{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    NSError *error = nil;
    NSArray *fileList = nil;
    fileList = [fileManager contentsOfDirectoryAtPath:documentDir error:&error]; 
    NSMutableArray *imageList= [[NSMutableArray alloc] init];
    const NSArray *imageType = [NSArray arrayWithObjects:@"jpg",@"jpeg",@"png",@"bmp",@"gif", nil];
    for (NSString * file in fileList){
           for(NSString *type in imageType){
               if ([type caseInsensitiveCompare:[file pathExtension]] == NSOrderedSame) {
                    [imageList addObject:file];
                     break;
               }
           }
    }    
    NSLog(@"imageList  %@",imageList);
    
    
    sections = [[NSMutableArray alloc] init];
    const int COLUMNS =4;
	const int ROWS = (int)(1.0 * [imageList count]/COLUMNS + 0.999999);
    
	for(int row=0; row<ROWS; row++) { // 4 sections
		NSMutableArray *section = [[NSMutableArray alloc] init];
		for(int column=0; column<COLUMNS && (COLUMNS*row+column < imageList.count); column++) {  // add items in each section 
			Item *item = [[Item alloc] init];
            NSString *imageName = [imageList objectAtIndex:COLUMNS*row+column];
			item.name=[documentDir stringByAppendingPathComponent:imageName];	
            NSLog(@"imageNmae = %@",item.name);
			[section addObject:item];			
		}
		[sections addObject:section];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	NSLog(@"didReceiveMemoryWarning in AttachmentGalleryViewController");
}

- (void)viewDidUnload {
    self.myTableView = nil;
    self.sections = nil;
}

- (void)dealloc {
    [self.myTableView release];
    [self.sections release];
    [super dealloc];
}

@end
