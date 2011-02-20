//
//  XcodeProjectParse.h
//  XcodeProj
//
//  Created by David Brown on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XcodeProjectParser : NSObject {
@private
    
}

@property (retain) NSDictionary* objects;
@property (retain) NSMutableDictionary* types;

- (id)initWithProject:(NSDictionary*)project;
- (id)objectNamed:(NSString*)name;

- (void)findTypesUsingDictionary:(NSMutableDictionary*)staticTypes;

@end
