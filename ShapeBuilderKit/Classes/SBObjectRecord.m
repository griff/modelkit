//
//  SBObjectRecords.m
//  ModelKit
//
//  Created by Brian Olsen on 26/12/08.
//  Copyright 2008 Maven-Group. All rights reserved.
//

#import "SBObjectRecord.h"

@implementation SBObjectRecord
@synthesize objectID;
@synthesize objectName;
@synthesize parent;
@synthesize object;
@synthesize children;

- (id)initWithObject:(id)aObject;
{
    if((self = [super init]))
        object = [aObject retain];
    return self;
}

- (void)dealloc {
    [object release];
    if(objectName)
        [objectName release];
    if(parent)
        [parent release];
    [super dealloc];
}

- (void)moveChild:(id)aChild toIndex:(NSUInteger)aIndex;
{
    [children removeObject:aChild];
    [children insertObject:aChild atIndex:aIndex];
}

- (void)insertChild:(id)aChild atIndex:(NSUInteger)aIndex;
{
    [children insertObject:aChild atIndex:aIndex];
}

- (void)addChild:(id)aChild;
{
    [children addObject:aChild];
}

- (void)removeChild:(id)aChild
{
    [children removeObject:aChild];
}

#pragma mark -
#pragma mark - as a NSCoding

- (id)initWithCoder:(NSCoder*)coder;
{
#if 0
	NSLog(@"SBObjectRecord initWithCoder:%@", coder);
#endif
	if(![coder allowsKeyedCoding])
        [NSException raise:NSInvalidArchiveOperationException
                    format:@"Only supports NSKeyedArchiver coders"];
    objectID = [coder decodeIntegerForKey:@"objectID"];
    object = [[coder decodeObjectForKey:@"object"] retain];
    children = [[coder decodeObjectForKey:@"children"] retain];
    parent = [[coder decodeObjectForKey:@"parent"] retain];
    return self;
}

- (void)encodeWithCoder:(NSCoder*)coder;
{
    #if 0
	NSLog(@"SBObjectRecord encodeWithCoder:%@", coder);
#endif
	if(![coder allowsKeyedCoding])
        [NSException raise:NSInvalidArchiveOperationException
                    format:@"Only supports NSKeyedArchiver coders"];
        
    [coder encodeInteger:objectID forKey:@"objectID"];
    [coder encodeObject:object forKey:@"object"];
    if(children)
        [coder encodeObject:children forKey:@"children"];
    [coder encodeObject:parent forKey:@"parent"];
}

@end
