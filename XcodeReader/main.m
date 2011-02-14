//
//  main.m
//  XcodeReader
//
//  Created by David Brown on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XcodeProject.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    NSURL* xcodeProjectFile = [NSURL fileURLWithPath:[NSString stringWithCString:argv[1] 
                                                                        encoding:NSASCIIStringEncoding]];
    XcodeProject* xcp = [[XcodeProject alloc] initFromURL:xcodeProjectFile];
    
    for (id target in xcp.rootObject.targets) {
        if ([target isKindOfClass:[XPPBXNativeTarget class]]) {
            XPPBXNativeTarget* nativeTarget = (XPPBXNativeTarget*)target;
            NSLog(@"target: %@", nativeTarget.name);
            for (XCObject* phase in nativeTarget.buildPhases) {
                NSLog(@"phase: %@", phase.xcodeObjectType);
                
                if ([phase isKindOfClass:[XPPBXSourcesBuildPhase class]]) {
                    XPPBXSourcesBuildPhase* buildPhase = (XPPBXSourcesBuildPhase*)phase;
                    for (XPPBXBuildFile* file in buildPhase.files) {
                        NSLog(@"file: %@", file.fileRef.path);
                    }
                } else if ([phase isKindOfClass:[XPPBXResourcesBuildPhase class]]) {
                    XPPBXResourcesBuildPhase* resourcesPhase = (XPPBXResourcesBuildPhase*)phase;
                    for (XPPBXBuildFile* file in resourcesPhase.files) {
                        NSLog(@"resource file: %@", file.fileRef.path);
                    }
                } else if ([phase isKindOfClass:[XPPBXFrameworksBuildPhase class]]) {
                    XPPBXFrameworksBuildPhase* frameworksBuildPhase = (XPPBXFrameworksBuildPhase*)phase;
                    for (XPPBXBuildFile* file in frameworksBuildPhase.files) {
                        NSLog(@"framework file: %@", file.fileRef.path);
                    }
                } else if ([phase isKindOfClass:[XPPBXCopyFilesBuildPhase class]]) {
                    XPPBXCopyFilesBuildPhase* copyPhase = (XPPBXCopyFilesBuildPhase*)phase;
                    for (XPPBXBuildFile* file in copyPhase.files) {
                        NSLog(@"copy file: %@", file.fileRef.path);
                    }
                } else if ([phase isKindOfClass:[XPPBXShellScriptBuildPhase class]]) {
                    XPPBXShellScriptBuildPhase* scriptPhase = (XPPBXShellScriptBuildPhase*)phase;
                    NSLog(@"script: %@", scriptPhase.shellScript);
                }
                
            }
        }
    }

    [pool drain];
    return 0;
}

