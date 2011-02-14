//
//  XcodeProject.h
//  XcodeProj
//
//  Created by David Brown on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCObject.h"

@interface XcodeProject : NSObject {
    NSDictionary* objects;
    XPPBXProject* rootObject;
}

@property (retain) NSDictionary* objects;
@property (retain) XPPBXProject* rootObject;

- (id)initFromURL:(NSURL*)projectURL;

@end
