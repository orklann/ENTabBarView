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
    
    /* Create two tab with titles */
    ENTabCell *t1 = [tabBarView addTabViewWithTitle:@"Elk Developer's Note++++ 2014-02-19.rtf"];
    [t1 setAsActiveTab];
    
    [tabBarView addTabViewWithTitle:@"index.html.rjs.erb.css.ruby"];
    
    /* Must call this to update tab bar view */
    [tabBarView redraw];
}

@end
