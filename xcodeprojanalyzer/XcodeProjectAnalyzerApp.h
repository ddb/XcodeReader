#import <Foundation/Foundation.h>
#import "DDCommandLineInterface.h"

@interface XcodeProjectAnalyzerApp : NSObject <DDCliApplicationDelegate> {
}

@property (nonatomic, retain) NSMutableDictionary* staticTypes;

@end

