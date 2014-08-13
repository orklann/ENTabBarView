//
//  ENTabBarView.m
//  TabBarDemo
//
//  Created by Aaron Elkins on 7/25/14.
//  Copyright (c) 2014 PixelEgg. All rights reserved.
//

#import "ENTabBarView.h"
#import "ENTabImage.h"

#define kTabBarViewHeight 32
#define kWidthOfTabList 24
#define kHeightOfTabList 28
#define kMaxTabCellWidth 180
#define kMinTabCellWidth 100
#define kTabCellHeight 28

@interface ENTabBarView (Expose)
- (NSRect)tabRectFromIndex:(NSUInteger)index;
- (NSRect)rectForTabListControl;
- (BOOL)isBlankAreaOfTabBarViewInPoint:(NSPoint)p;
- (NSMenu *)tabsMenu;
- (void)popupMenuDidChoosed:(NSMenuItem*)item;
- (BOOL)validateMenuItem:(NSMenuItem*)menuItem;
- (ENTabCell*)tabCellInPoint:(NSPoint)p;
- (NSInteger)destinationCellIndexFromPoint:(NSPoint)p;
- (void)exchangeTabWithIndex:(NSUInteger)One withTabIndex:(NSUInteger)two;
@end

@implementation ENTabBarView (Expose)
- (NSRect)tabRectFromIndex:(NSUInteger)index{
    NSUInteger totalWidthOfTabBarView = [self frame].size.width - kWidthOfTabList - 12;
    NSUInteger averageWidth = (NSUInteger)(totalWidthOfTabBarView / [tabs count]);
    
    averageWidth = averageWidth <= kMinTabCellWidth ? kMinTabCellWidth : averageWidth;
    averageWidth = averageWidth >= kMaxTabCellWidth ? kMaxTabCellWidth : averageWidth;
    
    CGFloat x = kWidthOfTabList + (index * averageWidth);
    CGFloat y = 0;
    CGFloat width = averageWidth;
    CGFloat height = kTabCellHeight;
    
    NSRect rect = NSMakeRect(x, y, width, height);
    return rect;
}

// Rect for left most tab list control
- (NSRect)rectForTabListControl{
    NSRect rect = NSMakeRect(0, 0, kWidthOfTabList, kHeightOfTabList);
    rect = CGRectInset(rect, 6, 10);
    return rect;
}

- (BOOL)isBlankAreaOfTabBarViewInPoint:(NSPoint)p{
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

- (NSMenu *)tabsMenu {
    menu = [[NSMenu alloc] initWithTitle:@"Contextual Menu"];
    NSUInteger index = 0;
    for (index = 0; index < [tabs count]; index++) {
        ENTabCell *tab = [tabs objectAtIndex:index];
        [menu insertItemWithTitle:[tab title] action:@selector(popupMenuDidChoosed:) keyEquivalent:@"" atIndex:index];
    }
    return menu;
}

- (void)popupMenuDidChoosed:(NSMenuItem*)item{
    NSUInteger index = [menu indexOfItem:item];
    if (index != -1) {
        ENTabCell *tab = [tabs objectAtIndex:index];
        NSRect tabRect = [tab frame];
        NSRect tabBarViewRect = [self bounds];
        // If the selected tab is not fully shown in the tabbar view, we
        // then exchange it with first(0 index) tab, and then active it.
        if (!CGRectContainsRect(tabBarViewRect, tabRect)) {
            NSUInteger tabIndex = [[self tabs] indexOfObject:tab];
            [self exchangeTabWithIndex:tabIndex withTab:0];
        }
        [tab setAsActiveTab];
    }
}

- (BOOL)validateMenuItem:(NSMenuItem*)menuItem{
    return YES;
}

- (ENTabCell*)tabCellInPoint:(NSPoint)p{
    NSUInteger index = 0;
    for (index = 0; index < [tabs count]; index++) {
        ENTabCell *tab = [tabs objectAtIndex:index];
        NSRect rect = [tab frame];
        if (NSPointInRect(p, rect)) {
            return tab;
        }
    }
    return nil;
}

- (NSInteger)destinationCellIndexFromPoint:(NSPoint)p{
    NSInteger index = 0;
    for (index = 0; index < [tabs count]; index++) {
        ENTabCell *tab = [tabs objectAtIndex:index];
        NSRect rect = [tab frame];
        CGFloat midX = NSMidX(rect);
        CGFloat minX = NSMinX(rect);
        CGFloat maxX = NSMaxX(rect);
        CGFloat minY = NSMinY(rect);
        CGFloat w = rect.size.width;
        CGFloat h = rect.size.height;
        
        NSInteger ret;
        NSRect firstRect = NSMakeRect(minX, minY, w/2, h);
        NSRect secondeRect = NSMakeRect(midX, minY, w/2, h);
        if (NSPointInRect(p, firstRect)) {
            ret = index; // don't substract by 1, fix bugs
            ret = ret >= 0 ? ret : 0;
            if(destinationIndex != -1 && index == destinationIndex){
                return destinationIndex;
            }
            return ret;
        }else if(NSPointInRect(p, secondeRect)){
            ret = index + 1;
            if (destinationIndex != -1 && index > destinationIndex) {
                ret -= 1;
            }else if(destinationIndex != -1 && index == destinationIndex){
                return destinationIndex;
            }
            return ret;
        }
        
        if (p.x > maxX && index == [tabs count] - 1) {
            if (destinationIndex != -1 && index >= destinationIndex) {
                return index;
            }else{
                return index + 1;
            }
        }
    }
    return -1;
}

- (void)exchangeTabWithIndex:(NSUInteger)one withTab:(NSUInteger)two{
    NSMutableArray *allTabs = [self tabs];
    [allTabs exchangeObjectAtIndex:one withObjectAtIndex:two];
}
@end

@implementation ENTabBarView

@synthesize tabs;
@synthesize bgColor;
@synthesize tabBGColor;
@synthesize tabActivedBGColor;
@synthesize tabBorderColor;
@synthesize tabTitleColor;
@synthesize tabActivedTitleColor;
@synthesize smallControlColor;
@synthesize tabFont;
@synthesize delegate;

#pragma mark - - - - - - - - -
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        tabs = [NSMutableArray array];
        
        // Give all colors a default value if none given
        bgColor = [NSColor colorWithCalibratedRed: 0.6 green:0.6 blue:0.6 alpha:1.0];
        tabBGColor = [NSColor colorWithCalibratedRed: 0.68 green: 0.68 blue: 0.68 alpha:1.0];
        tabActivedBGColor = [NSColor whiteColor];
        tabBorderColor = [NSColor colorWithCalibratedRed: 0.53 green:0.53 blue:0.53 alpha:1.0];
        tabTitleColor = [NSColor blackColor];
        tabActivedTitleColor = [NSColor blackColor];
        smallControlColor = [NSColor colorWithCalibratedRed:0.53 green:0.53 blue:0.53 alpha:1.0];
        
        // Font
        tabFont = [NSFont fontWithName:@"Lucida Grande" size:11];
        
        destinationIndex = -1;
        sourceIndex = -1;
        isDragging = NO;
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

- (void)removeTabCell:(ENTabCell*)tabCell{
    NSUInteger index = [[self tabs] indexOfObject:tabCell];
    if (index > 0) {
        index--;
    }
    [[self tabs] removeObject:tabCell];
    if ([tabs count] > 0) {
        ENTabCell *nextTab = [tabs objectAtIndex:index];
        [nextTab setAsActiveTab];
    }
    [self redraw];
}

- (void)mouseUp:(NSEvent*)event {
    if (event.clickCount == 2) { // We capture user double click on tabbar view
        NSPoint p =[event locationInWindow];
        p = [self convertPoint:p fromView:[[self window] contentView]];
        if ([self isBlankAreaOfTabBarViewInPoint:p]) {
            ENTabCell *tab = [self addTabViewWithTitle:@"Untitled"];
            [tab setAsActiveTab];
            [self redraw];
        }
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

    
    // Draw tab list control
    tabListControlPath = [NSBezierPath bezierPath];
    NSRect tabListRect = [self rectForTabListControl];
    tabListRect = NSIntegralRect(tabListRect);
    int maxY = NSMaxY(tabListRect);
    int minY = NSMinY(tabListRect);
    int minX = NSMinX(tabListRect);
    int maxX = NSMaxX(tabListRect);
    int midX = NSMidX(tabListRect);
    
    NSPoint p1 = NSMakePoint(midX, minY);
    NSPoint p2 = NSMakePoint(minX, maxY);
    NSPoint p3 = NSMakePoint(maxX, maxY);
    
    [tabListControlPath moveToPoint:p1];
    [tabListControlPath lineToPoint:p2];
    [tabListControlPath lineToPoint:p3];
    [tabListControlPath lineToPoint:p1];
    //[[self smallControlColor] set];
    // Use tab active back ground color to set tab list triangle
    [[self tabActivedBGColor] set];
    [tabListControlPath fill];
    
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
    // Reset all tool tips
    [self removeAllToolTips];
    NSInteger index = 0;
    for(index = 0; index < [tabs count]; ++index){
        NSRect rect = [self tabRectFromIndex:index];
        ENTabCell *tab = [tabs objectAtIndex:index];
        [tab setFrame:rect];
        [self setToolTip:[tab title]];
        [self addToolTipRect:[tab frame] owner:[tab title] userData:nil];
        [tab draw];
    }
}

- (id)addTabViewWithTitle:(NSString *)title{
    ENTabCell *tab = [ENTabCell tabCellWithTabBarView:self title:title];
    
    if ([[self delegate] respondsToSelector:@selector(tabWillBeCreated:)]) {
        [[self delegate] tabWillBeCreated:tab];
    }
    
    [tabs addObject:tab];
    [tab setAsActiveTab];
    
    if ([[self delegate] respondsToSelector:@selector(tabDidBeCreated:)]) {
        [[self delegate] tabDidBeCreated:tab];
    }
    
    [self redraw];
    return tab;
}

- (void)mouseDown:(NSEvent *)theEvent{
    NSPoint p = [theEvent locationInWindow];
    p = [self convertPoint:p fromView:[[self window] contentView]];
    
    /* Check if tabs list control clicked */
    NSRect rectOfTabList = NSMakeRect(0, 0, kWidthOfTabList, kHeightOfTabList);
    if (NSPointInRect(p, rectOfTabList)) {
        [NSMenu popUpContextMenu:[self tabsMenu] withEvent:theEvent forView:self];
    }
    
    
    /* Switch active tab */
    NSUInteger index = 0;
    for(index = 0; index < [tabs count]; ++ index){
        ENTabCell *tab = [tabs objectAtIndex:index];
        if([[tab path] containsPoint:p]){
            [tab setAsActiveTab];
            //[self setSelectedTab:tab];
            //[[self selectedTab] setAsActiveTab];
        }
        
        // forwar mouse down to tab cell
        [tab mouseDown:theEvent];
    };
    
    [self redraw];
    
    // Draging stuff
    isDragging = NO;
}

- (void)mouseMoved:(NSEvent *)theEvent{
    NSPoint p = [theEvent locationInWindow];
    p = [self convertPoint:p fromView:[[self window] contentView]];

    /* Check if tabs list control clicked
     * Commented out so that not used
     */
    if (NSPointInRect(p, [self rectForTabListControl])) {
        //self.smallControlColor = [self tabActivedBGColor];
    }else{
        //self.smallControlColor = [self tabActivedBGColor]; //oldSmallControlColor;
    }
    
    /* Switch active tab */
    NSUInteger index = 0;
    for(index = 0; index < [tabs count]; ++ index){
        ENTabCell *tab = [tabs objectAtIndex:index];
        // forwar mouse moved to tab cell
        [tab mouseMoved:theEvent];
    };

    [self redraw];
}

- (void)setFrame:(NSRect)frame {
    [super setFrame:frame];
    [self removeTrackingArea:trackingArea];
    
    NSTrackingAreaOptions options = (NSTrackingActiveAlways | NSTrackingInVisibleRect | NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved); trackingArea = [[NSTrackingArea alloc] initWithRect:[self frame] options:options owner:self userInfo:nil];
    [self addTrackingArea:trackingArea];
}

- (void)setBounds:(NSRect)bounds {
    [super setBounds:bounds];
    [self removeTrackingArea:trackingArea];
    
    NSTrackingAreaOptions options = (NSTrackingActiveAlways | NSTrackingInVisibleRect | NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved); trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds] options:options owner:self userInfo:nil];
    [self addTrackingArea:trackingArea];
}

#pragma mark Drag & Drop
- (NSDragOperation)draggingSourceOperationMaskForLocal:(BOOL)flag{
    return NSDragOperationNone;
}

- (void)mouseDragged:(NSEvent *)theEvent{
    NSPoint p = [theEvent locationInWindow];
    p = [self convertPoint:p fromView:[[self window] contentView]];
    if (!isDragging) {
        draggingTab = [self tabCellInPoint:p];
        isDragging = YES;
        if (draggingTab != nil) {
            draggingImage = [ENTabImage imageWithENTabCell:draggingTab];
            [draggingTab setIsDraggingTab:YES];
            // Save source index
            sourceIndex = [tabs indexOfObject:draggingTab];
            [tabs removeObject:draggingTab];
            [self redraw];
        }
    }
    
    if (draggingTab == nil) {
        return ;
    }
    
    NSSize offset = NSMakeSize(0.0, 0.0);
    
    p.x -= (draggingTab.frame.size.width / 2);
    p.y -= (draggingTab.frame.size.height / 2);
    [self dragImage:draggingImage at:p offset:offset event:theEvent pasteboard:nil source:self slideBack:NO];
}

- (void)draggedImage:(NSImage *)image movedTo:(NSPoint)screenPoint{
    
    screenPoint.x += (draggingTab.frame.size.width / 2);
    screenPoint.y += (draggingTab.frame.size.height / 2);
    NSPoint windowLocation = [[self window] convertScreenToBase:screenPoint];
    NSPoint viewPoint = [self convertPoint:windowLocation fromView:nil];
    
    NSRect tabBarViewRect = [self bounds];
    //tabBarViewRect = NSInsetRect(tabBarViewRect, 0, -40);
    
    if (!NSPointInRect(viewPoint, tabBarViewRect)) {
        //NSLog(@"Moved drag out");
        [tabs removeObject:draggingTab];
        destinationIndex = -1;
        [self redraw];
        return ;
    }
    
    destinationIndex = [self destinationCellIndexFromPoint:viewPoint];
    if (destinationIndex == -1) return ;
    //NSLog(@"Moved Dest index: %d", (int)destinationIndex);
    [tabs removeObject:draggingTab];
    [tabs insertObject:draggingTab atIndex:destinationIndex];
    [self redraw];

}

- (void)draggedImage:(NSImage *)image endedAt:(NSPoint)screenPoint operation:(NSDragOperation)operation{
    
    screenPoint.x += (draggingTab.frame.size.width / 2);
    screenPoint.y += (draggingTab.frame.size.height / 2);
    NSPoint windowLocation = [[self window] convertScreenToBase:screenPoint];
    NSPoint viewPoint = [self convertPoint:windowLocation fromView:nil];
    
    NSRect tabBarViewRect = [self bounds];
    if (!NSPointInRect(viewPoint, tabBarViewRect)) {
        [draggingTab setIsDraggingTab:NO]; // Not used? Yes, not used. Just let it be here
        [tabs removeObject:draggingTab];
        [tabs insertObject:draggingTab atIndex:sourceIndex];
        [self redraw];
        sourceIndex = -1;
        destinationIndex = -1;
        return ;
    }
    
    destinationIndex = [self destinationCellIndexFromPoint:viewPoint];
    if (destinationIndex == -1) {
        return ;
    }
    [draggingTab setIsDraggingTab:NO];
    [tabs removeObject:draggingTab];
    [tabs insertObject:draggingTab atIndex:destinationIndex];
    [self redraw];
    
    destinationIndex = -1;
    sourceIndex = -1;
    isDragging = NO;
}
@end
