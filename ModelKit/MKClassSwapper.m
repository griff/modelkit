//
//  MKClassSwapper.m
//  ModelKit
//
//  Created by Brian Olsen on 24/12/08.
//  Copyright 2008 Maven-Group. All rights reserved.
//

#import "MKClassSwapper.h"

@implementation MKClassSwapper
@synthesize template;
@synthesize className;

-(id)init {
    return [super init];
}

- (void) dealloc
{
#if 0
	NSLog(@"NSClassSwapper %@ dealloc", className);
#endif
    if(className)
        [className release];
    if(template)
        [template release];
	[super dealloc];
}


#pragma mark -
#pragma mark - as a NSCoding

-(id)initWithCoder:(NSCoder*)coder {

#if 0
    NSLog(@"MKClassSwapper initWithCoder:%@", coder);
#endif
    if(![coder allowsKeyedCoding])
        [NSException raise:NSInvalidArchiveOperationException
                    format:@"Only supports NSKeyedArchiver coders"];

    if(!(self = [super init]))
        return nil;

    Class class;
    className=[[coder decodeObjectForKey:@"NSClassName"] retain];
    NSString* originalClassName=[coder decodeObjectForKey:@"NSOriginalClassName"];
#if 0
    NSLog(@"className=%@", className);
    NSLog(@"originalClassName=%@", originalClassName);
#endif
    class=NSClassFromString(className);
    if(!class)
    {
        NSLog(@"class %@ not linked for Class Swapper Object; substituting %@", className, originalClassName);
        class=NSClassFromString(originalClassName);
    }

    if(!class)
        return nil;	// FIXME: exception
    template=[class alloc];	// allocate
    if([class instancesRespondToSelector:_cmd])
    { // has an implementation of initWithCoder:
#if 0
        NSLog(@"template (%@) responds to -%@", NSStringFromClass(class), NSStringFromSelector(_cmd));
#endif
        template=[template initWithCoder:coder];	// and decode
    }
    else
    {
#if 0
        NSLog(@"template (%@) does not respond to -%@", NSStringFromClass(class), NSStringFromSelector(_cmd));
#endif
        template=[template init];
    }
    [self autorelease];
    return [template retain];
}

-(void)encodeWithCoder:(NSCoder*)coder {
    #if 0
	NSLog(@"NSClassSwapper encodeWithCoder:%@", coder);
#endif
	if(![coder allowsKeyedCoding])
        [NSException raise:NSInvalidArchiveOperationException
                    format:@"Only supports NSKeyedArchiver coders"];

    NSString* originalClassName = NSStringFromClass([template class]);
#if 0
	NSLog(@"className=%@", className);
	NSLog(@"originalClassName=%@", originalClassName);
#endif
    [coder encodeObject:className forKey:@"NSClassName"];
    [coder encodeObject:originalClassName forKey:@"NSOriginalClassName"];
    if([template respondsToSelector:_cmd])
    {
#if 0
		NSLog(@"template (%@) responds to -%@", originalClassName, NSStringFromSelector(_cmd));
#endif
		[template encodeWithCoder:coder];	// and encode
    }
	else
    {
#if 0
		NSLog(@"template (%@) does not respond to -%@", originalClassName, NSStringFromSelector(_cmd));
#endif
    }
}

@end
