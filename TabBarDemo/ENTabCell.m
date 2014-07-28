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

@implementation ENTabCell

@synthesize path;
@synthesize frame;
@synthesize isActived;
@synthesize tabBarView;
@synthesize title;
@synthesize titleAttributedString;

+ (id)tabCellWithTabBarView:(ENTabBarView*)tabBarView title:(NSString *)aTittle{
    ENTabCell *tabCell = [[ENTabCell alloc] init];
    [tabCell setTabBarView:tabBarView];
    [tabCell setIsActived:NO];
    [tabCell setTitle:aTittle];
    return tabCell;
}


// tab cell draw itself in this method, called in TabBarView's drawRect method
// - :>
- (void)draw{
    NSRect rect = [self frame];
    rect = NSInsetRect(rect, kBorderWidth / 2.0, kBorderWidth / 2.0);
    rect = NSIntegralRect(rect);
    rect.origin.x -= 0.5;
    rect.origin.y -= 0.5; // Fix: get rid of 1 pixel bottom line in cell
    
    float radius = 4.0;
    path = [NSBezierPath bezierPath];
    
    float deltaXfromLeftAndRight = 3;
    
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
    NSFont *font = [NSFont fontWithName:@"Helvetica Neue" size:12];
    NSColor *fontColor = [self isActived]?[[self tabBarView] tabActivedTitleColor] : [[self tabBarView] tabTitleColor];
    NSMutableParagraphStyle* p = [[NSMutableParagraphStyle alloc] init];
    p.alignment = kCTTextAlignmentCenter;
    [attrs setObject:font forKey:NSFontAttributeName];
    [attrs setObject:fontColor forKey:NSForegroundColorAttributeName];
    [attrs setObject:p forKey:NSParagraphStyleAttributeName];
    NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] initWithString:self.title attributes:attrs];
    
    [self setTitleAttributedString:mas];
    
    // Fix text layout: vertically center
    // [Todo]Fix: Close button by shifting rect 
    NSRect titleRect = [self frame];
    CGFloat fontHeight = self.titleAttributedString.size.height;
    int yOffset = (titleRect.size.height - fontHeight) / 2.0;
    
    titleRect.size.height = fontHeight;
    titleRect.origin.y += yOffset;
    [[self titleAttributedString] drawInRect:titleRect  ];
}

#pragma mark -- Set as active tab --
- (void)setAsActiveTab{
    NSUInteger index = 0;
    NSMutableArray *tabs = [[self tabBarView] tabs];
    for(index = 0; index < [tabs count]; ++ index){
        ENTabCell *tab = [tabs objectAtIndex:index];
        [tab setIsActived:NO];
    }
    
    [self setIsActived:YES];
    [[self tabBarView] setSelectedTab:self];
}

@end
