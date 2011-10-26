//
//  IBHTableView.h
//  iBoost
//
//  iBoost - The iOS Booster!
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <UIKit/UIKit.h>

@class IBHTableView;
@protocol IBHTableViewDelegate<UIScrollViewDelegate,NSObject>
@optional
- (CGFloat)tableView:(IBHTableView *)tableView widthForColumnAtIndex:(NSInteger)index;
@end

@protocol IBHTableViewDataSource<NSObject>
@required
- (NSInteger)numberOfColumnsInTableView:(IBHTableView *)tableView;
- (UITableViewCell *)tableView:(IBHTableView *)tableView cellForColumnAtIndex:(NSInteger)index;
@end

@interface IBHTableView : UIScrollView {
	//external
	id<IBHTableViewDataSource> _dataSource;
	CGFloat _columnWidth;
	
	//internal
	NSInteger _totalCols;
	NSMutableArray *_colWidths;
	BOOL _variableWidths;
	CGFloat _colHeight;
	CGFloat _totalWidth;
	NSMutableArray *_colCells;
	NSMutableArray *_colIndex;
	NSInteger _leftIndex;
	NSInteger _rightIndex;
}

@property(nonatomic, assign) id<IBHTableViewDelegate> delegate;
@property(nonatomic, assign) id<IBHTableViewDataSource> dataSource;
@property(nonatomic, assign) CGFloat columnWidth;

- (void)reloadData;
- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;

@end




