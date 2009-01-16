//
//  SBObjectIntegration.h
//  ModelKit
//
//  Created by Brian Olsen on 26/12/08.
//  Copyright 2008 Maven-Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SBDocument;

@interface NSObject (SBObjectIntegration)

/* Default label and image for the object. */
- (NSString *)sbDefaultLabel;
- (NSImage *)sbDefaultImage;
- (NSString *)sbTypeName;
- (NSArray *)sbChildren;

/* Customization points for integrated objects and views */
- (void)sbAwakeInDesignableDocument:(SBDocument *)document;
- (void)sbDidAddToDesignableDocument:(SBDocument *)document;
- (void)sbDidRemoveFromDesignableDocument:(SBDocument *)document;
@end
