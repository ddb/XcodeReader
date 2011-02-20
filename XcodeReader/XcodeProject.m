//
//  XcodeProject.m
//  XcodeProj
//
//  Created by David Brown on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XcodeProject.h"
#import <objc/runtime.h>

@implementation XcodeProject

@synthesize objects;
@synthesize rootObject;

- (void)loadProjectWithRootName:(NSString*)rootName {
    NSMutableDictionary* store = [NSMutableDictionary dictionary];
    for (NSString* objectName in [self.objects allKeys]) {
        [store setObject:[XCObject XCObjectFromDictionary:[self.objects objectForKey:objectName] 
                                                   forKey:objectName]
                  forKey:objectName];
    }
    for (NSString* objectName in [self.objects allKeys]) {
        [[store objectForKey:objectName] connectFromDictionary:[self.objects objectForKey:objectName] 
                                              usingObjectStore:store];
    }
    self.rootObject = [store objectForKey:rootName];
}

- (id)initWithProject:(NSDictionary*)project {
    self = [super init];
    if (self) {
        self.objects = [project objectForKey:@"objects"];
        [self loadProjectWithRootName:[project objectForKey:@"rootObject"]];
    }
    
    return self;
}

- (id)initFromURL:(NSURL*)projectURL {
    NSURL* projectFile = [projectURL URLByAppendingPathComponent:@"project.pbxproj"];
    
    NSPropertyListFormat theFormat = NSPropertyListOpenStepFormat;
    id contents = [NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:projectFile]
                                                   mutabilityOption:NSPropertyListImmutable
                                                             format:&theFormat
                                                   errorDescription:nil];
    return [self initWithProject:contents];
}

- (void)dealloc
{
    [super dealloc];
}

@end
