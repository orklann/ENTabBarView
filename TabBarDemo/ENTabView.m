//
//  ENTabView.m
//  TabBarDemo
//
//  Created by Aaron Elkins on 7/25/14.
//  Copyright (c) 2014 PixelEgg. All rights reserved.
//

#import "ENTabView.h"
#import "ENTabBarView.h"
@implementation ENTabView

@synthesize isActived;

+ (id)tabViewInTabBarView:(ENTabBarView*)tabBarView{
    ENTabView *tabView = [[ENTabView alloc] initWithFrame:NSZeroRect];
    [tabBarView addSubview:tabView];
    return tabView;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing tab here
    
}

#pragma mark -- Set as active tab --
- (void)setAsActiveTabView{
    NSArray *allTabViews = [[self superview] subviews];
    NSLog(@"%@", allTabViews);
    [self setIsActived:YES];
    
    [(ENTabBarView*)[self superview]  setActiveTabView:self];
}

@end
