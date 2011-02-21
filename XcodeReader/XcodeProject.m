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
@synthesize typeGroups;
@synthesize archiveVersion;
@synthesize objectVersion;
@synthesize classes;

/*
 
 // !$*UTF8*$!
 {
 archiveVersion = 1;
 classes = {
 };
 objectVersion = 46;
 
 */

- (void)loadProjectWithRootName:(NSString*)rootName {
    NSMutableDictionary* store = [NSMutableDictionary dictionary];
    self.typeGroups = [NSMutableDictionary dictionary];
    for (NSString* objectName in [self.objects allKeys]) {
        XCObject* obj = [XCObject XCObjectFromDictionary:[self.objects objectForKey:objectName] 
                                                  forKey:objectName];
        [store setObject:obj forKey:objectName];
        NSMutableArray* objTypeArray = [self.typeGroups objectForKey:obj.xcodeObjectType];
        if (!objTypeArray) {
            objTypeArray = [NSMutableArray array];
            [self.typeGroups setValue:objTypeArray forKey:obj.xcodeObjectType];
        }
        [objTypeArray addObject:obj];
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
        self.archiveVersion = [project objectForKey:@"archiveVersion"];
        self.objectVersion = [project objectForKey:@"objectVersion"];
        self.classes = [project objectForKey:@"classes"];
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

- (NSString*)asString {
    NSMutableString* output = [NSMutableString string];
    [output appendString:@"// !$*UTF8*$!\n{\n"];
    [output appendFormat:@"    archiveVersion = %@;\n", self.archiveVersion];
    [output appendFormat:@"    classes = {\n"];
    [output appendFormat:@"    };\n"];
    [output appendFormat:@"    objectVersion = %@;\n", self.objectVersion];
    [output appendString:@"    objects = {\n"];
    
    NSArray* types = [[self.typeGroups allKeys] sortedArrayUsingSelector:@selector(compare:)];
    for (NSString* typeName in types) {
        [output appendFormat:@"\n/* Begin %@ section */\n", typeName];
        for (XCObject* xco in [[self.typeGroups objectForKey:typeName] sortedArrayUsingSelector:@selector(compareOriginalKeys:)]) {
            [xco writeOnMutableString:output];
        }
        [output appendFormat:@"/* End %@ section */\n", typeName];
    }
    
    [output appendString:@"    };\n"];
    [output appendFormat:@"    rootObject = %@ /* Project object */;\n", self.rootObject.originalKey];
    [output appendString:@"}\n"];
    return output;
}

- (void)dealloc
{
    [super dealloc];
}

@end
