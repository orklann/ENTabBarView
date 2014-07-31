//
//  ENTabImage.m
//  TabBarDemo
//
//  Created by Aaron Elkins on 7/29/14.
//  Copyright (c) 2014 PixelEgg. All rights reserved.
//

#import "ENTabImage.h"

@implementation ENTabImage
@synthesize tab;
+ (id)imageWithENTabCell:(ENTabCell*)tabCell{
    NSRect rect = NSMakeRect(0, 0, tabCell.frame.size.width, tabCell.frame.size.height);
    ENTabImage *image = [[ENTabImage alloc] initWithSize:rect.size];
    [image setTab:tabCell];
    
    // Reset tab cell's frame
    [[image tab] setFrame:rect];
    
    [image lockFocus];
    
    // Transparent
    [[NSColor clearColor] set];
    NSRectFill(rect);
    
    // ---------------------------- Copy from ENTabCell ----------------------------
    [[image tab] draw];
    // ---------------------------- End of copying from ENTabCell ----------------------------
    
    [image unlockFocus];
    return image;
}
@end
