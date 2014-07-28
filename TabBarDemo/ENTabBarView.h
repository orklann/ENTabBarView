//
//  ENTabBarView.h
//  TabBarDemo
//
//  Created by Aaron Elkins on 7/25/14.
//  Copyright (c) 2014 PixelEgg. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ENTabCell.h"

@interface ENTabBarView : NSView<NSMenuDelegate>{
    NSMutableArray *tabs;
    NSBezierPath *tabListControlPath;
    NSColor *oldSmallControlColor;
    NSTrackingArea *trackingArea;
}

@property (readwrite) NSColor *smallControlColor;
@property (readwrite) NSMutableArray *tabs;
@property (readwrite) ENTabCell *selectedTab;
@property (readwrite) NSColor *bgColor;
@property (readwrite) NSColor *tabBGColor;
@property (readwrite) NSColor *tabActivedBGColor;
@property (readwrite) NSColor *tabBorderColor;
@property (readwrite) NSColor *tabTitleColor;
@property (readwrite) NSColor *tabActivedTitleColor;

- (id)addTabViewWithTitle:(NSString *)title;
- (void)redraw;

- (void)popupMenuDidChoosed;
@end
