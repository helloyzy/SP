//
//  IBButton.m
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

#import "IBButton.h"
#import "CGContext+Boost.h"
#import "UIColor+Boost.h"

@implementation IBButton
@synthesize color = _color;
@synthesize shineColor = _shineColor;
@synthesize type = _type;
@synthesize cornerRadius = _cornerRadius;
@synthesize borderColor = _borderColor;
@synthesize borderSize = _borderSize;

+(IBButton*) glossButtonWithTitle:(NSString*)title color:(UIColor*)color {
	IBButton *button = [[[IBButton alloc] init] autorelease];
	[button setTitle:title forState:UIControlStateNormal];
	button.type = IBButtonTypeGlossy;
	button.color = color;
	button.shineColor = [color colorBrighterByPercent:65.0];
	button.cornerRadius = 10;
	button.borderSize = 1;
	button.borderColor = [color colorDarkerByPercent:15.0];
	button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
	button.titleLabel.shadowOffset = CGSizeMake (-1.0, -0.0);
	return button;
}
+(IBButton*) softButtonWithTitle:(NSString*)title color:(UIColor*)color {
	IBButton *button = [[[IBButton alloc] init] autorelease];
	[button setTitle:title forState:UIControlStateNormal];
	button.type = IBButtonTypeSoft;
	button.color = color;
	button.shineColor = [color colorBrighterByPercent:50.0];
	button.cornerRadius = 10;
	button.borderSize = 1;
	button.borderColor = [color colorDarkerByPercent:15.0];
	button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
	button.titleLabel.shadowOffset = CGSizeMake (-1.0, -0.0);
	return button;
}
+(IBButton*) flatButtonWithTitle:(NSString*)title color:(UIColor*)color {
	IBButton *button = [[[IBButton alloc] init] autorelease];
	[button setTitle:title forState:UIControlStateNormal];
	button.type = IBButtonTypeFlat;
	button.color = color;
	button.cornerRadius = 10;
	button.borderSize =	1;
	button.borderColor = [color colorDarkerByPercent:15.0];
	button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
	button.titleLabel.shadowOffset = CGSizeMake (-1.0, -0.0);
	return button;
}

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	[self setNeedsDisplay];
}

- (void)setEnabled:(BOOL)enabled {
	[super setEnabled:enabled];
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
	
	UIColor *baseColor = self.color;
	UIColor *edgeColor = self.borderColor;
	UIColor *highColor = self.shineColor;

	if (self.highlighted && self.adjustsImageWhenHighlighted) {
		baseColor = [self.color colorDarkerByPercent:40.0];
		edgeColor = [self.borderColor colorDarkerByPercent:40.0];
		highColor = [self.shineColor colorDarkerByPercent:40.0];
	}
	if (!self.enabled && self.adjustsImageWhenDisabled) {
		baseColor = [UIColor colorWithRGB:0x999999];
		edgeColor = [UIColor colorWithRGB:0x777777];
		highColor = [UIColor colorWithRGB:0xEEEEEE];
	}
	
	float half = (float)self.borderSize/2;
	CGRect inset = CGRectInset(rect, half, half);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	if (self.type == IBButtonTypeFlat) {
		//draw flat fill
		CGContextSaveGState(context);
		CGContextAddRoundedRect(context, inset, self.cornerRadius);
		CGContextSetFillColorWithColor(context, baseColor.CGColor);
		CGContextFillPath(context);
		CGContextRestoreGState(context);
		
	}else if(self.type == IBButtonTypeSoft) {
		//draw gradient fill
		CGContextSaveGState(context);
		
		CGContextAddRoundedRect(context, inset, self.cornerRadius);
		CGContextClip(context);
		
		CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
		NSArray *colors = [NSArray arrayWithObjects:(id)highColor.CGColor, (id)baseColor.CGColor, nil];
		CGFloat locations[2] = { 0.0, 0.6 };
		
		CGGradientRef gradient = CGGradientCreateWithColors(space, (CFArrayRef)colors, locations);
		CGPoint start = CGPointMake(0, inset.origin.y);
		CGPoint end = CGPointMake(0, inset.origin.y+inset.size.height);
		CGContextDrawLinearGradient (context, gradient, start, end, 0);
		
		CGColorSpaceRelease(space);
		CGGradientRelease(gradient);
		CGContextRestoreGState(context);
		
	}else if(self.type == IBButtonTypeGlossy) {
		//draw flat fill
		CGContextAddRoundedRect(context, inset, self.cornerRadius);
		CGContextSetFillColorWithColor(context, baseColor.CGColor);
		CGContextFillPath(context);
		
		//draw glossy fill
		CGContextSaveGState(context);
		CGContextAddRoundedRect(context, inset, self.cornerRadius);
		CGContextClip(context);
		
		CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
		UIColor *shineMinor = [highColor colorWithAlphaComponent:0.3];
		NSArray *colors = [NSArray arrayWithObjects:(id)highColor.CGColor, (id)shineMinor.CGColor, nil];
		CGFloat locations[2] = { 0.0, 1.0 };
		
		CGGradientRef gradient = CGGradientCreateWithColors(space, (CFArrayRef)colors, locations);
		CGPoint start = CGPointMake(0, inset.origin.y);
		CGPoint end = CGPointMake(0, inset.origin.y+(inset.size.height/2));
		CGContextDrawLinearGradient (context, gradient, start, end, 0);
		
		CGColorSpaceRelease(space);
		CGGradientRelease(gradient);
		CGContextRestoreGState(context);
	}
	
	//draw border
	CGContextAddRoundedRect(context, inset, self.cornerRadius);
	CGContextSetStrokeColorWithColor(context, edgeColor.CGColor);
	CGContextSetLineWidth(context, self.borderSize);
	CGContextStrokePath(context);
}

- (void)dealloc {
	[_color release];
	[_shineColor release];
    [super dealloc];
}

@end
