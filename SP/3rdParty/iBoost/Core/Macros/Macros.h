//
//  Macros.h
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

#import <MobileCoreServices/UTCoreTypes.h>
#import <CoreMotion/CoreMotion.h>
#import "Constants.h"

// TYPES

#define BOX_BOOL(x) [NSNumber numberWithBool:(x)]
#define BOX_INT(x) [NSNumber numberWithInt:(x)]
#define BOX_SHORT(x) [NSNumber numberWithShort:(x)]
#define BOX_LONG(x) [NSNumber numberWithLong:(x)]
#define BOX_UINT(x) [NSNumber numberWithUnsignedInt:(x)]
#define BOX_FLOAT(x) [NSNumber numberWithFloat:(x)]
#define BOX_DOUBLE(x) [NSNumber numberWithDouble:(x)]

#define UNBOX_BOOL(x) [(x) boolValue]
#define UNBOX_INT(x) [(x) intValue]
#define UNBOX_SHORT(x) [(x) shortValue]
#define UNBOX_LONG(x) [(x) longValue]
#define UNBOX_UINT(x) [(x) unsignedIntValue]
#define UNBOX_FLOAT(x) [(x) floatValue]
#define UNBOX_DOUBLE(x) [(x) doubleValue]

// STRINGIFY

#define STRINGIFY_BOOL(x) ((x) ? @"true" : @"false")
#define STRINGIFY_INT(x) ([NSString stringWithFormat:@"%i", (x)])
#define STRINGIFY_SHORT(x) ([NSString stringWithFormat:@"%i", (x)])
#define STRINGIFY_LONG(x) ([NSString stringWithFormat:@"%li", (x)])
#define STRINGIFY_UINT(x) ([NSString stringWithFormat:@"%u", (x)])
#define STRINGIFY_FLOAT(x) ([NSString stringWithFormat:@"%f", (x)])
#define STRINGIFY_DOUBLE(x) ([NSString stringWithFormat:@"%f", (x)])

// MEMORY

// new versions
#define SAFE_RELEASE(obj) ([obj release], obj = nil)
#define SAFE_TIMER_RELEASE(obj) ([obj invalidate], [obj release], obj = nil)

// BOUNDS

#define RECT_WITH_WIDTH_HEIGHT(rect, width, height) CGRectMake((rect).origin.x, (rect).origin.y, (width), (height))
#define RECT_WITH_WIDTH(rect, width) CGRectMake((rect).origin.x, (rect).origin.y, (width), (rect).size.height)
#define RECT_WITH_HEIGHT(rect, height) CGRectMake((rect).origin.x, (rect).origin.y, (rect).size.width, (height))

#define RECT_INSET_BY_LEFT_TOP_RIGHT_BOTTOM(rect, left, top, right, bottom) CGRectMake(rect.origin.x + (left), rect.origin.y + (top), rect.size.width - (left) - (right), rect.size.height - (top) - (bottom))
#define RECT_INSET_BY_TOP_BOTTOM(rect, top, bottom) CGRectMake(rect.origin.x, rect.origin.y + (top), rect.size.width, rect.size.height - (top) - (bottom))
#define RECT_INSET_BY_LEFT_RIGHT(rect, left, right) CGRectMake(rect.origin.x + (left), rect.origin.y, rect.size.width - (left) - (right), rect.size.height)

#define RECT_STACKED_OFFSET_BY_X(rect, offset) CGRectMake(rect.origin.x + rect.size.width + (offset), rect.origin.y, rect.size.width, rect.size.height)
#define RECT_STACKED_OFFSET_BY_Y(rect, offset) CGRectMake(rect.origin.x, rect.origin.y + rect.size.height + (offset), rect.size.width, rect.size.height)

// IMAGES

#define IMAGE(x) ([UIImage imageNamed:(x)])

// GEOMETRY

#define DEG_TO_RAD(degrees) ((degrees) * M_PI / 180.0)
#define RAD_TO_DEG(radians) ((radians) * 180.0 / M_PI)

// SELECTORS

#define SEL(x) @selector(x)

// STRINGS

#define IS_EMPTY_STRING(str) (!(str) || ![(str) isKindOfClass:NSString.class] || [(str) length] == 0)
#define IS_POPULATED_STRING(str) ((str) && [(str) isKindOfClass:NSString.class] && [(str) length] > 0)

// SCREEN/DISPLAY

#define IS_DEVICE_ORIENTATION_PORTRAIT ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait)
#define IS_DEVICE_ORIENTATION_LANDSCAPE ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight)
#define IS_DEVICE_ORIENTATION_LANDSCAPE_LEFT ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft)
#define IS_DEVICE_ORIENTATION_LANDSCAPE_RIGHT ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight)
#define IS_DEVICE_ORIENTATION_PORTRAIT_UPSIDE_DOWN ([UIDevice currentDevice].orientation == UIDeviceOrientationPortraitUpsideDown)
#define IS_DEVICE_ORIENTATION_FACE_UP ([UIDevice currentDevice].orientation == UIDeviceOrientationFaceUp)
#define IS_DEVICE_ORIENTATION_FACE_DOWN ([UIDevice currentDevice].orientation == UIDeviceOrientationFaceDown)

#define HARDWARE_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define HARDWARE_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// DUMPS
#define RECT_TO_STR(r) ([NSString stringWithFormat:@"X=%0.1f Y=%0.1f W=%0.1f H=%0.1f", (r).origin.x, (r).origin.y, (r).size.width, (r).size.height])
#define POINT_TO_STR(p) ([NSString stringWithFormat:@"X=%0.1f Y=%0.1f", (p).x, (p).y])
#define SIZE_TO_STR(s) ([NSString stringWithFormat:@"W=%0.1f H=%0.1f", (s).width, (s).height])

// HARDWARE/DEVICE INFO

#define DEVICE_UDID ([UIDevice currentDevice].uniqueIdentifier)

#define IS_IPAD ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
#define IS_IPHONE ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)

// HARDWARE/DEVICE CAPABILITY

#define IS_CLASSIC_DISPLAY (([UIScreen mainScreen].scale < 1.5F))
#define IS_RETINA_DISPLAY (([UIScreen mainScreen].scale > 1.5F))

#define IS_MULTITASKING_IN_SDK ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)] && [[UIDevice currentDevice] isMultitaskingSupported] == YES) 
#define IS_CAMERA_IN_SDK ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])

// COLORS

#define RGB256_TO_COL(col) ((col) / 255.0f)
#define COL_TO_RGB256(col) ((int)((col) * 255.0))

// DIRECTORIES

#define DOCUMENTS_DIR ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject])

