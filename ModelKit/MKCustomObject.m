//
//  MKCustomObject.m
//  ModelKit
//
//  Created by Brian Olsen on 24/12/08.
//  Copyright 2008 Maven-Group. All rights reserved.
//

#import "MKCustomObject.h"

@implementation MKCustomObject

- (void) dealloc;
{
#if 0
	NSLog(@"NSCustomObject dealloc (class=%@) object=%@", className, object);
#endif
	[className release];
    if(object)
        [object release];
	[super dealloc];
}

- (id) nibInstantiate;
{ // return real object or instantiate fresh one
	Class class;
#if 0
	NSLog(@"custom object nibInstantiate (class=%@)", className);
#endif
	if([className isEqualToString:@"NSApplication"])
		return [NSApplication sharedApplication];
	if(object)
		return object;
	class=NSClassFromString(className);
	if(!class)
		{
		NSLog(@"class %@ not linked for Custom Object", className);
		class=[NSObject class];
		}
	return object=[[class alloc] init];
}

#pragma mark -
#pragma mark - as a NSCoding

- (id) initWithCoder:(NSCoder *) coder; {

#if 0
    NSLog(@"MKCustomObject initWithCoder %@", coder);
#endif
    if(![coder allowsKeyedCoding])
        [NSException raise:NSInvalidArchiveOperationException
                    format:@"Only supports NSKeyedArchiver coders"];
        
    if((self = [super init]))
    {
        className=[[coder decodeObjectForKey:@"NSClassName"] retain];
        object=[[coder decodeObjectForKey:@"NSObject"] retain];	// if defined...
//        extension=[[coder decodeObjectForKey:@"NSExtension"] retain];
#if 0
        NSLog(@"className=%@", className);
        NSLog(@"object=%@", object);
//        NSLog(@"extension=%@", extension);
#endif
    }
	return self;
}

-(void)encodeWithCoder:(NSCoder*)coder {
#if 0
	NSLog(@"MKCustomObject incodeWithCoder %@", coder);
#endif
	if(![coder allowsKeyedCoding])
        [NSException raise:NSInvalidArchiveOperationException
                    format:@"Only supports NSKeyedArchiver coders"];
                    
    [coder encodeObject:className forKey:@"NSClassName"];
    if(object)
        [coder encodeObject:object forKey:@"NSObject"];	// if defined...
//	[coder encodeObject:extension forKey:@"NSExtension"];
#if 0
	NSLog(@"className=%@", className);
	NSLog(@"object=%@", object);
//	NSLog(@"extension=%@", extension);
#endif
}

@end
