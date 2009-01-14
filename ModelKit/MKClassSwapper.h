//
//  MKClassSwapper.h
//  ModelKit
//
//  Created by Brian Olsen on 24/12/08.
//  Copyright 2008 Maven-Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MKClassSwapper : NSObject <NSCoding> {
    NSString* className;
    id template;
}
@property(retain, readwrite) NSString* className;
@property(retain, readwrite) id template;

//+(void)initialize;
-(id)init;
-(void)dealloc;

@end
