#import <UIKit/UIKit.h>
#import "GetListCollectionService.h"
#import "GetListItemsService.h"

@class FirstDetailViewController;

@interface RootViewController : UITableViewController <DataSourceDelegate, ListItemsDelegate> {
	
	FirstDetailViewController *firstDetailViewController;   
    
    NSMutableData* responseData;
    NSMutableArray * listOfItems;
}
@property (nonatomic, assign) IBOutlet FirstDetailViewController *firstDetailViewController;
@property(nonatomic, retain) NSMutableArray *listOfItems;

@end
