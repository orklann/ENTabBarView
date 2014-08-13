//
//  ENTabView.m
//  TabBarDemo
//
//  Created by Aaron Elkins on 7/25/14.
//  Copyright (c) 2014 PixelEgg. All rights reserved.
//

#import "ENTabCell.h"
#import "ENTabBarView.h"

#define kBorderWidth 2

#define kCloseButtonWidth 8

#define deltaXfromLeftAndRight 2

@implementation ENTabCell

@synthesize path;
@synthesize frame;
@synthesize isActived;
@synthesize tabBarView;
@synthesize title;
@synthesize titleAttributedString;
@synthesize canDrawCloseButton;
@synthesize isDraggingTab;

+ (id)tabCellWithTabBarView:(ENTabBarView*)tabBarView title:(NSString *)aTittle{
    ENTabCell *tabCell = [[ENTabCell alloc] init];
    [tabCell setTabBarView:tabBarView];
    [tabCell setIsActived:NO];
    [tabCell setTitle:aTittle];
    [tabCell setCanDrawCloseButton:NO];
    [tabCell setIsDraggingTab:NO];
    return tabCell;
}

- (NSRect)closeButtonRect{
    NSRect tabRect = [self frame];
    CGFloat maxX = NSMaxX(tabRect);
    NSRect rect = NSMakeRect(maxX - tabRect.size.height - deltaXfromLeftAndRight - 1, 0, tabRect.size.height, tabRect.size.height);
    rect = CGRectInset(rect, kCloseButtonWidth + 2, kCloseButtonWidth + 2);
    return rect;
}

- (void)drawCloseButton{
    NSRect closeButtonRect = [self closeButtonRect];
    NSBezierPath *closeButtonPath = [NSBezierPath bezierPath];
    CGFloat minX = NSMinX(closeButtonRect);
    CGFloat maxX = NSMaxX(closeButtonRect);
    CGFloat minY = NSMinY(closeButtonRect);
    CGFloat maxY = NSMaxY(closeButtonRect);
    
    NSPoint leftBottomPoint = NSMakePoint(minX, minY);
    NSPoint leftTopPoint = NSMakePoint(minX, maxY);
    NSPoint rightBottomPoint = NSMakePoint(maxX, minY);
    NSPoint rightTopPoint = NSMakePoint(maxX, maxY);
    
    [closeButtonPath moveToPoint:leftBottomPoint];
    [closeButtonPath lineToPoint:rightTopPoint];
    
    [closeButtonPath moveToPoint:leftTopPoint];
    [closeButtonPath lineToPoint:rightBottomPoint];
    
    [closeButtonPath setLineWidth:2.0];
    [[[self tabBarView] smallControlColor] set];
    
    [closeButtonPath stroke];
}

// tab cell draw itself in this method, called in TabBarView's drawRect method
// - :>
- (void)draw{
    if (isDraggingTab) {
        //return ;
    }
    
    NSRect rect = [self frame];
    rect = NSInsetRect(rect, kBorderWidth / 2.0, kBorderWidth / 2.0);
    rect = NSIntegralRect(rect);
    rect.origin.x -= 0.5;
    rect.origin.y -= 0.5; // Fix: get rid of 1 pixel bottom line in cell
    
    float radius = 4.0;
    path = [NSBezierPath bezierPath];
    
    int minX = NSMinX(rect);
    int midX = NSMidX(rect);
    int maxX = NSMaxX(rect);
    int minY = NSMinY(rect);
    int midY = NSMidY(rect);
    int maxY = NSMaxY(rect);
    
    NSPoint leftBottomPoint = NSMakePoint(minX, minY);
    NSPoint leftMiddlePoint = NSMakePoint(minX + deltaXfromLeftAndRight, midY);
    NSPoint topMiddlePoint = NSMakePoint(midX, maxY);
    NSPoint rightMiddlePoint = NSMakePoint(maxX - deltaXfromLeftAndRight, midY);
    NSPoint rightBottomPoint = NSMakePoint(maxX, minY);
    
    
    // Start to construct border path
    
    // move path to left bottom point
    [path moveToPoint:leftBottomPoint];
    
    // left bottom to left middle
    [path appendBezierPathWithArcFromPoint:NSMakePoint(minX + deltaXfromLeftAndRight, minY) toPoint:leftMiddlePoint radius:radius];
    
    // left middle to top middle
    [path appendBezierPathWithArcFromPoint:NSMakePoint(minX + deltaXfromLeftAndRight, maxY) toPoint:topMiddlePoint radius:radius];
    
    // top middle to right middle
    [path appendBezierPathWithArcFromPoint:NSMakePoint(maxX - deltaXfromLeftAndRight, maxY) toPoint:rightMiddlePoint radius:radius];
    
    // right middle to right bottom
    [path appendBezierPathWithArcFromPoint:NSMakePoint(maxX - deltaXfromLeftAndRight, minY) toPoint:rightBottomPoint radius:radius];
    
    //left bottom to right bottom -- line
    //[path lineToPoint:leftBottomPoint];
    
    [path setLineWidth:kBorderWidth];
    
    // Draw tab background 
    
    if ([self isActived]) {
        [[[self tabBarView] tabActivedBGColor] set];
    }else{
        [[[self tabBarView] tabBGColor] set];
    }
    
    [path fill];
    
    //
    // Start here |--------->
    // Draw outline border
    //
    //[path closePath]; Comment out this line to prevent stroke cell bottom line 
    [[[self tabBarView] tabBorderColor] set];
    [path stroke];

    
    // If finally not a active tab, draw bottom line
    if (![self isActived]) {
        NSBezierPath *linePath = [NSBezierPath bezierPath];
        [linePath moveToPoint:leftBottomPoint];
        [linePath lineToPoint:rightBottomPoint];
        
        // Why plus 1? Coz we operated on points before, so shift 1 pixel width
        // *_*
        [linePath setLineWidth:kBorderWidth+1];
        [[[self tabBarView] tabBorderColor] set];
        [linePath stroke];
    }
    
    // Draw title
    /* Setup title's attributed string */
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    
    NSColor *fontColor = [self isActived]?[[self tabBarView] tabActivedTitleColor] : [[self tabBarView] tabTitleColor];
    NSMutableParagraphStyle* p = [[NSMutableParagraphStyle alloc] init];
    p.alignment = kCTTextAlignmentCenter;
    p.lineBreakMode = NSLineBreakByTruncatingTail;
    [attrs setObject:[[self tabBarView] tabFont] forKey:NSFontAttributeName];
    [attrs setObject:fontColor forKey:NSForegroundColorAttributeName];
    [attrs setObject:p forKey:NSParagraphStyleAttributeName];
    NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] initWithString:self.title attributes:attrs];
    
    [self setTitleAttributedString:mas];


    // Fix text layout: vertically center
    // [Done]Fix: Close button by shifting rect
    NSRect titleRect = [self frame];
    CGFloat fontHeight = self.titleAttributedString.size.height;
    int yOffset = (titleRect.size.height - fontHeight) / 2.0;
    
    titleRect.size.height = fontHeight;
    titleRect.origin.y += yOffset;
    titleRect = NSInsetRect(titleRect, deltaXfromLeftAndRight + 26, 0);
    [self.titleAttributedString drawInRect:titleRect];
    
    // Draw close button if mouse on close button rect
    if ([self canDrawCloseButton]) {
        [self drawCloseButton];
    }
}

#pragma mark -- Set as active tab --
- (void)setAsActiveTab{
    if ([[self tabBarView] selectedTab] == self) {
        return ;
    }
    
    NSUInteger index = 0;
    NSMutableArray *tabs = [[self tabBarView] tabs];
    for(index = 0; index < [tabs count]; ++ index){
        ENTabCell *tab = [tabs objectAtIndex:index];
        [tab setIsActived:NO];
    }
    
    // Call delegate protocol methods
    if([[[self tabBarView] delegate] respondsToSelector:@selector(tabWillActive:)]){
        [[[self tabBarView] delegate] tabWillActive:self];
    }
    
    [self setIsActived:YES];
    
    if([[[self tabBarView] delegate] respondsToSelector:@selector(tabDidActived:)]){
        [[[self tabBarView] delegate] tabDidActived:self];
    }
    [[self tabBarView] setSelectedTab:self];
}

#pragma mark == Forwar mouse event to tab ==
- (void)mouseDown:(NSEvent *)theEvent{
    NSPoint p = [theEvent locationInWindow];
    p = [[self tabBarView] convertPoint:p fromView:[[[self tabBarView] window] contentView]];
    
    if (NSPointInRect(p ,[self closeButtonRect])) {
        // Delete this tab cell
        id delegate = [[self tabBarView] delegate];
        if ([delegate respondsToSelector:@selector(tabWillClose:)]) {
            [delegate tabWillClose:self];
        }
        [[self tabBarView] removeTabCell:self];
        if ([delegate respondsToSelector:@selector(tabDidClosed:)]) {
            [delegate tabDidClosed:self];
        }
    }else{
        // Do nothing
    }

}

- (void)mouseMoved:(NSEvent *)theEvent{
    NSPoint p = [theEvent locationInWindow];
    p = [[self tabBarView] convertPoint:p fromView:[[[self tabBarView] window] contentView]];
    
    if (NSPointInRect(p ,[self closeButtonRect])) {
        canDrawCloseButton = YES;
    }else{
        canDrawCloseButton = NO;
    }
}

@end
