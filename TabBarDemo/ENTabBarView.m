//
//  ENTabBarView.m
//  TabBarDemo
//
//  Created by Aaron Elkins on 7/25/14.
//  Copyright (c) 2014 PixelEgg. All rights reserved.
//

#import "ENTabBarView.h"

#define kTabBarViewHeight 32
#define kWidthOfTabList 24
#define kHeightOfTabList 28
#define kMaxTabCellWidth 168
#define kTabCellHeight 28

@interface ENTabBarView (Expose)
- (NSRect)tabRectFromIndex:(NSUInteger)index;
- (NSRect)rectForTabListControl;
- (BOOL)isBlankAreaOfTabBarView:(NSPoint)p;
@end

@implementation ENTabBarView (Expose)
- (NSRect)tabRectFromIndex:(NSUInteger)index{
    CGFloat x = kWidthOfTabList + (index * kMaxTabCellWidth);
    CGFloat y = 0;
    CGFloat width = kMaxTabCellWidth;
    CGFloat height = kTabCellHeight;
    
    NSRect rect = NSMakeRect(x, y, width, height);
    return rect;
}

// Rect for left most tab list control
- (NSRect)rectForTabListControl{
    NSRect rect = NSMakeRect(0, 0, kWidthOfTabList, kHeightOfTabList);
    return rect;
}

- (BOOL)isBlankAreaOfTabBarView:(NSPoint)p{
    // Check tab list control
    NSRect rect = [self rectForTabListControl];
    if (NSPointInRect(p, rect)) {
        return NO;
    }
    
    // Check all tabs path
    NSUInteger index = 0;
    for (index = 0; index < [tabs count]; ++index){
        ENTabCell *tab = [tabs objectAtIndex:index];
        NSBezierPath *path = [tab path];
        if ([path containsPoint:p]) {
            return NO;
        }
    }
    
    // Else return YES
    return YES;
}
@end

@implementation ENTabBarView

@synthesize bgColor;
@synthesize tabBGColor;
@synthesize tabActivedBGColor;
@synthesize tabBorderColor;
@synthesize tabTitleColor;
@synthesize tabActivedTitleColor;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        tabs = [NSMutableArray array];
        
        // Give all colors a default value if none given
        bgColor = [NSColor colorWithSRGBRed:0.16 green:0.17 blue: 0.21 alpha:1.0];
        tabBGColor = [NSColor colorWithSRGBRed:0.68 green:0.68 blue:0.68 alpha:1.0];
        tabActivedBGColor = [NSColor whiteColor];
        tabBorderColor = [NSColor colorWithSRGBRed:0.57 green:0.57 blue:0.57 alpha:1.0];
    }
    return self;
}


-(void)awakeFromNib{
    tabs = [NSMutableArray array];
}

/* Overriding this method fix the setFrame issue as well */
/*- (void)resizeSubviewsWithOldSize:(NSSize)oldSize{
    NSRect rect = [[self superview] bounds];
    rect.origin = NSMakePoint(0, rect.size.height - kTabBarViewHeight);
    rect.size.height = kTabBarViewHeight;
    [self setFrame:rect];
    [self setNeedsDisplay:YES];
    NSLog(@"[*]%@", NSStringFromRect(rect));
    [self setNeedsLayout:YES];
}*/

- (void)resizeWithOldSuperviewSize:(NSSize)oldSize{
    NSRect rect = [[self superview] bounds];
    rect.origin = NSMakePoint(0, rect.size.height - kTabBarViewHeight);
    rect.size.height = kTabBarViewHeight;
    [self setFrame:rect];
    [self setNeedsDisplay:YES];
    [self setNeedsLayout:YES];
}

- (void)redraw{
    [self setNeedsDisplay:YES];
    
    /* Call this method here, and we don't need to setup layout in Interface Builder
     * And we need to call [tabBarView redraw] after launch to keep layout, so that this method 
     * would be called here.
     */
    [self resizeWithOldSuperviewSize:NSZeroSize];
}

- (void)mouseUp:(NSEvent*)event {
    if (event.clickCount == 2) { // We capture user double click on tabbar view
        NSLog(@"Double Click up.");
    }
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];

    // Drawing background color of Tab bar view.
    [bgColor set];
    NSRect rect = [self frame];
    rect.origin = NSZeroPoint;
    NSRectFill(rect);

    // Drawing bottom border line
    NSPoint start = NSMakePoint(0, 1);
    NSPoint end = NSMakePoint(NSMaxX(rect), 1);
    [NSBezierPath setDefaultLineWidth:2.0];
    [tabBorderColor set];
    [NSBezierPath strokeLineFromPoint:start toPoint:end];
    
    /*
     * Draw all tab cells
     * (*) All are not subclass of NSView, but NSObject
     */
    NSUInteger index = 0;
    for(index = 0; index < [tabs count]; ++ index){
        NSRect rect = [self tabRectFromIndex:index];
        ENTabCell *tab = [tabs objectAtIndex:index];
        [tab setFrame:rect];
        [tab draw];
    }
}

- (id)addTabView{
    ENTabCell *tab = [ENTabCell tabCellWithTabBarView:self];
    [tabs addObject:tab];
    return tab;
}

- (void)mouseDown:(NSEvent *)theEvent{    
    NSUInteger index = 0;
    NSPoint p = [theEvent locationInWindow];
    p = [self convertPoint:p fromView:[[self window] contentView]];
    for(index = 0; index < [tabs count]; ++ index){
        ENTabCell *tab = [tabs objectAtIndex:index];
        // Use [NSBezierPath containsPoint] to check clicking
        //NSRect rect = [tab frame];
        //
        /*if(NSPointInRect(p, rect)){
            [tab setAsActiveTab];
        }else{
            [tab setIsActived:NO];
        }*/
        if([[tab path] containsPoint:p]){
            [tab setAsActiveTab];
        }else{
            [tab setIsActived:NO];
        }
    };
    
    [[self selectedTab] setAsActiveTab];
    [self redraw];
}
@end
