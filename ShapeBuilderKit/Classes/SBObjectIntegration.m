//
//  SBObjectIntegration.m
//  ModelKit
//
//  Created by Brian Olsen on 26/12/08.
//  Copyright 2008 Maven-Group. All rights reserved.
//

#import "SBObjectIntegration.h"


@implementation NSObject (SBObjectIntegration)
- (void)sbAwakeInDesignableDocument:(SBDocument *)document; {}
- (void)sbDidAddToDesignableDocument:(SBDocument *)document; {}
- (void)sbDidRemoveFromDesignableDocument:(SBDocument *)document; {}

@end
