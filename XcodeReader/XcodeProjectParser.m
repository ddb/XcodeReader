//
//  XcodeProjectParse.m
//  XcodeProj
//
//  Created by David Brown on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XcodeProjectParser.h"
#import <objc/runtime.h>
#import "DDCliUtil.h"

@implementation XcodeProjectParser

@synthesize objects;
@synthesize types;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithProject:(NSDictionary*)project {
    self = [super init];
    if (self) {
        // Initialization code here.
        self.objects = [project objectForKey:@"objects"];
        self.types = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (id)objectNamed:(NSString*)name {
    return [self.objects objectForKey:name];
}

- (NSString*)typeStringForObject:(id)obj {
    if ([obj isKindOfClass:[NSString class]]) {
        id value = [self objectNamed:obj];
        if (value) {
            return [value objectForKey:@"isa"];
        } else {
            return @"NSString";
        }
    }
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSString* typeString = [obj objectForKey:@"isa"];
        if (typeString) {
            return typeString;
        } else {
            return @"NSDictionary";
        }
    }
    if ([obj isKindOfClass:[NSArray class]]) {
        return @"NSArray";
    }
    return [NSString stringWithCString:class_getName([obj class]) 
                              encoding:NSASCIIStringEncoding];
}

- (void)findTypesUsingDictionary:(NSMutableDictionary*)staticTypes {
    for (NSDictionary* obj in [self.objects allValues]) {
        NSString* typeString = [self typeStringForObject:obj];
        ddprintf(@"    type: %@\n", typeString);
        NSMutableDictionary* objType = [staticTypes objectForKey:typeString];
        if (!objType) {
            objType = [NSMutableDictionary dictionary];
            [staticTypes setObject:objType forKey:typeString];
        }
        
        for (NSString* slotName in [obj allKeys]) {
            if ([slotName isEqualToString:@"isa"]) {
                continue;
            }
            NSString* slotType = [self typeStringForObject:[obj objectForKey:slotName]];
            if ([slotType isEqualToString:@"NSArray"]) {
                NSArray* slotObject = [obj objectForKey:slotName];
                if ([slotObject count]) {
                    NSMutableSet* typesInArray = [objType objectForKey:slotName];
                    if (!typesInArray) {
                        typesInArray = [NSMutableSet set];
                    }
                    for (id objInArray in slotObject) {
                        [typesInArray addObject:[self typeStringForObject:objInArray]];
                    }
                    [objType setObject:typesInArray forKey:slotName];
                }
            } else {
                [objType setObject:slotType 
                            forKey:slotName];
            }
        }
    }
}

@end
