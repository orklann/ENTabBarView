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
    
    [tabBarView setDelegate:self];
    
    /* Create two tab with titles */
    ENTabCell *t1 = [tabBarView addTabViewWithTitle:@"Elk Developer's Note++++ 2014-02-19.rtf"];
    [t1 setAsActiveTab];
    
    [tabBarView addTabViewWithTitle:@"index.html.rjs.erb.css.ruby"];
    
    /* Must call this to update tab bar view */
    [tabBarView redraw];
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
@end
