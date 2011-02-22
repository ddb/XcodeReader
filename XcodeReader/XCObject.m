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
    NSCharacterSet* set = [NSCharacterSet characterSetWithCharactersInString:@"()$%<>-+*& "];
    NSRange range = [self rangeOfCharacterFromSet:set];
    if (range.location != NSNotFound) {
        return [NSString stringWithFormat:@"\"%@\"", self];
    }
    if ([self isEqualToString:@""]) {
        return @"\"\"";
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

- (NSString*)xcodeSavedFileObjectArrayComment {
    return [self xcodeSavedFileObjectComment];
}

- (void)serializeString:(NSString*)s named:(NSString*)name onMutableString:(NSMutableString*)output {
    if (s) {
        [output appendFormat:@"\t\t\t%@ = %@;\n", name, [s quotedIfNecessary]];
    }
}

- (void)serializeDictionary:(NSDictionary*)dict named:(NSString*)name onMutableString:(NSMutableString*)output {
    if (dict) {
        [output appendFormat:@"\t\t\t%@ = {\n", name];
        
        for (id obj in [[dict allKeys] sortedArrayUsingSelector:@selector(compare:)]) {
            [output appendFormat:@"\t\t\t\t%@ = %@;\n", [obj quotedIfNecessary], [[dict objectForKey:obj] quotedIfNecessary]];
        }
        
        [output appendFormat:@"\t\t\t};\n"];
    }
}

- (void)serializeArray:(NSArray*)a named:(NSString*)name onMutableString:(NSMutableString*)output {
    if (a) {
        [output appendFormat:@"\t\t\t%@ = (\n", name];
        
        for (id obj in a) {
            if ([obj isKindOfClass:[NSString class]]) {
                [output appendFormat:@"\t\t\t\t%@,\n", [obj quotedIfNecessary]];
            } else {
                XCObject* xco = (XCObject*)obj;
                [output appendFormat:@"\t\t\t\t%@%@,\n", xco.originalKey, [xco xcodeSavedFileObjectArrayComment]];
            }
        }
        
        [output appendFormat:@"\t\t\t);\n"];
    }
}

- (void)serializePointer:(XCObject*)xco named:(NSString*)name onMutableString:(NSMutableString*)output {
    if (xco) {
        [output appendFormat:@"\t\t\t%@ = %@%@;\n", name, xco.originalKey, [xco xcodeSavedFileObjectComment]];
    }
}

- (void)writeOnMutableString:(NSMutableString*)output {
    [output appendFormat:@"\t\t%@%@ = {\n", self.originalKey, [self xcodeSavedFileObjectComment]];
    [output appendFormat:@"\t\t\tisa = %@;\n", self.xcodeObjectType];
    [self writeSlotsOnMutableString:output];
    [output appendString:@"\t\t};\n"];
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
    NSString* sourceTree = self.fileRef.sourceTree;
    NSString* fileName = self.fileRef.path;
    if (!fileName) {
        fileName = self.fileRef.name;
    }
    if ([self.fileRef.sourceTree isEqualToString:@"<group>"]) {
        if (self.fileRef.path) {
            sourceTree = @"in Sources";
        } else {
            sourceTree = @"in Resources";
        }
    } else if ([self.fileRef.sourceTree isEqualToString:@"SDKROOT"]) {
        sourceTree = @"in Frameworks";
        fileName = [fileName lastPathComponent];
    }
    [output appendFormat:@"\t\t%@ /* %@ %@ */ = {isa = %@; fileRef = %@%@; };\n", self.originalKey, fileName, sourceTree, self.xcodeObjectType, self.fileRef.originalKey, [self.fileRef xcodeSavedFileObjectComment]];
}
- (NSString*)xcodeSavedFileObjectComment {
    return [self.fileRef xcodeSavedFileObjectComment];
}
- (NSString*)xcodeSavedFileObjectArrayComment {
    NSString* sourceTree = self.fileRef.sourceTree;
    NSString* fileName = self.fileRef.path;
    if (!fileName) {
        fileName = self.fileRef.name;
    }
    if ([self.fileRef.sourceTree isEqualToString:@"<group>"]) {
        if (self.fileRef.path) {
            sourceTree = @"in Sources";
        } else {
            sourceTree = @"in Resources";
        }
    } else if ([self.fileRef.sourceTree isEqualToString:@"SDKROOT"]) {
        sourceTree = @"in Frameworks";
        fileName = [fileName lastPathComponent];
    }
    return [NSString stringWithFormat:@" /* %@ %@ */", fileName, sourceTree];
}
@end

@implementation XPPBXFileReference (output)
- (void)writeOnMutableString:(NSMutableString*)output {
    [output appendFormat:@"\t\t%@%@ = {isa = %@; ", self.originalKey, [self xcodeSavedFileObjectComment], self.xcodeObjectType];
    if (self.explicitFileType) [output appendFormat:@"explicitFileType = %@; ", [self.explicitFileType quotedIfNecessary]];
    if (self.includeInIndex) [output appendFormat:@"includeInIndex = %@; ", self.includeInIndex];
    if (self.fileEncoding) [output appendFormat:@"fileEncoding = %@; ", self.fileEncoding];
    if (self.lastKnownFileType) [output appendFormat:@"lastKnownFileType = %@; ", [self.lastKnownFileType quotedIfNecessary]];
    if (self.name) [output appendFormat:@"name = %@; ", [self.name quotedIfNecessary]];
    if (self.path) [output appendFormat:@"path = %@; ", [self.path quotedIfNecessary]];
    if (self.sourceTree) [output appendFormat:@"sourceTree = %@; ", [self.sourceTree quotedIfNecessary]];
    [output appendString:@"};\n"];
}
- (NSString*)xcodeSavedFileObjectComment {
    NSString* result;
    if (self.name) {
        result = self.name;
    } else {
        result = self.path;
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

@implementation XPXCVersionGroup (output)
- (NSString*)xcodeSavedFileObjectComment {
    return [NSString stringWithFormat:@" /* %@ */", self.path];
}
@end