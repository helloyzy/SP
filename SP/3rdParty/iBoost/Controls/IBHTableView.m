//
//  IBHTableView.m
//  iBoost
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

#import "IBHTableView.h"


@implementation IBHTableView

@dynamic delegate;
@synthesize dataSource = _dataSource;
@synthesize columnWidth = _columnWidth;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		self.columnWidth = 320;
        _colWidths = [[NSMutableArray alloc] init];
		_colCells = [[NSMutableArray alloc] init];
		_colIndex = [[NSMutableArray alloc] init];
		_leftIndex = 0;
		_rightIndex = 0;
    }
    return self;
}

-(void) coverIndices {
	if (!_variableWidths) {
		for(int i=_leftIndex; i<=_rightIndex; i++){
			NSNumber *num = [NSNumber numberWithInt:i];
			if (![_colIndex containsObject:num]) {
				[_colIndex addObject:num];
				UITableViewCell *cell = [self.dataSource tableView:self cellForColumnAtIndex:i];
				cell.frame = CGRectMake(i*self.columnWidth, 0, self.columnWidth, self.frame.size.height);
				[self insertSubview:cell atIndex:0];
				[_colCells addObject:cell];
			}
		}
	}
}

-(void) setContentOffset:(CGPoint)contentOffset {
	super.contentOffset = contentOffset;
	CGFloat xpos = contentOffset.x;
	int newLeftIndex = 0;
	int newRightIndex = 0;
	if(!_variableWidths){
		if (xpos == 0.0) {
			newLeftIndex = 0;
		}else {
			newLeftIndex = xpos / self.columnWidth;
		}
		newRightIndex = newLeftIndex + (self.frame.size.width / self.columnWidth);
		newRightIndex = MIN(newRightIndex, _totalCols-1);
	}
	if (newLeftIndex != _leftIndex || newRightIndex != _rightIndex) {
		_leftIndex = newLeftIndex;
		_rightIndex = newRightIndex;
		[self coverIndices];
	}
}

-(void) reloadData {
	_totalCols = 0;
	_totalWidth = 0;
	_variableWidths = NO;
	if (self.dataSource) {
		_totalCols = [self.dataSource numberOfColumnsInTableView:self];
		_totalWidth = self.columnWidth*_totalCols;
	}
	if (self.delegate) {
		if([self.delegate respondsToSelector:@selector(tableView:widthForColumnAtIndex:)]){
			_totalWidth = 0;
			_variableWidths = YES;
			[_colWidths removeAllObjects];
			for (int i=0; i<_totalCols; i++) {
				CGFloat wid = [self.delegate tableView:self widthForColumnAtIndex:i];
				_totalWidth += wid;
				[_colWidths addObject:[NSNumber numberWithFloat:_totalWidth]];
			}
		}
	}
	self.contentSize = CGSizeMake(_totalWidth, self.frame.size.height);
}

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
	for (int i=0; i<_colCells.count; i++) {
		UITableViewCell *cell = [_colCells objectAtIndex:i];
		if([cell.reuseIdentifier isEqualToString:identifier]){
			NSNumber *num = [_colIndex objectAtIndex:i];
			NSInteger index = [num intValue];
			if(index < _leftIndex || index > _rightIndex){
				[cell retain];
				[_colCells removeObjectAtIndex:i];
				[_colIndex removeObjectAtIndex:i];
				[cell prepareForReuse];
				return [cell autorelease];
			}
		}
	}
	return nil;
}

- (void)dealloc {
	[_colIndex release];
	[_colCells release];
	[_colWidths release];
    [super dealloc];
}


@end
