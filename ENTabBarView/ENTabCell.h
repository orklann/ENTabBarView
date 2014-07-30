//
//  ENTabView.h
//  TabBarDemo
//
//  Created by Aaron Elkins on 7/25/14.
//  Copyright (c) 2014 PixelEgg. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ENTabBarView;

@interface ENTabCell : NSObject{
    NSBezierPath *path;
}

@property (readwrite) BOOL canDrawCloseButton;
@property (readwrite) NSString *title;
@property (readwrite) NSMutableAttributedString *titleAttributedString;
@property (readonly) NSBezierPath *path;
@property (readwrite) NSRect frame;
@property (readwrite) ENTabBarView *tabBarView;
@property (readwrite) BOOL isActived;
@property (readwrite) BOOL isDraggingTab; // We did not use this in draw, just leave it here

+ (id)tabCellWithTabBarView:(ENTabBarView*)tabBarView title:(NSString *)aTittle;
- (void)setAsActiveTab;
- (void)draw;

/* forward mouse event to tab */
- (void)mouseDown:(NSEvent *)theEvent;
- (void)mouseMoved:(NSEvent *)theEvent;
@end
