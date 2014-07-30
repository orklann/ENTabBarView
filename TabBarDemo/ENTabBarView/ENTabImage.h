//
//  ENTabImage.h
//  TabBarDemo
//
//  Created by Aaron Elkins on 7/29/14.
//  Copyright (c) 2014 PixelEgg. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ENTabCell.h"

@interface ENTabImage : NSImage{
    ENTabCell *tab;
}

@property (readwrite) ENTabCell *tab;
+ (id)imageWithENTabCell:(ENTabCell*)tabCell;
@end
