//
//  SBXMLCoder.m
//  ModelKit
//
//  Created by Brian Olsen on 26/12/08.
//  Copyright 2008 Maven-Group. All rights reserved.
//

#import "SBXMLCoder.h"


@implementation SBXMLCoder

+ (NSData*)archivedDataWithRootObject:(id)rootObject {
    NSMutableData* data = [NSMutableData data];
    SBXMLCoder* coder = [[SBXMLCoder alloc] initForWritingWithMutableData:data];
    [coder encodeObject:rootObject];
    [coder finishEncoding];
    [coder release];
    return data;
}

+ (BOOL)archiveRootObject:(id)rootObject toFile:(NSString *)path {
    NSData* data = [SBXMLCoder archivedDataWithRootObject:rootObject];
    return [data writeToFile:path atomically:YES];
}

#pragma mark -
#pragma mark - constructors

- (id)initForWritingWithMutableData:(NSMutableData *)aData {
    if((self = [super init]))
    {
        data = [aData retain];
        
        rootXMLNode = [[NSXMLElement alloc] initWithName:@"archive"];
        [rootXMLNode addAttribute:
            [NSXMLNode attributeWithName:@"type" 
                             stringValue:@"org.maven-group.ShapeBuilder1.Default.XIB"]];

        NSString* version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        [rootXMLNode addAttribute:
            [NSXMLNode attributeWithName:@"version" stringValue:version]];

        currentXMLNode = rootXMLNode;
        idToObjects = [[NSMutableDictionary alloc] initWithCapacity:100];
        encodedObjects = [[NSMutableSet alloc] initWithCapacity:100];
        encodedPointers = [[NSMutableSet alloc] initWithCapacity:100];
    }
    return self;
}

- (void)dealloc {
    [data release];
    [rootXMLNode release];
    [idToObjects release];
    [encodedObjects release];
    [super dealloc];
}

- (void)finishEncoding; {
    NSXMLDocument* doc = [[NSXMLDocument alloc] initWithRootElement:rootXMLNode];
    [data appendData:[doc XMLData]];
}

#pragma mark -
#pragma mark - as a NSCoder

- (void)encodeObject:(id)aObject forKey:(NSString *)key {
    id realObject = aObject;
    if(aObject)
        aObject = [aObject replacementObjectForCoder: self];
    NSXMLElement* object;
    if(aObject)
    {
        object = [[NSXMLElement alloc] initWithName:@"object"];

        Class objCls = [aObject classForCoder];
        [object addAttribute:[NSXMLNode attributeWithName:@"class" stringValue:NSStringFromClass(objCls)]];
        
        NSString* idStr = [NSString stringWithFormat:@"%d", aObject];
        [object addAttribute:[NSXMLNode attributeWithName:@"id" stringValue:idStr]];
        
        [encodedObjects addObject:realObject];
        NSXMLElement* lastXMLNode = currentXMLNode;
        currentXMLNode = object;
        [aObject encodeWithCoder:self];
        currentXMLNode = lastXMLNode;
    }
    else
    {
        object = [[NSXMLElement alloc] initWithName:@"nil"];
    }
    if(key)
        [object addAttribute:[NSXMLNode attributeWithName:@"key" stringValue:key]];
    [currentXMLNode addChild:object];
}

@end
