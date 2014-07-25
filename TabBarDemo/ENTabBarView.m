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

+ (id)viewWithSupperView:(NSView *)superView{
    NSRect rect = [superView bounds];
    rect.origin = NSZeroPoint;
    rect.size = NSMakeSize([superView bounds].size.width, kTabBarViewHeight);
    ENTabBarView *tabBarView = [[ENTabBarView alloc] initWithFrame:rect];
    [tabBarView setAutoresizingMask:NSViewWidthSizable];
    [superView addSubview:tabBarView];
    return tabBarView;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        bgColor = [NSColor colorWithSRGBRed:0.16 green: 0.17 blue: 0.21 alpha:1.0];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [bgColor set];
    NSRectFill([self bounds]);
}

- (id)addTabView{
    ENTabView *tab = [ENTabView tabViewInTabBarView:self];
    return tab;
}
@end
