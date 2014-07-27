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

@property (readwrite) BOOL isActived;

+ (id)tabCell;
- (void)setAsActiveTab;
- (void)redraw;
@end
