//
//  ViewUtil.h
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

#import <Foundation/Foundation.h>


@interface ViewUtil : NSObject {
}

/**
 This function is very handy for loading an instance of a specified class from a specified NIB
 file.  It's sorta like UIView initWithNibName, but more general purpose.  Very useful for loading
 UITableViewCells from NIB files, e.g.:
 
 MessageCell *cell = [tableView dequeueReusableCellWithIdentifier: @"MessageCell"];
 if (cell == nil) {
 cell = [ViewUtil loadInstanceOfView:[MessageCell class] fromNibNamed:@"MessageCell"];
 }
 **/
+ (id)loadInstanceOfView:(Class)clazz fromNibNamed:(NSString *)name;

@end
