//
//  XCObject.h
//  XcodeProj
//
//  Created by David Brown on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCObject : NSObject {
@private
    
}

@property (nonatomic, retain) NSString* xcodeObjectType;
@property (nonatomic, retain) NSString* originalKey;

- (void)inflateFromDictionary:(NSDictionary*)dict;
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store;

- (void)writeOnMutableString:(NSMutableString*)output;
- (void)writeSlotsOnMutableString:(NSMutableString*)output;

- (void)serializeString:(NSString*)s named:(NSString*)name onMutableString:(NSMutableString*)output;
- (void)serializeDictionary:(NSDictionary*)dict named:(NSString*)name onMutableString:(NSMutableString*)output;
- (void)serializeArray:(NSArray*)a named:(NSString*)name onMutableString:(NSMutableString*)output;
- (void)serializePointer:(XCObject*)xco named:(NSString*)name onMutableString:(NSMutableString*)output;

- (NSString*)xcodeSavedFileObjectComment;
- (NSString*)xcodeSavedFileObjectArrayComment;

+ (XCObject*)XCObjectFromDictionary:(NSDictionary*)dict forKey:(NSString*)key;

@end