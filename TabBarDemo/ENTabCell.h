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
    
}

@property (readwrite) ENTabBarView *tabBarView;
@property (readwrite) BOOL isActived;

+ (id)tabCellWithTabBarView:(ENTabBarView*)tabBarView;
- (void)setAsActiveTab;
- (void)draw;
@end
