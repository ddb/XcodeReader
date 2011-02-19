//
//  XcodeProjectFileParserBuilder.h
//  XcodeProj
//
//  Created by David Brown on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XcodeProjectFileParserBuilder : NSObject {
@private
    
}

+ (void)buildSourceImplementationFilePath:(NSString*)implementationFilePath 
                    withInterfaceFilePath:(NSString*)interfaceFilePath 
                          usingXcodeTypes:(NSDictionary*)xcodeProjectTypes;

@end
