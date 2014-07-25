//
//  ENTabView.m
//  TabBarDemo
//
//  Created by Aaron Elkins on 7/25/14.
//  Copyright (c) 2014 PixelEgg. All rights reserved.
//

#import "ENTabView.h"

@implementation ENTabView

@synthesize isActived;

+ (id)tabViewInTabBarView:(ENTabBarView*)tabBarView{
    ENTabView *tabView = [[ENTabView alloc] initWithFrame:NSZeroRect];
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
    
    // Drawing code here.
}

@end
