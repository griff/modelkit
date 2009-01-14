//
//  MKCustomObject-MKSBCustomObject.m
//  ModelKit
//
//  Created by Brian Olsen on 26/12/08.
//  Copyright 2008 Maven-Group. All rights reserved.
//

#import "MKCustomObject-MKSBCustomObject.h"


@implementation MKCustomObject (MKSBCustomObject)
- (NSString *)className {return className; }
- (void)setClassName:(NSString *)aClassName;
{
    if(className)
        [className release];
    className = [aClassName retain];
}

- (NSString *)description;
{
    @"Description";
}

- (BOOL)sbIsCustomObject;
{
    YES;
}
@end
