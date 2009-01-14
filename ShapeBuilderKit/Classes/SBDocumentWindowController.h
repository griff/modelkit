//
//  SBDocumentWindowController.h
//  ShapeBuilderKit
//
//  Created by Brian Olsen on 23/12/08.
//  Copyright 2008 Maven-Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SBDocumentWindowController : NSWindowController {
    IBOutlet NSSegmentedControl *tabSwitchControl;
    IBOutlet NSSearchField *searchField;
    IBOutlet NSTabView *tabView;
    IBOutlet NSScrollView *rootObjectsScrollView;
    IBOutlet NSScrollView *objectOutlineScrollView;
    IBOutlet NSOutlineView *objectOutlineView;
    IBOutlet NSOutlineView *classOutlineView;
    IBOutlet NSBrowser *objectBrowserView;
}
- (IBAction)filter:(id)sender;
- (IBAction)showMsbInfo:(id)sender;
- (IBAction)selectedTabFromSegmentedControl:(id)sender;


@end
