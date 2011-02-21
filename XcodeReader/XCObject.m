//
//  XCObject.m
//  XcodeProj
//
//  Created by David Brown on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XCObject.h"
#import "XcodeParserObjects.h"

@implementation NSString (quoting)
- (NSString*)quotedIfNecessary {
    NSCharacterSet* set = [NSCharacterSet characterSetWithCharactersInString:@"()$%<>- "];
    NSRange range = [self rangeOfCharacterFromSet:set];
    if (range.location != NSNotFound) {
        return [NSString stringWithFormat:@"\"%@\"", self];
    }
    return self;
}
@end

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

- (NSComparisonResult)compareOriginalKeys:(id)obj {
    XCObject* xco = (XCObject*)obj;
    return [self.originalKey compare:xco.originalKey];
}

- (NSString*)xcodeSavedFileObjectComment {
    return [NSString stringWithFormat:@" /* %@ */", self.xcodeObjectType];
}

- (void)serializeString:(NSString*)s named:(NSString*)name onMutableString:(NSMutableString*)output {
    if (s) {
        [output appendFormat:@"            %@ = %@;\n", name, [s quotedIfNecessary]];
    }
}

- (void)serializeDictionary:(NSDictionary*)dict named:(NSString*)name onMutableString:(NSMutableString*)output {
    if (dict) {
        [output appendFormat:@"            %@ = (\n", name];
        
        for (id obj in [[dict allKeys] sortedArrayUsingSelector:@selector(compare:)]) {
            [output appendFormat:@"                %@ = %@,\n", [obj quotedIfNecessary], [[dict objectForKey:obj] quotedIfNecessary]];
        }
        
        [output appendFormat:@"            );\n"];
    }
}

- (void)serializeArray:(NSArray*)a named:(NSString*)name onMutableString:(NSMutableString*)output {
    if (a) {
        [output appendFormat:@"            %@ = (\n", name];
        
        for (id obj in a) {
            if ([obj isKindOfClass:[NSString class]]) {
                [output appendFormat:@"                %@,\n", [obj quotedIfNecessary]];
            } else {
                XCObject* xco = (XCObject*)obj;
                [output appendFormat:@"                %@%@,\n", xco.originalKey, [xco xcodeSavedFileObjectComment]];
            }
        }
        
        [output appendFormat:@"            );\n"];
    }
}

- (void)serializePointer:(XCObject*)xco named:(NSString*)name onMutableString:(NSMutableString*)output {
    if (xco) {
        [output appendFormat:@"            %@ = %@%@;\n", name, xco.originalKey, [xco xcodeSavedFileObjectComment]];
    }
}

- (void)writeOnMutableString:(NSMutableString*)output {
    [output appendFormat:@"        %@%@ = {\n", self.originalKey, [self xcodeSavedFileObjectComment]];
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
    [output appendFormat:@"        %@ /* %@%@ */ = {isa = %@; fileRef = %@%@; };\n", self.originalKey, self.fileRef.path, self.fileRef.sourceTree, self.xcodeObjectType, self.fileRef.originalKey, [self.fileRef xcodeSavedFileObjectComment]];
}
- (NSString*)xcodeSavedFileObjectComment {
    return [self.fileRef xcodeSavedFileObjectComment];
}
@end

@implementation XPPBXFileReference (output)
- (void)writeOnMutableString:(NSMutableString*)output {
    [output appendFormat:@"        %@%@ = {isa = %@; ", self.originalKey, [self xcodeSavedFileObjectComment], self.xcodeObjectType];
    if (self.fileEncoding) [output appendFormat:@"fileEncoding = %@; ", self.fileEncoding];
    if (self.lastKnownFileType) [output appendFormat:@"lastKnownFileType = %@; ", self.lastKnownFileType];
    if (self.path) [output appendFormat:@"path = %@; ", self.path];
    if (self.sourceTree) [output appendFormat:@"sourceTree = %@; ", [self.sourceTree quotedIfNecessary]];
    [output appendString:@" };\n"];
}
- (NSString*)xcodeSavedFileObjectComment {
    NSString* result;
    if (self.path) {
        result = self.path;
    } else {
        result = self.name;
    }
    if (!result) {
        return @"";
    }
    if ([[result pathExtension] isEqualToString:@"framework"]) {
        return [NSString stringWithFormat:@" /* %@ */", [result lastPathComponent]];
    }
    return [NSString stringWithFormat:@" /* %@ */", result];
}
@end

@implementation XPPBXGroup (output)
- (NSString*)xcodeSavedFileObjectComment {
    if (self.name) {
        return [NSString stringWithFormat:@" /* %@ */", self.name];
    }
    return @"";
}
@end

@implementation XPPBXFrameworksBuildPhase (output)
- (NSString*)xcodeSavedFileObjectComment {
    return @" /* Frameworks */";
}
@end

@implementation XPPBXVariantGroup (output)
- (NSString*)xcodeSavedFileObjectComment {
    return [NSString stringWithFormat:@" /* %@ */", self.name];
}
@end