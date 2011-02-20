//
//  XcodeProjectFileParserBuilderApp.m
//  XcodeReader
//
//  Created by David Brown on 2/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XcodeProjectFileParserBuilderApp.h"
#import "XcodeProjectFileParserBuilder.h"

@implementation XcodeProjectFileParserBuilderApp

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)printUsage:(FILE*)stream {
    ddfprintf(stream, @"%@: Usage <staticTypesPlist> <targetFileName>\n", DDCliApp);
}

- (void)printHelp {
    [self printUsage:stdout];
    printf("generates source code that parses the file format of xcodeproj files.\n");
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
    if ([arguments count] < 2) {
        ddfprintf(stderr, @"%@: Two arguments are required\n", DDCliApp);
        [self printUsage:stderr];
        return EX_USAGE;
    }
    
    NSString* staticTypesDictionaryPlistFullPath = [[arguments objectAtIndex:0] stringByExpandingTildeInPath];
    NSString* targetFileNameFullPath = [[arguments objectAtIndex:1] stringByExpandingTildeInPath];
    
    NSDictionary* staticTypesDict = [NSDictionary dictionaryWithContentsOfFile:staticTypesDictionaryPlistFullPath];
    [XcodeProjectFileParserBuilder buildSourceImplementationFilePath:[NSString stringWithFormat:@"%@.m", targetFileNameFullPath] 
                                               withInterfaceFilePath:[NSString stringWithFormat:@"%@.h", targetFileNameFullPath] 
                                                     usingXcodeTypes:staticTypesDict];
    
    return EXIT_SUCCESS;
}

@end
