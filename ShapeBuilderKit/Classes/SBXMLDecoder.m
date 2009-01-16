//
//  SBXMLDecoder.m
//  ModelKit
//
//  Created by Brian Olsen on 02/01/09.
//  Copyright 2009 Maven-Group. All rights reserved.
//

#import "SBXMLDecoder.h"

@implementation SBXMLDecoder

- (id)initForReadingWithData:(NSData*)myData;
{
    return [self initForReadingWithData:myData error:nil];
}

- (id)initForReadingWithData:(NSData*)myData error:(NSError **)myError;
{
    self = [super init];
    if( self )
    {
        data = [myData retain];
        document = [[NSXMLDocument alloc] initWithData:myData options:0 error:myError];
        if( !document )
        {
            [self release];
            return nil;
        }
        idToObjects = [[NSMutableDictionary alloc] initWithCapacity:100];
        childMap = [[NSMapTable mapTableWithStrongToWeakObjects] retain]; 
//        CFDictionaryRef
//        NSMapTable
        currentXMLNode = [document rootElement];
//        if([currentXMLNode name])
        currentXMLNode = (NSXMLElement*)[currentXMLNode childAtIndex:0];
        
        NSArray* objects = [currentXMLNode nodesForXPath:@"//object[@id!='']" error:myError];
        idToNodes = [[NSMutableDictionary alloc] initWithCapacity:[objects count]];
        for( NSXMLElement* node in objects )
        {
            NSXMLNode* idNode = [node attributeForName:@"id"];
            if(idNode)
            {
                NSString* idValue = [idNode stringValue];
                [idToNodes setObject:node forKey:idValue];
            }
        }
    }
    return self;
}

- (void)dealloc {
    [idToNodes release];
    [childMap release];
    [idToObjects release];
    [document release];
    [data release];
}

- (id)delegate;
{
    return _delegate;
}

- (void)setDelegate:(id)myDelegate;
{
    _delegate = myDelegate;
}

- (BOOL)allowsKeyedCoding { return YES; }

- (void)finishDecoding; {}

- (Class)classForClassName:(NSString *)codedName;
{
    return nil;
}

- (NSXMLElement *)elementForKey:(NSString*)myKey;
{
    int i, count = [currentXMLNode childCount];
    for (i=0; i < count; i++) {
        NSXMLElement* child = (NSXMLElement*)[currentXMLNode childAtIndex:i];
        NSXMLNode* keyNode = [child attributeForName:@"key"];
        if(keyNode)
        {
            NSString* key = [keyNode stringValue];
            if([myKey isEqual:key])
                return child;
        }
    }
    return nil;
}

- (BOOL)containsValueForKey:(NSString*)key
{
    return [self elementForKey:key] != nil;
}

- (NSArray*)deserializeArray:(NSMutableArray*)arr fromXMLElement:(NSXMLElement*)elem;
{
    BOOL autorel = NO;
    if( !arr )
    {
        arr = [NSMutableArray alloc];
        autorel = YES;
    }
    int i, count = [elem childCount];
    arr = [arr initWithCapacity:count];
    for (i=0; i < count; i++) {
        NSXMLElement* child = (NSXMLElement*)[elem childAtIndex:i];
        NSXMLNode* keyNode = [child attributeForName:@"key"];
        if(!keyNode)
        {
            id obj = [self decodeForXMLElement:child];
            if(!obj)
                NSLog(@"Bad child");
            [arr addObject:obj];
        }
    }
    return autorel ? [arr autorelease] : arr;
}

- (id)decodeForXMLElement:(NSXMLElement*)elem;
{
    if(elem == nil) return nil;
    
    NSString* name = [elem name];
    if([name isEqual:@"reference"])
    {
        NSString* ref = [[elem attributeForName:@"ref"] stringValue];
        id obj = [idToObjects objectForKey:ref];
        if(!obj)
        {
            obj = [childMap objectForKey:ref];
            if(!obj)
            {
                NSXMLElement* node = [idToNodes objectForKey:ref];
                if(!node)
                    [NSException raise:NSInvalidUnarchiveOperationException format:@"Can't find object for reference %@", ref];
                obj = [self decodeForXMLElement:node];
            }
        }
        return obj;
    } else if([name isEqual:@"nil"])
    {
        return nil;
    } else if([name isEqual:@"object"])
    {
        NSXMLNode* classNameNode = [elem attributeForName:@"class"];
        if(!classNameNode) return nil;
        NSString* className = [classNameNode stringValue];
        
        Class class;
		class=[self classForClassName:className];	// apply local translation table
        if(!class)
            class = NSClassFromString(className);
        if(!class && [_delegate respondsToSelector:@selector(xmlcoder:cannotDecodeObjectOfClassName:)])
            class=[_delegate xmlcoder:self cannotDecodeObjectOfClassName:className];
        if(!class)
            [NSException raise:NSInvalidUnarchiveOperationException format:@"Can't unarchive object for class %@", className];
        
        id instance = [class allocWithZone:[self zone]];					// allocate a fresh object
        id newObj = instance;
        
        NSString* idValue = nil;
        NSXMLNode* refNode = [elem attributeForName:@"id"];
        if(refNode)
        {
            idValue = [refNode stringValue];
            [childMap setObject:newObj forKey:idValue];
        }

        if([instance isKindOfClass:[NSMutableArray class]])
            newObj = [self deserializeArray:instance fromXMLElement:elem];
        else if([instance isKindOfClass:[NSArray class]])
            newObj = [instance initWithArray:[self deserializeArray:nil fromXMLElement:elem]];
        else if([class instancesRespondToSelector:@selector(initWithCoder:)])
        {
            NSXMLElement* oldCurrent = currentXMLNode;
            currentXMLNode = elem;
//            NSLog(@"Calling initWithCoder: %@", instance);
            newObj = [[instance initWithCoder:self] autorelease];
//            NSLog(@"Returned from initWithCoder: %@", newObj);
            currentXMLNode = oldCurrent;
        } else
            newObj = [[instance init] autorelease];
        if(idValue)
            [childMap removeObjectForKey:idValue];
        if(!newObj)
            return nil;

//        NSLog(@"New obj retained %d", [newObj retainCount]);
//        NSLog(@"Instance ratained %d", [instance retainCount]);
        if([class instancesRespondToSelector:@selector(awakeAfterUsingCoder:)])
            newObj = [newObj awakeAfterUsingCoder:self];
        if(idValue)
			[idToObjects setObject:newObj forKey:idValue];	// store for later use
        /*
		if(newObj != instance)
        {
            [instance release];
            [newObj retain];
        }
        */
		if([_delegate respondsToSelector:@selector(xmldecoder:didDecodeObject:)])
			newObj=[_delegate xmldecoder:self didDecodeObject:newObj];
		if(newObj != instance && [_delegate respondsToSelector:@selector(xmldecoder:willReplaceObject:withObject:)])
			[_delegate xmldecoder:self willReplaceObject:instance withObject:newObj];	// has been changed between original call to initWithCoder
        
        return newObj;
    } else if( [name isEqual:@"string"])
    {
        return [elem stringValue];
    } else if( [name isEqual:@"integer"])
    {
        NSXMLNode* valueNode = [elem attributeForName:@"value"];
        NSInteger r = 0;
        if(valueNode)
            r = [[valueNode stringValue] integerValue];
        return [NSNumber numberWithInteger:r];
    }
    return nil;
}

- (id)decodeObjectForKey:(NSString *)myKey;
{
    NSXMLElement* elem = [self elementForKey:myKey];
    return [self decodeForXMLElement:elem];
}

- (void)decodeValueOfObjCType:(const char *)valueType at:(void *)data
{
    [super decodeValueOfObjCType:valueType at:data];
}

- (BOOL)decodeBoolForKey:(NSString *)myKey;
{
    NSXMLElement* elem = [self elementForKey:myKey];
    if(elem && [[elem name] isEqual:@"bool"])
        return [[elem stringValue] boolValue];
    return NO;
}

- (int)decodeIntForKey:(NSString *)myKey
{
    NSXMLElement* elem = [self elementForKey:myKey];
    if(elem && [[elem name] isEqual:@"int"])
        return [[elem stringValue] intValue];
    return 0;
}

- (int32_t)decodeInt32ForKey:(NSString *)myKey;
{
    NSXMLElement* elem = [self elementForKey:myKey];
    if(elem && [[elem name] isEqual:@"int"])
        return [[elem stringValue] intValue];
    return 0;
}

- (int64_t)decodeInt64ForKey:(NSString *)myKey;
{
    NSXMLElement* elem = [self elementForKey:myKey];
    if(elem && [[elem name] isEqual:@"longLong"])
        return [[elem stringValue] longLongValue];
    return 0;
}

- (float)decodeFloatForKey:(NSString *)myKey;
{
    NSXMLElement* elem = [self elementForKey:myKey];
    if(elem && [[elem name] isEqual:@"float"])
        return [[elem stringValue] floatValue];
    return 0.0f;
}

- (double)decodeDoubleForKey:(NSString *)myKey;
{
    NSXMLElement* elem = [self elementForKey:myKey];
    if(elem && [[elem name] isEqual:@"double"])
        return [[elem stringValue] doubleValue];
    return 0.0;
}

- (const uint8_t *)decodeBytesForKey:(NSString *)key returnedLength:(NSUInteger *)lengthp;
{
    NSXMLElement* elem = [self elementForKey:key];
    NSData* retData = [NSData dataWithBase64EncodedString:[elem stringValue]];
    if(!retData)
        return NULL;
    *lengthp = [retData length];
    return [retData bytes];
}

@end
