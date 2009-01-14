//
//  MKCustomObject.h
//  ModelKit
//
//  Created by Brian Olsen on 24/12/08.
//  Copyright 2008 Maven-Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MKCustomObject : NSObject <NSCoding> {
    NSString* className;
    id object;
}

- (id) nibInstantiate;

@end
