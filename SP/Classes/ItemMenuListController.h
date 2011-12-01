#import <UIKit/UIKit.h>
#import "ListInfo.h"

@interface ItemMenuListController : UITableViewController {
	NSArray *menuNames;
    ListInfo * taskInfo;
}

@property (nonatomic, retain) NSArray *menuNames;
@property (nonatomic, retain) ListInfo * taskInfo;
@end
