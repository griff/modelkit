//
//  SBDocument.h
//  ShapeBuilderKit
//
//  Created by Brian Olsen on 23/12/08.
//  Copyright 2008 Maven-Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SBDocument : NSDocument {
    NSMutableArray* rootObjects;
}
- (NSMutableArray *)rootObjects;

@end
