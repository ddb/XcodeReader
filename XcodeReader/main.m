//
//  main.m
//  XcodeReader
//
//  Created by David Brown on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XcodeProject.h"

int main (int argc, const char * argv[])
{

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    NSURL* xcodeProjectFile = [NSURL fileURLWithPath:[NSString stringWithCString:argv[1] encoding:NSASCIIStringEncoding]];
    XcodeProject* xcp = [[XcodeProject alloc] initFromURL:xcodeProjectFile];
    
    for (id target in xcp.rootObject.targets) {
        if ([target isKindOfClass:[XPPBXNativeTarget class]]) {
            NSLog(@"target: %@", ((XPPBXNativeTarget*)target).name);
            for (id phase in ((XPPBXNativeTarget*)target).buildPhases) {
                if ([phase isKindOfClass:[XPPBXSourcesBuildPhase class]]) {
                    XPPBXSourcesBuildPhase* buildPhase = (XPPBXSourcesBuildPhase*)phase;
                    for (XPPBXBuildFile* file in buildPhase.files) {
                        NSLog(@"file: %@", file.fileRef.path);
                    }
                }
            }
        }
    }

    [pool drain];
    return 0;
}

