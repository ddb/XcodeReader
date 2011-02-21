#import "XcodeProjectTestApp.h"
#import "XcodeProject.h"

@implementation XcodeProjectTestApp

- (id) init {
    self = [super init];
    if (self == nil)
        return nil;
    return self;
}

- (void)printUsage:(FILE*)stream {
    ddfprintf(stream, @"%@: Usage [OPTIONS] <argument> [...]\n", DDCliApp);
}

- (void)printHelp {
    [self printUsage:stdout];
    printf("A test application for DDCommandLineInterface.\n");
}

- (void)printVersion {
//    ddprintf(@"%@ version %s\n", DDCliApp, CURRENT_MARKETING_VERSION);
}

- (void)application:(DDCliApplication*)app willParseOptions:(DDGetoptLongParser*)optionsParser {
    DDGetoptOption optionTable[] = {
        // Long         Short   Argument options
        {nil,           0,      0},
    };
    [optionsParser addOptionsFromTable:optionTable];
}

- (int)application:(DDCliApplication*)app runWithArguments:(NSArray*)arguments {
    if ([arguments count] < 1) {
        ddfprintf(stderr, @"%@: At least one argument is required\n", DDCliApp);
        [self printUsage:stderr];
        ddfprintf(stderr, @"Try `%@ --help' for more information.\n", DDCliApp);
        return EX_USAGE;
    }
    
    ddprintf(@"Arguments: %@\n", arguments);
    
    NSURL* xcodeProjectFile = [NSURL fileURLWithPath:[arguments objectAtIndex:0]];
    XcodeProject* xcp = [[XcodeProject alloc] initFromURL:xcodeProjectFile];
    
    NSLog(@"asString: %@", [xcp asString]);
    
//    NSLog(@"objectVersion: %@", xcp.objectVersion);
//    NSLog(@"archiveVersion: %@", xcp.archiveVersion);
//    NSLog(@"classes: (%@) %@", [xcp.classes class], xcp.classes);
//    
//    for (id target in xcp.rootObject.targets) {
//        if ([target isKindOfClass:[XPPBXNativeTarget class]]) {
//            XPPBXNativeTarget* nativeTarget = (XPPBXNativeTarget*)target;
//            NSLog(@"target: %@", nativeTarget.name);
//            for (XCObject* phase in nativeTarget.buildPhases) {
//                NSLog(@"phase: %@", phase.xcodeObjectType);
//                
//                if ([phase isKindOfClass:[XPPBXSourcesBuildPhase class]]) {
//                    XPPBXSourcesBuildPhase* buildPhase = (XPPBXSourcesBuildPhase*)phase;
//                    for (XPPBXBuildFile* file in buildPhase.files) {
//                        // in the sourcesBuildPhase, file.fileRef.path is used
//                        NSLog(@"file: %@ (%@)", file.fileRef.path, file.fileRef.xcodeObjectType);
//                    }
//                } else if ([phase isKindOfClass:[XPPBXResourcesBuildPhase class]]) {
//                    XPPBXResourcesBuildPhase* resourcesPhase = (XPPBXResourcesBuildPhase*)phase;
//                    for (XPPBXBuildFile* file in resourcesPhase.files) {
//                        // in the resourcesBuildPhase, file.fileRef.name is used
//                        NSLog(@"resource file: %@ (%@)", file.fileRef.name, file.fileRef.xcodeObjectType);
//                    }
//                } else if ([phase isKindOfClass:[XPPBXFrameworksBuildPhase class]]) {
//                    XPPBXFrameworksBuildPhase* frameworksBuildPhase = (XPPBXFrameworksBuildPhase*)phase;
//                    for (XPPBXBuildFile* file in frameworksBuildPhase.files) {
//                        // in the frameworksBuildPhase, file.fileRef.path is used
//                        NSLog(@"framework file: %@ (%@)", file.fileRef.path, file.fileRef.xcodeObjectType);
//                    }
//                } else if ([phase isKindOfClass:[XPPBXCopyFilesBuildPhase class]]) {
//                    XPPBXCopyFilesBuildPhase* copyPhase = (XPPBXCopyFilesBuildPhase*)phase;
//                    for (XPPBXBuildFile* file in copyPhase.files) {
//                        // in the copyFilesBuildPhase, file.fileRef.path is used
//                        NSLog(@"copy file: %@ (%@)", file.fileRef.path, file.fileRef.xcodeObjectType);
//                    }
//                } else if ([phase isKindOfClass:[XPPBXShellScriptBuildPhase class]]) {
//                    XPPBXShellScriptBuildPhase* scriptPhase = (XPPBXShellScriptBuildPhase*)phase;
//                    // in the shellScriptBuildPhase, there are no children, the script is stored directly
//                    NSLog(@"script: %@", scriptPhase.shellScript);
//                }
//            }
//        }
//    }
    
    return EXIT_SUCCESS;
}

@end
