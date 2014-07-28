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
    // tabBarView = [ENTabBarView viewWithSupperView:[[self window] contentView]];
    
    NSColor *bgColor = [NSColor colorWithCalibratedRed: 0.6 green:0.6 blue:0.6 alpha:1.0];
    [tabBarView setBgColor:bgColor];
    
    NSColor *tabColor = [NSColor colorWithCalibratedRed: 0.68 green: 0.68 blue: 0.68 alpha:1.0];
    [tabBarView setTabBGColor:tabColor];
    
    [[textView enclosingScrollView] setBorderType:NSNoBorder];
    ENTabCell *t1 = [tabBarView addTabViewWithTitle:@"Elk Developer's Note.rtf"];
    [t1 setAsActiveTab];
    
    [tabBarView addTabViewWithTitle:@"index.html"];
    [tabBarView redraw];
}

@end
