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
    [[textView enclosingScrollView] setBorderType:NSNoBorder];
    [textView setDrawsBackground:YES];
    
    [tabBarView setDelegate:self];
    
    /* Create two tab with titles */
    [tabBarView addTabViewWithTitle:@"Elk Developer's Note.txt"];
    [tabBarView addTabViewWithTitle:@"index.html.rjs"];
}

- (IBAction)newTab:(id)sender{
    [tabBarView addTabViewWithTitle:@"New Tab"];
    [tabBarView redraw];
}

#pragma mark ENTabBarView Delegate methods
- (void)tabWillActive:(ENTabCell *)tab{
    NSLog(@"Tab will active with title: %@", [tab title]);
}

- (void)tabDidActived:(ENTabCell *)tab{
    NSLog(@"Tab did actived with title: %@", [tab title]);
}

- (void)tabWillClose:(ENTabCell *)tab{
    NSLog(@"Tab will close with title: %@", [tab title]);
}

- (void)tabDidClosed:(ENTabCell *)tab{
    NSLog(@"Tab did closed with title: %@", [tab title]);
}

#pragma mark Theme actions
- (IBAction)setDefaultTheme:(id)sender{
    // Give all colors a default value if none given
    tabBarView.bgColor = [NSColor colorWithCalibratedRed: 0.6 green:0.6 blue:0.6 alpha:1.0];
    tabBarView.tabBGColor = [NSColor colorWithCalibratedRed: 0.68 green: 0.68 blue: 0.68 alpha:1.0];
    tabBarView.tabActivedBGColor = [NSColor whiteColor];
    tabBarView.tabBorderColor = [NSColor colorWithCalibratedRed: 0.53 green:0.53 blue:0.53 alpha:1.0];
    tabBarView.tabTitleColor = [NSColor blackColor];
    tabBarView.tabActivedTitleColor = [NSColor blackColor];
    tabBarView.smallControlColor = [NSColor colorWithCalibratedRed:0.53 green:0.53 blue:0.53 alpha:1.0];

    [tabBarView redraw];
    
    [textView setBackgroundColor:[NSColor whiteColor]];
    [textView setNeedsDisplay:YES];
}

- (IBAction)setZenTheme:(id)sender{
    // Give all colors a default value if none given
    tabBarView.bgColor = [NSColor colorWithCalibratedRed: 0.11 green:0.11 blue:0.11 alpha:1.0];
    tabBarView.tabBGColor = [NSColor colorWithCalibratedRed:0.22 green:0.22 blue:0.22 alpha:1.0];
    tabBarView.tabActivedBGColor = [NSColor colorWithCalibratedRed: 0.19 green: 0.19 blue: 0.19 alpha:1.0];
    tabBarView.tabBorderColor = [NSColor colorWithCalibratedRed:0.36 green:0.36 blue:0.36 alpha:1.0];
    tabBarView.tabTitleColor = [NSColor colorWithCalibratedRed:0.56 green:0.56 blue:0.47 alpha:1.0];
    tabBarView.tabActivedTitleColor = [NSColor whiteColor];
    tabBarView.smallControlColor = [NSColor colorWithCalibratedRed:0.53 green:0.53 blue:0.53 alpha:1.0];
    
    [tabBarView redraw];
    
    [textView setBackgroundColor:[tabBarView tabActivedBGColor]];
    [textView setNeedsDisplay:YES];
}
@end
