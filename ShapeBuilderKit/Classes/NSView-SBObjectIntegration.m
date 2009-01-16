//
//  NSView-SBObjectIntegration.m
//  ModelKit
//
//  Created by Brian Olsen on 16/01/09.
//  Copyright 2009 Maven Group. All rights reserved.
//

#import "NSView-SBObjectIntegration.h"


@implementation NSView (SBObjectIntegration)
- (NSArray *)sbChildren; {
    return [self subviews];
}

@end
