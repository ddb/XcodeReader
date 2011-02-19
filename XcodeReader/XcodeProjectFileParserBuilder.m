//
//  XcodeProjectFileParserBuilder.m
//  XcodeProj
//
//  Created by David Brown on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XcodeProjectFileParserBuilder.h"


@implementation XcodeProjectFileParserBuilder

+ (void)buildSourceImplementationFilePath:(NSString*)implementationFilePath 
                    withInterfaceFilePath:(NSString*)interfaceFilePath 
                          usingXcodeTypes:(NSDictionary*)xcodeProjectTypes {
    NSMutableString* header = [NSMutableString string];
    NSMutableString* source = [NSMutableString string];
    NSArray* sortedClasses = [[xcodeProjectTypes allKeys] sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    for (NSString* className in sortedClasses) {
        [header appendFormat:@"@class XP%@;\n", className];
    }
    [header appendFormat:@"\n"];
    for (NSString* className in sortedClasses) {
        NSDictionary* slotDefs = [xcodeProjectTypes objectForKey:className];
        NSArray* sortedSlots = [[slotDefs allKeys] sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
        
        NSMutableString* slotDeclarations = [NSMutableString string];
        NSMutableString* propDeclarations = [NSMutableString string];
        
        [source appendFormat:@"@implementation XP%@\n", className];
        for (NSString* slotName in sortedSlots) {
            id slotType = [slotDefs objectForKey:slotName];
            if ([slotType isKindOfClass:[NSSet class]]) {
                [propDeclarations appendFormat:@"// types in %@: %@\n", slotName, [[slotType allObjects] componentsJoinedByString:@", "]];
                [propDeclarations appendFormat:@"@property (nonatomic, retain) NSArray* %@;\n", slotName];
                [slotDeclarations appendFormat:@"    NSArray* %@;\n", slotName];
            } else {
                if (![slotType isEqualToString:@"NSString"] && ![slotType isEqualToString:@"NSDictionary"]) {
                    slotType = [NSString stringWithFormat:@"XP%@", slotType];
                }
                [propDeclarations appendFormat:@"@property (nonatomic, retain) %@* %@;\n", slotType, slotName];
                [slotDeclarations appendFormat:@"    %@* %@;\n", slotType, slotName];
            }
            [source appendFormat:@"@synthesize %@;\n", slotName];
        }
        
        [header appendFormat:@"@interface XP%@ : XCObject {\n", className];
        [header appendString:slotDeclarations];
        [header appendFormat:@"}\n"];
        [header appendString:propDeclarations];
        
        NSMutableString* inflate = [NSMutableString string];
        NSMutableString* connect = [NSMutableString string];
        
        [inflate appendFormat:@"- (void)inflateFromDictionary:(NSDictionary*)dict {\n"];
        [connect appendFormat:@"- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {\n"];
        
        for (NSString* slotName in sortedSlots) {
            NSString* slotType = [slotDefs objectForKey:slotName];
            if ([slotType isKindOfClass:[NSSet class]]) {
                [connect appendFormat:@"    NSMutableArray* %@Array = [NSMutableArray array];\n", slotName];
                [connect appendFormat:@"    for (id objectName in [dict objectForKey:@\"%@\"]) {\n", slotName];
                if ([(NSSet*)slotType containsObject:@"NSString"] || [(NSSet*)slotType containsObject:@"NSDictionary"]) {
                    [connect appendFormat:@"        [%@Array addObject:objectName];\n", slotName];
                } else {
                    [connect appendFormat:@"        [%@Array addObject:[store objectForKey:objectName]];\n", slotName];
                }
                [connect appendFormat:@"    }\n"];
                [connect appendFormat:@"    self.%@ = %@Array;\n", slotName, slotName];
            } else if ([slotType isEqualToString:@"NSString"] || [slotType isEqualToString:@"NSDictionary"]) {
                [inflate appendFormat:@"    self.%@ = [dict objectForKey:@\"%@\"];\n", slotName, slotName];
            } else {
                [connect appendFormat:@"    self.%@ = [store objectForKey:[dict objectForKey:@\"%@\"]];\n", slotName, slotName];
            }
        }
        
        [inflate appendFormat:@"}\n"];
        [connect appendFormat:@"}\n"];
        
        [source appendString:inflate];
        [source appendString:connect];
        
        [source appendFormat:@"- (void)dealloc {\n"];
        for (NSString* slotName in sortedSlots) {
            [source appendFormat:@"    [%@ release], %@ = nil;\n", slotName, slotName];
        }
        [source appendFormat:@"    [super dealloc];\n"];
        [source appendFormat:@"}\n"];
        
        [header appendFormat:@"@end\n\n"];
        [source appendFormat:@"@end\n\n"];
    }
    
    [header writeToURL:[NSURL fileURLWithPath:interfaceFilePath] atomically:NO encoding:NSUTF8StringEncoding error:nil];
    [source writeToURL:[NSURL fileURLWithPath:implementationFilePath] atomically:NO encoding:NSUTF8StringEncoding error:nil];
}


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
