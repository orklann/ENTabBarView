//
//  ENTabView.m
//  TabBarDemo
//
//  Created by Aaron Elkins on 7/25/14.
//  Copyright (c) 2014 PixelEgg. All rights reserved.
//

#import "ENTabCell.h"
#import "ENTabBarView.h"
@implementation ENTabCell

@synthesize isActived;
@synthesize tabBarView;
+ (id)tabCellWithTabBarView:(ENTabBarView*)tabBarView{
    ENTabCell *tabCell = [[ENTabCell alloc] init];
    [tabCell setTabBarView:tabBarView];
    return tabCell;
}


// tab cell draw itself in this method, called in TabBarView's drawRect method
// - :>
- (void)draw{
    
}

#pragma mark -- Set as active tab --
- (void)setAsActiveTab{
    
}

@end
