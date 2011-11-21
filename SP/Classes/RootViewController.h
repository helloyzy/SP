#import <UIKit/UIKit.h>
#import "GetListCollectionService.h"
#import "GetListItemsService.h"

@class FirstDetailViewController;

@interface RootViewController : UIViewController <UITableViewDataSource, DataSourceDelegate, ListItemsDelegate> {
	
	FirstDetailViewController *firstDetailViewController;   
    
    NSMutableData* responseData;
    NSMutableArray * listOfItems;
    IBOutlet UITableView * tableView;
}
@property (nonatomic, assign) IBOutlet FirstDetailViewController *firstDetailViewController;
@property(nonatomic, retain) NSMutableArray *listOfItems;
@property(nonatomic, retain) IBOutlet UITableView *tableView;
@property(nonatomic, retain) UIPopoverController * authenticatePopover;
@property(nonatomic, retain) IBOutlet UIBarButtonItem * siteItem;

- (IBAction) logonSites:(id)sender;
- (IBAction) refreshLists:(id)sender;
@end
