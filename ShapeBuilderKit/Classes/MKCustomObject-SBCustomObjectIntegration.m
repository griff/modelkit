//
//  MKCustomObject-SBCustomObjectIntegration.m
//  ModelKit
//
//  Created by Brian Olsen on 26/12/08.
//  Copyright 2008 Maven-Group. All rights reserved.
//

#import "MKCustomObject-SBCustomObjectIntegration.h"


@implementation MKCustomObject (SBCustomObjectIntegration)

- (NSString *)sbTypeName; {
    return className;
}

@end
