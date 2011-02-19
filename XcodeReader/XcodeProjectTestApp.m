#import "XcodeProjectTestApp.h"
#import "XcodeProject.h"

@implementation XcodeProjectTestApp

- (id) init;
{
    self = [super init];
    if (self == nil)
        return nil;
    
    _includeDirectories = [[NSMutableArray alloc] init];
    
    return self;
}

- (void) setVerbose: (BOOL) verbose;
{
    if (verbose)
        _verbosity++;
    else if (_verbosity > 0)
        _verbosity--;
}

- (void) setInclude: (NSString *) file;
{
    if ([file isEqualToString: @"invalid"])
    {
        DDCliParseException * e =
            [DDCliParseException parseExceptionWithReason: @"Invalid include name"
                                                 exitCode: EX_USAGE];
        @throw e;
    }
    [_includeDirectories addObject: file];
}

- (void) printUsage: (FILE *) stream;
{
    ddfprintf(stream, @"%@: Usage [OPTIONS] <argument> [...]\n", DDCliApp);
}

- (void) printHelp;
{
    [self printUsage: stdout];
    printf("\n"
           "  -f, --foo FOO                 Use foo with FOO\n"
           "  -I, --include FILE            Include FILE\n"
           "  -b, --bar[=BAR]               Use bar with BAR\n"
           "      --long-opt                Enable long option\n"
           "  -v, --verbose                 Increase verbosity\n"
           "      --version                 Display version and exit\n"
           "  -h, --help                    Display this help and exit\n"
           "\n"
           "A test application for DDCommandLineInterface.\n");
}

- (void) printVersion;
{
//    ddprintf(@"%@ version %s\n", DDCliApp, CURRENT_MARKETING_VERSION);
}

- (void) application: (DDCliApplication *) app
    willParseOptions: (DDGetoptLongParser *) optionsParser;
{
    DDGetoptOption optionTable[] = 
    {
        // Long         Short   Argument options
        {@"foo",        'f',    DDGetoptRequiredArgument},
        {@"include",    'I',    DDGetoptRequiredArgument},
        {@"bar",        'b',    DDGetoptOptionalArgument},
        {@"long-opt",   0,      DDGetoptNoArgument},
        {@"verbose",    'v',    DDGetoptNoArgument},
        {@"version",    0,      DDGetoptNoArgument},
        {@"help",       'h',    DDGetoptNoArgument},
        {nil,           0,      0},
    };
    [optionsParser addOptionsFromTable: optionTable];
}

- (int) application: (DDCliApplication *) app
   runWithArguments: (NSArray *) arguments;
{
    if (_help)
    {
        [self printHelp];
        return EXIT_SUCCESS;
    }
    
    if (_version)
    {
        [self printVersion];
        return EXIT_SUCCESS;
    }
    
    if ([arguments count] < 1)
    {
        ddfprintf(stderr, @"%@: At least one argument is required\n", DDCliApp);
        [self printUsage: stderr];
        ddfprintf(stderr, @"Try `%@ --help' for more information.\n",
                  DDCliApp);
        return EX_USAGE;
    }
    
    ddprintf(@"foo: %@, bar: %@, longOpt: %@, verbosity: %d\n",
             _foo, _bar, _longOpt, _verbosity);
    ddprintf(@"Include directories: %@\n", _includeDirectories);
    ddprintf(@"Arguments: %@\n", arguments);
    
    NSURL* xcodeProjectFile = [NSURL fileURLWithPath:[arguments objectAtIndex:0]];
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
                        // in the sourcesBuildPhase, file.fileRef.path is used
                        NSLog(@"file: %@ (%@)", file.fileRef.path, file.fileRef.xcodeObjectType);
                    }
                } else if ([phase isKindOfClass:[XPPBXResourcesBuildPhase class]]) {
                    XPPBXResourcesBuildPhase* resourcesPhase = (XPPBXResourcesBuildPhase*)phase;
                    for (XPPBXBuildFile* file in resourcesPhase.files) {
                        // in the resourcesBuildPhase, file.fileRef.name is used
                        NSLog(@"resource file: %@ (%@)", file.fileRef.name, file.fileRef.xcodeObjectType);
                    }
                } else if ([phase isKindOfClass:[XPPBXFrameworksBuildPhase class]]) {
                    XPPBXFrameworksBuildPhase* frameworksBuildPhase = (XPPBXFrameworksBuildPhase*)phase;
                    for (XPPBXBuildFile* file in frameworksBuildPhase.files) {
                        // in the frameworksBuildPhase, file.fileRef.path is used
                        NSLog(@"framework file: %@ (%@)", file.fileRef.path, file.fileRef.xcodeObjectType);
                    }
                } else if ([phase isKindOfClass:[XPPBXCopyFilesBuildPhase class]]) {
                    XPPBXCopyFilesBuildPhase* copyPhase = (XPPBXCopyFilesBuildPhase*)phase;
                    for (XPPBXBuildFile* file in copyPhase.files) {
                        // in the copyFilesBuildPhase, file.fileRef.path is used
                        NSLog(@"copy file: %@ (%@)", file.fileRef.path, file.fileRef.xcodeObjectType);
                    }
                } else if ([phase isKindOfClass:[XPPBXShellScriptBuildPhase class]]) {
                    XPPBXShellScriptBuildPhase* scriptPhase = (XPPBXShellScriptBuildPhase*)phase;
                    // in the shellScriptBuildPhase, there are no children, the script is stored directly
                    NSLog(@"script: %@", scriptPhase.shellScript);
                }
            }
        }
    }
    
    return EXIT_SUCCESS;
}

@end
