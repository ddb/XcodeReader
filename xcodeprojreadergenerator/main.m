#import <Foundation/Foundation.h>
#import "DDCommandLineInterface.h"
#import "XcodeProjectFileParserBuilderApp.h"

int main (int argc, char * const * argv)
{
    return DDCliAppRunWithClass([XcodeProjectFileParserBuilderApp class]);
}
