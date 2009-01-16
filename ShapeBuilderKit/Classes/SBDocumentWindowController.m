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

#pragma mark -
#pragma mark - as a NSOutlineViewDataSource
- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item; {
    NSArray* data = item==nil ? [[self document] rootObjects] : [item sbChildren];
    return [data objectAtIndex:index];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item; {
    return [self outlineView:outlineView numberOfChildrenOfItem:item] > 0;
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item; {
    NSArray* data = item==nil ? [[self document] rootObjects] : [item sbChildren];
    return [data count];
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item; {
    if([[tableColumn identifier] isEqual:@"ObjectID"])
        return @"-1";
    if([[tableColumn identifier] isEqual:@"Name"]) {
        return [item sbDefaultLabel];
        /*
        NSTextAttachment *attachment;
        attachment = [[[NSTextAttachment alloc] init] autorelease];
        NSCell *cell = [attachment attachmentCell];

        NSImage *icon = [item sbDefaultImage]; // or wherever you are getting your image
        NSSize size;
        size.width = 15;
        size.height = 15;
        [icon setSize:size];
        [cell setImage: icon];

        NSString *name = [item sbDefaultLabel];
        NSAttributedString *attrname;
        attrname = [[NSAttributedString alloc] initWithString: name];

        NSMutableAttributedString *prettyName;
        prettyName = (id)[NSMutableAttributedString attributedStringWithAttachment:
                                                attachment]; // cast to quiet compiler warning
        [prettyName appendAttributedString: attrname];
        [attrname release];
        return (prettyName);*/
    }
    if([[tableColumn identifier] isEqual:@"Type"])
        return [item sbTypeName];
    return @"BlaBla";
}

- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item; {
    if([[tableColumn identifier] isEqual:@"Name"]) {
        NSButtonCell* myCell = cell;
        [myCell setImage:[item sbDefaultImage]];
    }
}

@end
