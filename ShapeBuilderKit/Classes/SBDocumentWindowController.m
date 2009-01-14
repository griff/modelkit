//
//  SBDocumentWindowController.m
//  ShapeBuilderKit
//
//  Created by Brian Olsen on 23/12/08.
//  Copyright 2008 Maven-Group. All rights reserved.
//

#import "SBDocumentWindowController.h"


@implementation SBDocumentWindowController
- (IBAction)filter:(id)sender {
}

- (IBAction)showMsbInfo:(id)sender {
}

- (IBAction)selectedTabFromSegmentedControl:(id)sender {
    NSInteger selected = [tabSwitchControl selectedSegment];
    [tabView selectTabViewItemAtIndex:selected];
}

-(id)init {
    return [super initWithWindowNibName:@"SBDocumentWindow"];
}

@end
