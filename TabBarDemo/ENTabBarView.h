//
//  ENTabBarView.h
//  TabBarDemo
//
//  Created by Aaron Elkins on 7/25/14.
//  Copyright (c) 2014 PixelEgg. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ENTabView.h"

@interface ENTabBarView : NSView{
    
}
@property (readwrite) NSColor *bgColor;
@property (readwrite) NSColor *tabBGColor;
@property (readwrite) NSColor *tabActivedBGColor;
@property (readwrite) NSColor *tabBorderColor;

@property (readwrite) ENTabView *activeTabView;

+ (id)viewWithSupperView:(NSView *)superView;
- (id)addTabView;
@end
