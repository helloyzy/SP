//
//  IBAlertView.h
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

@interface IBAlertView : UIAlertView <UIAlertViewDelegate> {
    void (^okCallback_)(void);
    void (^cancelCallback_)(void);
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle cancelBlock:(void (^)(void))cancelBlock okBlock:(void (^)(void))okBlock;
+ (id)alertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle cancelBlock:(void (^)(void))cancelBlock okBlock:(void (^)(void))okBlock;
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle cancelBlock:(void (^)(void))cancelBlock okBlock:(void (^)(void))okBlock;

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)(void))cancelBlock;
+ (id)alertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)(void))cancelBlock;
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)(void))cancelBlock;

+ (void)showOKWithTitle:(NSString *)title message:(NSString *)message okBlock:(void (^)(void))okBlock;
+ (void)showOKCancelWithTitle:(NSString *)title message:(NSString *)message cancelBlock:(void (^)(void))cancelBlock okBlock:(void (^)(void))okBlock;

@end
