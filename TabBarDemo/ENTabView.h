//
//  ENTabView.h
//  TabBarDemo
//
//  Created by Aaron Elkins on 7/25/14.
//  Copyright (c) 2014 PixelEgg. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ENTabBarView;

@interface ENTabView : NSView{
    
}

@property (readwrite) BOOL isActived;

+ (id)tabViewInTabBarView:(ENTabBarView*)tabBarView;
- (void)setAsActiveTabView;
- (void)redraw;
@end
