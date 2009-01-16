//
//  MKCustomObject-MKSBCustomObject.h
//  ModelKit
//
//  Created by Brian Olsen on 26/12/08.
//  Copyright 2008 Maven-Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <ModelKit/MKCustomObject.h>

@interface MKCustomObject (MKSBCustomObject)
//@property(retain, readwrite) NSString* className;

- (NSString *)description;
- (BOOL)sbIsCustomObject;

@end
