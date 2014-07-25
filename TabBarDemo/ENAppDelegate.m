//
//  ENAppDelegate.m
//  TabBarDemo
//
//  Created by Aaron Elkins on 7/25/14.
//  Copyright (c) 2014 PixelEgg. All rights reserved.
//

#import "ENAppDelegate.h"

@implementation ENAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //[[[self window] contentView] setFlipped:YES];
    //tabBarView = [ENTabBarView viewWithSupperView:[[self window] contentView]];
    
    ENTabView *t1 = [tabBarView addTabView];
    [t1 setAsActiveTabView];

}

@end
