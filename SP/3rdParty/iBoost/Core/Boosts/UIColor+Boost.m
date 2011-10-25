//
//  UIColor+Boost.m
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

#import "UIColor+Boost.h"
#import "Macros.h"

// constants
const NSInteger MAX_RGB_COLOR_VALUE = 0xff;
const NSInteger MAX_RGB_COLOR_VALUE_FLOAT = 255.0f;

@implementation UIColor (Boost)

+ (UIColor *)colorWith256Red:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b {
	return [UIColor colorWithRed:RGB256_TO_COL(r) green:RGB256_TO_COL(g) blue:RGB256_TO_COL(b) alpha:1.0];
}

+ (UIColor *)colorWith256Red:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b alpha:(NSInteger)a {
	return [UIColor colorWithRed:RGB256_TO_COL(r) green:RGB256_TO_COL(g) blue:RGB256_TO_COL(b) alpha:RGB256_TO_COL(a)];
}
			
+ (UIColor *) colorWithRGBA:(uint) hex {
	return [UIColor colorWithRed:(CGFloat)((hex>>24) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT 
						   green:(CGFloat)((hex>>16) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT 
							blue:(CGFloat)((hex>>8) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT 
						   alpha:(CGFloat)((hex) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT];
}

+ (UIColor *) colorWithARGB:(uint) hex {
	return [UIColor colorWithRed:(CGFloat)((hex>>16) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT 
						   green:(CGFloat)((hex>>8) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT 
							blue:(CGFloat)(hex & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT 
						   alpha:(CGFloat)((hex>>24) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT];
}

+ (UIColor *) colorWithRGB:(uint) hex {
	return [UIColor colorWithRed:(CGFloat)((hex>>16) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT 
						   green:(CGFloat)((hex>>8) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT 
							blue:(CGFloat)(hex & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT 
						   alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
	uint hex;
	
	// chop off hash
	if ([hexString characterAtIndex:0] == '#') {
		hexString = [hexString substringFromIndex:1];
	}
	
	// depending on character count, generate a color
	NSInteger hexStringLength = hexString.length;
	
	if (hexStringLength == 3) {
		// RGB, once character each (each should be repeated)
		hexString = [NSString stringWithFormat:@"%c%c%c%c%c%c", [hexString characterAtIndex:0], [hexString characterAtIndex:0], [hexString characterAtIndex:1], [hexString characterAtIndex:1], [hexString characterAtIndex:2], [hexString characterAtIndex:2]];
		hex = strtoul([hexString UTF8String], NULL, 16);	

		return [self colorWithRGB:hex];
	} else if (hexStringLength == 4) {
		// RGBA, once character each (each should be repeated)
		hexString = [NSString stringWithFormat:@"%c%c%c%c%c%c%c%c", [hexString characterAtIndex:0], [hexString characterAtIndex:0], [hexString characterAtIndex:1], [hexString characterAtIndex:1], [hexString characterAtIndex:2], [hexString characterAtIndex:2], [hexString characterAtIndex:3], [hexString characterAtIndex:3]];
		hex = strtoul([hexString UTF8String], NULL, 16);		

		return [self colorWithRGBA:hex];
	} else if (hexStringLength == 6) {
		// RGB
		hex = strtoul([hexString UTF8String], NULL, 16);		
		
		return [self colorWithRGB:hex];
	} else if (hexStringLength == 8) {
		// RGBA
		hex = strtoul([hexString UTF8String], NULL, 16);		

		return [self colorWithRGBA:hex];
	}
	
	// illegal
	[NSException raise:@"Invalid Hex String" format:@"Hex string invalid: %@", hexString];
	
	return nil;
}

- (NSString *) hexString {
	const CGFloat *components = CGColorGetComponents(self.CGColor);
	
	NSInteger red = (int)(components[0] * MAX_RGB_COLOR_VALUE);
	NSInteger green = (int)(components[1] * MAX_RGB_COLOR_VALUE);
	NSInteger blue = (int)(components[2] * MAX_RGB_COLOR_VALUE);
	NSInteger alpha = (int)(components[3] * MAX_RGB_COLOR_VALUE);
	
	if (alpha < 255) {
		return [NSString stringWithFormat:@"#%02x%02x%02x%02x", red, green, blue, alpha];
	}
	
	return [NSString stringWithFormat:@"#%02x%02x%02x", red, green, blue];
}

- (UIColor*) colorBrighterByPercent:(float) percent {
	percent = MAX(percent, 0.0f);
	percent = (percent + 100.0f) / 100.0f;
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	CGFloat r = rgba[0];
	CGFloat g = rgba[1];
	CGFloat b = rgba[2];
	CGFloat a = rgba[3];
	CGFloat newR = r * percent;
	CGFloat newG = g * percent;
	CGFloat newB = b * percent;
	return [UIColor colorWithRed:newR green:newG blue:newB alpha:a];
}

- (UIColor*) colorDarkerByPercent:(float) percent {
	percent = MAX(percent, 0.0f);
	percent /= 100.0f;
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	CGFloat r = rgba[0];
	CGFloat g = rgba[1];
	CGFloat b = rgba[2];
	CGFloat a = rgba[3];
	CGFloat newR = r - (r * percent);
	CGFloat newG = g - (g * percent);
	CGFloat newB = b - (b * percent);
	return [UIColor colorWithRed:newR green:newG blue:newB alpha:a];
}

- (CGFloat)r {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	return rgba[0];
}

- (CGFloat)g {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	return rgba[1];
}

- (CGFloat)b {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	return rgba[2];
}

- (CGFloat)a {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	return rgba[3];
}
						
@end
