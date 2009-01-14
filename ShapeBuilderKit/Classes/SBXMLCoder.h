//
//  SBXMLCoder.h
//  ModelKit
//
//  Created by Brian Olsen on 26/12/08.
//  Copyright 2008 Maven-Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SBXMLCoder : NSCoder {
    NSMutableSet* encodedObjects;
    NSMutableSet* encodedPointers;
    NSMutableDictionary* idToObjects;
    NSMutableData* data;
    NSXMLElement* rootXMLNode;
    NSXMLElement* currentXMLNode;
}

+ (NSData *)archivedDataWithRootObject:(id)rootObject;
+ (BOOL)archiveRootObject:(id)rootObject toFile:(NSString *)path;

- (id)initForWritingWithMutableData:(NSMutableData *)aData;
- (void)finishEncoding;

@end
