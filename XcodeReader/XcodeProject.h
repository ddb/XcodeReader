//
//  XcodeProject.h
//  XcodeProj
//
//  Created by David Brown on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XcodeParserObjects.h"

@interface XcodeProject : NSObject {
    NSDictionary* objects;
    NSMutableDictionary* typeGroups;
    XPPBXProject* rootObject;
    NSString* archiveVersion;
    NSString* objectVersion;
    id classes;
}

@property (retain) NSDictionary* objects;
@property (retain) NSMutableDictionary* typeGroups;
@property (retain) XPPBXProject* rootObject;

@property (retain) NSString* archiveVersion;
@property (retain) NSString* objectVersion;
@property (retain) id classes;

- (id)initFromURL:(NSURL*)projectURL;

@end
