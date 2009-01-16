//
//  SBObjectIntegration.m
//  ModelKit
//
//  Created by Brian Olsen on 26/12/08.
//  Copyright 2008 Maven-Group. All rights reserved.
//

#import "SBObjectIntegration.h"


@implementation NSObject (SBObjectIntegration)
- (NSString *)sbDefaultLabel; {
    NSCharacterSet* set = [NSCharacterSet uppercaseLetterCharacterSet];
    NSMutableString* ret = [[self sbTypeName] mutableCopy];
    int i=0;
    BOOL firstUpper=YES;
    while(i<[ret length])
    {
        if([set characterIsMember:[ret characterAtIndex:i]])
        {
            if(!firstUpper)
            {
                [ret insertString:@" " atIndex:i];
                i++;
            }
        } else if(firstUpper) {
            firstUpper=NO;
            if(i>2)
            {
                NSRange range;
                range.location = 0;
                range.length = i-1;
                [ret deleteCharactersInRange:range];
                i = 1;
            }    
        }
        i++;
    }
    NSString* data = [NSString stringWithString:ret];
    [ret release];
    return data;
}

- (NSImage *)sbDefaultImage; {
    NSImage* img = [NSImage imageNamed:@"GObject"];
    return img;
}
- (NSArray *)sbChildren; {
    return [NSArray array];
}

- (NSString *)sbTypeName; {
    return NSStringFromClass([self class]);
}

- (void)sbAwakeInDesignableDocument:(SBDocument *)document; {}
- (void)sbDidAddToDesignableDocument:(SBDocument *)document; {}
- (void)sbDidRemoveFromDesignableDocument:(SBDocument *)document; {}

@end
