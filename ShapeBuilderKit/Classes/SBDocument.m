//
//  SBDocument.m
//  ShapeBuilderKit
//
//  Created by Brian Olsen on 23/12/08.
//  Copyright 2008 Maven-Group. All rights reserved.
//

#import "SBDocument.h"
#import "SBDocumentWindowController.h"
#import "SBXMLDecoder.h"

@implementation SBDocument

- (NSMutableArray *)rootObjects; {
    return rootObjects;
}

- (void)makeWindowControllers {
    SBDocumentWindowController* controller = [[SBDocumentWindowController alloc] init];
    [self addWindowController:controller];
}


- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If the given outError != NULL, ensure that you set *outError when returning nil.

    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.

    // For applications targeted for Panther or earlier systems, you should use the deprecated API -dataRepresentationOfType:. In this case you can also choose to override -fileWrapperRepresentationOfType: or -writeToFile:ofType: instead.

    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    SBXMLDecoder* decoder = [[SBXMLDecoder alloc] initForReadingWithData:data error:outError];
    rootObjects = [[decoder decodeObjectForKey:@"SBDocument.RootObjects"] retain];
    [decoder finishDecoding];
    [decoder release];
    // Insert code here to read your document from the given data of the specified type.  If the given outError != NULL, ensure that you set *outError when returning NO.

    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead. 
    
    // For applications targeted for Panther or earlier systems, you should use the deprecated API -loadDataRepresentation:ofType. In this case you can also choose to override -readFromFile:ofType: or -loadFileWrapperRepresentation:ofType: instead.
    
    return YES;
}

@end
