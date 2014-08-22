//
//  ENTabBarView.h
//  TabBarDemo
//
//  Created by Aaron Elkins on 7/25/14.
//  Copyright (c) 2014 PixelEgg. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ENTabCell.h"
#import "ENTabImage.h"

@protocol ENTabBarViewDelegate;

@interface ENTabBarView : NSView<NSMenuDelegate>{
    NSMutableArray *tabs;
    NSBezierPath *tabListControlPath;
    NSTrackingArea *trackingArea;
    NSMenu *menu;
    
    BOOL isDragging;
    NSInteger destinationIndex;
    NSInteger sourceIndex;
    ENTabCell *draggingTab;
    ENTabImage *draggingImage;
}


@property (readwrite) NSFont *tabFont;
@property (readwrite) NSMutableArray *tabs;
@property (readwrite) ENTabCell *selectedTab;
@property (readwrite) NSColor *bgColor;
@property (readwrite) NSColor *tabBGColor;
@property (readwrite) NSColor *tabActivedBGColor;
@property (readwrite) NSColor *tabBorderColor;
@property (readwrite) NSColor *tabTitleColor;
@property (readwrite) NSColor *tabActivedTitleColor;
@property (readwrite) NSColor *smallControlColor;
@property (readwrite) id<ENTabBarViewDelegate> delegate;

- (id)addTabViewWithTitle:(NSString *)title;
- (void)redraw;
- (void)removeTabCell:(ENTabCell*)tabCell;
@end

// ENTabBarView Delegates methods
// Implement these methods to intercept your code
//
@protocol ENTabBarViewDelegate <NSObject>

@optional

/* =============================================================
 * Usually we store tabs (ENTabCell*) as a key in a NSDitionary,
 * And other object as a value to identify which tab in the foll-
 * owing events.
 * If you need to know the tab index(order), you can get it like
 * this:
 * NSInteger index = [[tabBarView tabs] indexOfObject:tab]];
 * Here **tabBarView** is an instance of ENTabBarView
 * ============================================================*/

- (void)tabWillActive:(ENTabCell*)tab;
- (void)tabDidActived:(ENTabCell*)tab;

- (void)tabWillClose:(ENTabCell*)tab;
- (void)tabDidClosed:(ENTabCell*)tab;

- (void)tabWillBeCreated:(ENTabCell*)tab;
- (void)tabDidBeCreated:(ENTabCell*)tab;
@end
