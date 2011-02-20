#import <Foundation/Foundation.h>
#import "DDCommandLineInterface.h"
#import "XcodeProjectAnalyzerApp.h"

int main (int argc, char * const * argv)
{
    return DDCliAppRunWithClass([XcodeProjectAnalyzerApp class]);
}
