#import <Foundation/Foundation.h>
#import "DDCommandLineInterface.h"
#import "XcodeProjectTestApp.h"

int main (int argc, char * const * argv)
{
    return DDCliAppRunWithClass([XcodeProjectTestApp class]);
}
