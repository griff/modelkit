//
//  SBApplication.h
//  ShapeBuilder
//
//  Created by Brian Olsen on 23/12/08.
//  Copyright 2008 Maven-Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <ShapeBuilderKit/SBDocument.h>

@interface SBApplication : NSApplication {

}
-(void)showInspector:(id)sender;
-(void)showLibrary:(id)sender;

@end
