//
//  ENTabBarView.m
//  TabBarDemo
//
//  Created by Aaron Elkins on 7/25/14.
//  Copyright (c) 2014 PixelEgg. All rights reserved.
//

#import "ENTabBarView.h"
#import "ENTabView.h"

#define kTabBarViewHeight 36
#define kLeftPaddingOfTabBarView 16

@implementation ENTabBarView

@synthesize activeTabView;
@synthesize bgColor;
@synthesize tabBGColor;
@synthesize tabActivedBGColor;
@synthesize tabBorderColor;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Give all colors a default value if none given
        bgColor = [NSColor colorWithSRGBRed:0.16 green:0.17 blue: 0.21 alpha:1.0];
        tabBGColor = [NSColor colorWithSRGBRed:0.68 green:0.68 blue:0.68 alpha:1.0];
        tabActivedBGColor = [NSColor whiteColor];
        tabBorderColor = [NSColor colorWithSRGBRed:0.57 green:0.57 blue:0.57 alpha:1.0];
    }
    return self;
}


-(void)awakeFromNib{

}

- (void)resizeSubviewsWithOldSize:(NSSize)oldSize{
    NSRect rect = [[self superview] bounds];
    rect.origin = NSMakePoint(0, rect.size.height - kTabBarViewHeight);
    rect.size.height = kTabBarViewHeight;
    [self setFrame:rect];
    [self setNeedsDisplay:YES];
    NSLog(@"[*]%@", NSStringFromRect(rect));
    [self setNeedsLayout:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];

    // Drawing background color of Tab bar view.
    [bgColor set];
    NSRect rect = [self frame];
    rect.origin = NSZeroPoint;
    NSLog(@"%@", NSStringFromRect(rect));
    NSRectFill(rect);

    // Drawing bottom border line
    NSPoint start = NSMakePoint(0, 1);
    NSPoint end = NSMakePoint(NSMaxX(rect), 1);
    [NSBezierPath setDefaultLineWidth:2.0];
    [tabBorderColor set];
    [NSBezierPath strokeLineFromPoint:start toPoint:end];
}

- (id)addTabView{
    ENTabView *tab = [ENTabView tabViewInTabBarView:self];
    return tab;
}
@end
