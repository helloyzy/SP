//
//  IBAlertView.m
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

#import "IBAlertView.h"

@implementation IBAlertView

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle cancelBlock:(void (^)(void))cancelBlock okBlock:(void (^)(void))okBlock {
    [[IBAlertView alertWithTitle:title message:message cancelTitle:cancelTitle okTitle:okTitle cancelBlock:cancelBlock okBlock:okBlock] show];
}

+ (id)alertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle cancelBlock:(void (^)(void))cancelBlock okBlock:(void (^)(void))okBlock {
    return [[[IBAlertView alloc] initWithTitle:title message:message cancelTitle:cancelTitle okTitle:okTitle cancelBlock:cancelBlock okBlock:okBlock] autorelease];
}

+ (void)showOKWithTitle:(NSString *)title message:(NSString *)message okBlock:(void (^)(void))okBlock {
    [[IBAlertView alertWithTitle:title message:message cancelTitle:nil okTitle:@"OK" cancelBlock:nil okBlock:okBlock] show];
}

+ (void) showOKCancelWithTitle:(NSString *)title message:(NSString *)message cancelBlock:(void (^)(void))cancelBlock okBlock:(void (^)(void))okBlock {
    [[IBAlertView alertWithTitle:title message:message cancelTitle:@"Cancel" okTitle:@"OK" cancelBlock:cancelBlock okBlock:okBlock] show];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle cancelBlock:(void (^)(void))cancelBlock okBlock:(void (^)(void))okBlock {
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:okTitle, nil];
    
    if (self) {
        okCallback_ = Block_copy(okBlock);
        cancelCallback_ = Block_copy(cancelBlock);
    }
    
    return self;
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)(void))cancelBlock {
    [[IBAlertView alertWithTitle:title message:message cancelTitle:cancelTitle cancelBlock:cancelBlock] show];
}

+ (id)alertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)(void))cancelBlock {
    return [[[IBAlertView alloc] initWithTitle:title message:message cancelTitle:cancelTitle cancelBlock:cancelBlock] autorelease];    
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)(void))cancelBlock {
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    
    if (self) {
        cancelCallback_ = Block_copy(cancelBlock);
    }
    
    return self;
}                                                                                                                                                      

- (void)dealloc {
    Block_release(okCallback_);
    Block_release(cancelCallback_);
    
    [super dealloc];
}

#pragma mark -

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.numberOfButtons == 2) {
        if (buttonIndex == 0) {
            if (cancelCallback_) {
                cancelCallback_();
            }
        } else {
            if (okCallback_) {
                okCallback_();
            }
        }
    } else {
        if (cancelCallback_) {
            cancelCallback_();
        }
    }
}

@end
