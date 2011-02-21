//
//  XCObject.m
//  XcodeProj
//
//  Created by David Brown on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XCObject.h"
#import "XcodeParserObjects.h"

@implementation XCObject

@synthesize xcodeObjectType;
@synthesize originalKey;

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)inflateFromDictionary:(NSDictionary*)dict {
}

- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
}

- (void)writeSlotsOnMutableString:(NSMutableString*)output {
}

- (NSString*)xcodeSavedFileObjectComment {
    return self.xcodeObjectType;
}

- (void)serializeString:(NSString*)s named:(NSString*)name onMutableString:(NSMutableString*)output {
    [output appendFormat:@"            %@ = \"%@\";\n", name, s];
}

- (void)serializeDictionary:(NSDictionary*)dict named:(NSString*)name onMutableString:(NSMutableString*)output {
    [output appendFormat:@"            %@ = (\n", name];
    
    for (id obj in [dict allKeys]) {
        [output appendFormat:@"                \"%@\" = \"%@\",\n", obj, [dict objectForKey:obj]];
    }
    
    [output appendFormat:@"            );\n"];
}

- (void)serializeArray:(NSArray*)a named:(NSString*)name onMutableString:(NSMutableString*)output {
    [output appendFormat:@"            %@ = (\n", name];
    
    for (id obj in a) {
        if ([obj isKindOfClass:[NSString class]]) {
            [output appendFormat:@"                \"%@\",\n", obj];
        } else {
            XCObject* xco = (XCObject*)obj;
            [output appendFormat:@"                %@ /* %@ */,\n", xco.originalKey, [xco xcodeSavedFileObjectComment]];
        }
    }
    
    [output appendFormat:@"            );\n"];
}

- (void)serializePointer:(XCObject*)xco named:(NSString*)name onMutableString:(NSMutableString*)output {
    [output appendFormat:@"            %@ = %@; /* %@ */\n", name, xco.originalKey, [xco xcodeSavedFileObjectComment]];
}

- (void)writeOnMutableString:(NSMutableString*)output {
    [output appendFormat:@"        %@ /* %@ */ = {\n", self.originalKey, [self xcodeSavedFileObjectComment]];
    [output appendFormat:@"            isa = %@;\n", self.xcodeObjectType];
    [self writeSlotsOnMutableString:output];
    [output appendString:@"        };\n"];
}

+ (XCObject*)XCObjectFromDictionary:(NSDictionary*)dict forKey:(NSString*)key {
    NSString* objIsa = [dict objectForKey:@"isa"];
    XCObject* xcobj = [[[NSClassFromString([NSString stringWithFormat:@"XP%@", objIsa]) alloc] init] autorelease];
    xcobj.xcodeObjectType = objIsa;
    xcobj.originalKey = key;
    [xcobj inflateFromDictionary:dict];
    return xcobj;
}
    
@end

@implementation XPPBXBuildFile (output)
- (void)writeOnMutableString:(NSMutableString*)output {
    [output appendFormat:@"        %@ /* %@%@ */ = {isa = %@; fileRef = %@ /* %@ */; };\n", self.originalKey, self.fileRef.path, self.fileRef.sourceTree, self.xcodeObjectType, self.fileRef.originalKey, self.fileRef.path];
}
- (NSString*)xcodeSavedFileObjectComment {
    return [self.fileRef xcodeSavedFileObjectComment];
}
@end

@implementation XPPBXFileReference (output)
- (void)writeOnMutableString:(NSMutableString*)output {
    [output appendFormat:@"        %@ /* %@ */ = {isa = %@; fileEncoding = %@; lastKnownFileType = %@; path = %@; sourceTree = \"%@\"; };\n", self.originalKey, self.path, self.xcodeObjectType, self.fileEncoding, self.lastKnownFileType, self.path, self.sourceTree];
}
- (NSString*)xcodeSavedFileObjectComment {
    if (self.path) {
        return self.path;
    } else {
        return self.name;
    }
}
@end

@implementation XPPBXGroup (output)
- (NSString*)xcodeSavedFileObjectComment {
    return self.name;
}
@end

@implementation XPPBXFrameworksBuildPhase (output)
- (NSString*)xcodeSavedFileObjectComment {
    return @"Frameworks";
}
@end