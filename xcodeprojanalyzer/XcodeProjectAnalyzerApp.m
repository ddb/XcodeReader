#import "XcodeProjectAnalyzerApp.h"
#import "XcodeProjectParser.h"

@implementation XcodeProjectAnalyzerApp

@synthesize staticTypes;

- (id) init {
    self = [super init];
    if (self == nil)
        return nil;
    return self;
}

- (void)printUsage:(FILE*)stream {
    ddfprintf(stream, @"%@: Usage <path> <staticTypesFilename>\n", DDCliApp);
}

- (void)printHelp {
    [self printUsage:stdout];
    printf("analyzes the file format of xcodeproj files.\n");
}

- (void)printVersion {
    //    ddprintf(@"%@ version %s\n", DDCliApp, CURRENT_MARKETING_VERSION);
}

- (void)processXcodeProject:(NSURL*)projectURL {
    NSURL* projectFile = [projectURL URLByAppendingPathComponent:@"project.pbxproj"];
    
    NSPropertyListFormat theFormat = NSPropertyListOpenStepFormat;
    id contents = [NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:projectFile]
                                                   mutabilityOption:NSPropertyListImmutable
                                                             format:&theFormat
                                                   errorDescription:nil];

    XcodeProjectParser* xcodeProject = [[[XcodeProjectParser alloc] initWithProject:contents] autorelease];
    [xcodeProject findTypesUsingDictionary:self.staticTypes];
}

- (void)processURL:(NSURL*)url {
    NSString* ext = [url pathExtension];
    
    if ([ext isEqualToString:@"xcodeproj"]) {
        ddprintf(@"%@\n", [url path]);
        [self processXcodeProject:url];
    } else {
        NSUInteger options = (NSDirectoryEnumerationSkipsPackageDescendants|NSDirectoryEnumerationSkipsHiddenFiles);
        NSArray* contents = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:url 
                                                          includingPropertiesForKeys:nil
                                                                             options:options
                                                                               error:nil];
        for (NSURL* sub in contents) {
            [self processURL:sub];
        } 
    }
}

- (void)application:(DDCliApplication*)app willParseOptions:(DDGetoptLongParser*)optionsParser {
    DDGetoptOption optionTable[] = {
        // Long         Short   Argument options
        {nil,           0,      0},
    };
    [optionsParser addOptionsFromTable:optionTable];
}

- (int)application:(DDCliApplication*)app runWithArguments:(NSArray*)arguments {
    if ([arguments count] < 2) {
        ddfprintf(stderr, @"%@: Two arguments are required\n", DDCliApp);
        [self printUsage:stderr];
        return EX_USAGE;
    }
    
    self.staticTypes = [NSMutableDictionary dictionary];
    [self processURL:[NSURL fileURLWithPath:[[arguments objectAtIndex:0] stringByExpandingTildeInPath]]];
    NSString* plistFileName = [[arguments objectAtIndex:1] stringByExpandingTildeInPath];
    ddprintf(@"\nstaticTypes: (%@) %@\n", plistFileName, self.staticTypes);
    
    // turn the NSSet objects into NSArray objects, since NSSet's cannot go into a property list
    for (NSString* typeKey in [self.staticTypes allKeys]) {
        NSMutableDictionary* typeDict = [self.staticTypes objectForKey:typeKey];
        for (NSString* slotName in [typeDict allKeys]) {
            id slotObject = [typeDict objectForKey:slotName];
            if ([slotObject isKindOfClass:[NSSet class]]) {
                [typeDict setValue:[slotObject allObjects] forKey:slotName];
            }
        }
    }
    
    if (![self.staticTypes writeToFile:plistFileName atomically:NO]) {
        ddprintf(@"hmm\n");
    }
    
    return EXIT_SUCCESS;
}

@end
