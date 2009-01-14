//
//  SBObjectRecords.h
//  ModelKit
//
//  Created by Brian Olsen on 26/12/08.
//  Copyright 2008 Maven-Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SBObjectRecord : NSObject <NSCoding> {
    NSInteger objectID;
    NSString* objectName;
    id parent;
    id object;
    NSMutableArray* children;
}
@property(readwrite) NSInteger objectID;
@property(retain, readwrite) NSString* objectName;
@property(retain, readwrite) id parent;
@property(readonly) id object;
@property(readonly) NSArray* children;

- (id)initWithObject:(id)aObject;

- (void)moveChild:(id)aChild toIndex:(NSUInteger)aIndex;
- (void)insertChild:(id)aChild atIndex:(NSUInteger)aIndex;
- (void)addChild:(id)aChild;
- (void)removeChild:(id)aChild;

@end
