//
//  SBXMLDecoder.h
//  ModelKit
//
//  Created by Brian Olsen on 02/01/09.
//  Copyright 2009 Maven-Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SBXMLDecoder : NSCoder {
    NSMutableDictionary* idToObjects;
    NSMutableDictionary* idToNodes;
    NSMapTable* childMap;
    NSXMLElement* currentXMLNode;
    NSXMLDocument* document;
    NSData *data;
    id _delegate;
}

- (id)initForReadingWithData:(NSData*)myData;
- (id)initForReadingWithData:(NSData*)myData error:(NSError **)myError;

- (id)delegate;
- (void)setDelegate:(id)myDelegate;

- (void)finishDecoding;

- (NSXMLElement *)elementForKey:(NSString*)myKey;
- (id)decodeForXMLElement:(NSXMLElement*)elem;

- (id)decodeObjectForKey:(NSString *)myKey;
- (BOOL)decodeBoolForKey:(NSString *)myKey;
- (int)decodeIntForKey:(NSString *)myKey;
- (int32_t)decodeInt32ForKey:(NSString *)myKey;
- (int64_t)decodeInt64ForKey:(NSString *)myKey;
- (float)decodeFloatForKey:(NSString *)myKey;
- (double)decodeDoubleForKey:(NSString *)myKey;
- (const uint8_t *)decodeBytesForKey:(NSString *)key returnedLength:(NSUInteger *)lengthp;

- (Class)classForClassName:(NSString *)codedName;

@end
