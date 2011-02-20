//
//  XCObject.h
//  XcodeProj
//
//  Created by David Brown on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCObject : NSObject {
@private
    
}

@property (nonatomic, retain) NSString* xcodeObjectType;
@property (nonatomic, retain) NSString* originalKey;

- (void)inflateFromDictionary:(NSDictionary*)dict;
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store;

+ (XCObject*)XCObjectFromDictionary:(NSDictionary*)dict forKey:(NSString*)key;

@end

@class XPPBXAggregateTarget;
@class XPPBXAppleScriptBuildPhase;
@class XPPBXApplicationReference;
@class XPPBXApplicationTarget;
@class XPPBXBuildFile;
@class XPPBXBuildRule;
@class XPPBXBuildStyle;
@class XPPBXContainerItemProxy;
@class XPPBXCopyFilesBuildPhase;
@class XPPBXFileReference;
@class XPPBXFrameworkReference;
@class XPPBXFrameworksBuildPhase;
@class XPPBXGroup;
@class XPPBXHeadersBuildPhase;
@class XPPBXLegacyTarget;
@class XPPBXNativeTarget;
@class XPPBXProject;
@class XPPBXReferenceProxy;
@class XPPBXResourcesBuildPhase;
@class XPPBXRezBuildPhase;
@class XPPBXShellScriptBuildPhase;
@class XPPBXSourcesBuildPhase;
@class XPPBXTargetDependency;
@class XPPBXVariantGroup;
@class XPXCBuildConfiguration;
@class XPXCConfigurationList;
@class XPXCVersionGroup;

@interface XPPBXAggregateTarget : XCObject {
    XPXCConfigurationList* buildConfigurationList;
    NSArray* buildPhases;
    NSArray* dependencies;
    NSString* name;
    NSString* productName;
}
@property (nonatomic, retain) XPXCConfigurationList* buildConfigurationList;
// types in buildPhases: PBXCopyFilesBuildPhase, PBXShellScriptBuildPhase
@property (nonatomic, retain) NSArray* buildPhases;
// types in dependencies: PBXTargetDependency
@property (nonatomic, retain) NSArray* dependencies;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* productName;
@end

@interface XPPBXAppleScriptBuildPhase : XCObject {
    NSString* buildActionMask;
    NSString* contextName;
    NSArray* files;
    NSString* isSharedContext;
    NSString* runOnlyForDeploymentPostprocessing;
}
@property (nonatomic, retain) NSString* buildActionMask;
@property (nonatomic, retain) NSString* contextName;
// types in files: PBXBuildFile
@property (nonatomic, retain) NSArray* files;
@property (nonatomic, retain) NSString* isSharedContext;
@property (nonatomic, retain) NSString* runOnlyForDeploymentPostprocessing;
@end

@interface XPPBXApplicationReference : XCObject {
    NSString* path;
    NSString* refType;
}
@property (nonatomic, retain) NSString* path;
@property (nonatomic, retain) NSString* refType;
@end

@interface XPPBXApplicationTarget : XCObject {
    XPXCConfigurationList* buildConfigurationList;
    NSArray* buildPhases;
    NSDictionary* buildSettings;
    NSString* name;
    NSString* productInstallPath;
    NSString* productName;
    XPPBXFileReference* productReference;
    NSString* productSettingsXML;
}
@property (nonatomic, retain) XPXCConfigurationList* buildConfigurationList;
// types in buildPhases: PBXResourcesBuildPhase, PBXFrameworksBuildPhase, PBXSourcesBuildPhase, PBXHeadersBuildPhase
@property (nonatomic, retain) NSArray* buildPhases;
@property (nonatomic, retain) NSDictionary* buildSettings;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* productInstallPath;
@property (nonatomic, retain) NSString* productName;
@property (nonatomic, retain) XPPBXFileReference* productReference;
@property (nonatomic, retain) NSString* productSettingsXML;
@end

@interface XPPBXBuildFile : XCObject {
    XPPBXFileReference* fileRef;
    NSDictionary* settings;
}
@property (nonatomic, retain) XPPBXFileReference* fileRef;
@property (nonatomic, retain) NSDictionary* settings;
@end

@interface XPPBXBuildRule : XCObject {
    NSString* compilerSpec;
    NSString* filePatterns;
    NSString* fileType;
    NSString* isEditable;
    NSArray* outputFiles;
    NSString* script;
}
@property (nonatomic, retain) NSString* compilerSpec;
@property (nonatomic, retain) NSString* filePatterns;
@property (nonatomic, retain) NSString* fileType;
@property (nonatomic, retain) NSString* isEditable;
// types in outputFiles: NSString
@property (nonatomic, retain) NSArray* outputFiles;
@property (nonatomic, retain) NSString* script;
@end

@interface XPPBXBuildStyle : XCObject {
    NSDictionary* buildSettings;
    NSString* name;
}
@property (nonatomic, retain) NSDictionary* buildSettings;
@property (nonatomic, retain) NSString* name;
@end

@interface XPPBXContainerItemProxy : XCObject {
    XPPBXProject* containerPortal;
    NSString* proxyType;
    XPPBXNativeTarget* remoteGlobalIDString;
    NSString* remoteInfo;
}
@property (nonatomic, retain) XPPBXProject* containerPortal;
@property (nonatomic, retain) NSString* proxyType;
@property (nonatomic, retain) XPPBXNativeTarget* remoteGlobalIDString;
@property (nonatomic, retain) NSString* remoteInfo;
@end

@interface XPPBXCopyFilesBuildPhase : XCObject {
    NSString* buildActionMask;
    NSString* dstPath;
    NSString* dstSubfolderSpec;
    NSArray* files;
    NSString* name;
    NSString* runOnlyForDeploymentPostprocessing;
}
@property (nonatomic, retain) NSString* buildActionMask;
@property (nonatomic, retain) NSString* dstPath;
@property (nonatomic, retain) NSString* dstSubfolderSpec;
// types in files: PBXBuildFile
@property (nonatomic, retain) NSArray* files;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* runOnlyForDeploymentPostprocessing;
@end

@interface XPPBXFileReference : XCObject {
    NSString* explicitFileType;
    NSString* fileEncoding;
    NSString* includeInIndex;
    NSString* indentWidth;
    NSString* languageSpecificationIdentifier;
    NSString* lastKnownFileType;
    NSString* lineEnding;
    NSString* name;
    NSString* path;
    NSString* plistStructureDefinitionIdentifier;
    NSString* refType;
    NSString* sourceTree;
    NSString* tabWidth;
    NSString* usesTabs;
    NSString* wrapsLines;
    NSString* xcLanguageSpecificationIdentifier;
}
@property (nonatomic, retain) NSString* explicitFileType;
@property (nonatomic, retain) NSString* fileEncoding;
@property (nonatomic, retain) NSString* includeInIndex;
@property (nonatomic, retain) NSString* indentWidth;
@property (nonatomic, retain) NSString* languageSpecificationIdentifier;
@property (nonatomic, retain) NSString* lastKnownFileType;
@property (nonatomic, retain) NSString* lineEnding;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* path;
@property (nonatomic, retain) NSString* plistStructureDefinitionIdentifier;
@property (nonatomic, retain) NSString* refType;
@property (nonatomic, retain) NSString* sourceTree;
@property (nonatomic, retain) NSString* tabWidth;
@property (nonatomic, retain) NSString* usesTabs;
@property (nonatomic, retain) NSString* wrapsLines;
@property (nonatomic, retain) NSString* xcLanguageSpecificationIdentifier;
@end

@interface XPPBXFrameworkReference : XCObject {
    NSString* name;
    NSString* path;
    NSString* refType;
}
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* path;
@property (nonatomic, retain) NSString* refType;
@end

@interface XPPBXFrameworksBuildPhase : XCObject {
    NSString* buildActionMask;
    NSArray* files;
    NSString* runOnlyForDeploymentPostprocessing;
}
@property (nonatomic, retain) NSString* buildActionMask;
// types in files: PBXBuildFile
@property (nonatomic, retain) NSArray* files;
@property (nonatomic, retain) NSString* runOnlyForDeploymentPostprocessing;
@end

@interface XPPBXGroup : XCObject {
    NSArray* children;
    NSString* name;
    NSString* path;
    NSString* refType;
    NSString* sourceTree;
}
// types in children: PBXReferenceProxy, PBXApplicationReference, PBXFileReference, PBXFrameworkReference, PBXGroup, PBXVariantGroup, XCVersionGroup
@property (nonatomic, retain) NSArray* children;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* path;
@property (nonatomic, retain) NSString* refType;
@property (nonatomic, retain) NSString* sourceTree;
@end

@interface XPPBXHeadersBuildPhase : XCObject {
    NSString* buildActionMask;
    NSArray* files;
    NSString* runOnlyForDeploymentPostprocessing;
}
@property (nonatomic, retain) NSString* buildActionMask;
// types in files: PBXBuildFile
@property (nonatomic, retain) NSArray* files;
@property (nonatomic, retain) NSString* runOnlyForDeploymentPostprocessing;
@end

@interface XPPBXLegacyTarget : XCObject {
    NSString* buildArgumentsString;
    XPXCConfigurationList* buildConfigurationList;
    NSString* buildToolPath;
    NSString* buildWorkingDirectory;
    NSString* name;
    NSString* passBuildSettingsInEnvironment;
    NSString* productName;
}
@property (nonatomic, retain) NSString* buildArgumentsString;
@property (nonatomic, retain) XPXCConfigurationList* buildConfigurationList;
@property (nonatomic, retain) NSString* buildToolPath;
@property (nonatomic, retain) NSString* buildWorkingDirectory;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* passBuildSettingsInEnvironment;
@property (nonatomic, retain) NSString* productName;
@end

@interface XPPBXNativeTarget : XCObject {
    XPXCConfigurationList* buildConfigurationList;
    NSArray* buildPhases;
    NSArray* buildRules;
    NSDictionary* buildSettings;
    NSArray* dependencies;
    NSString* name;
    NSString* productInstallPath;
    NSString* productName;
    XPPBXFileReference* productReference;
    NSString* productType;
}
@property (nonatomic, retain) XPXCConfigurationList* buildConfigurationList;
// types in buildPhases: PBXAppleScriptBuildPhase, PBXResourcesBuildPhase, PBXCopyFilesBuildPhase, PBXFrameworksBuildPhase, PBXShellScriptBuildPhase, PBXHeadersBuildPhase, PBXSourcesBuildPhase, PBXRezBuildPhase
@property (nonatomic, retain) NSArray* buildPhases;
// types in buildRules: PBXBuildRule
@property (nonatomic, retain) NSArray* buildRules;
@property (nonatomic, retain) NSDictionary* buildSettings;
// types in dependencies: PBXTargetDependency
@property (nonatomic, retain) NSArray* dependencies;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* productInstallPath;
@property (nonatomic, retain) NSString* productName;
@property (nonatomic, retain) XPPBXFileReference* productReference;
@property (nonatomic, retain) NSString* productType;
@end

@interface XPPBXProject : XCObject {
    NSDictionary* attributes;
    XPXCConfigurationList* buildConfigurationList;
    NSDictionary* buildSettings;
    NSArray* buildStyles;
    NSString* compatibilityVersion;
    NSString* developmentRegion;
    NSString* hasScannedForEncodings;
    NSArray* knownRegions;
    XPPBXGroup* mainGroup;
    XPPBXGroup* productRefGroup;
    NSString* projectDirPath;
    NSArray* projectReferences;
    NSString* projectRoot;
    NSString* shouldCheckCompatibility;
    NSArray* targets;
}
@property (nonatomic, retain) NSDictionary* attributes;
@property (nonatomic, retain) XPXCConfigurationList* buildConfigurationList;
@property (nonatomic, retain) NSDictionary* buildSettings;
// types in buildStyles: PBXBuildStyle
@property (nonatomic, retain) NSArray* buildStyles;
@property (nonatomic, retain) NSString* compatibilityVersion;
@property (nonatomic, retain) NSString* developmentRegion;
@property (nonatomic, retain) NSString* hasScannedForEncodings;
// types in knownRegions: NSString
@property (nonatomic, retain) NSArray* knownRegions;
@property (nonatomic, retain) XPPBXGroup* mainGroup;
@property (nonatomic, retain) XPPBXGroup* productRefGroup;
@property (nonatomic, retain) NSString* projectDirPath;
// types in projectReferences: NSDictionary
@property (nonatomic, retain) NSArray* projectReferences;
@property (nonatomic, retain) NSString* projectRoot;
@property (nonatomic, retain) NSString* shouldCheckCompatibility;
// types in targets: PBXNativeTarget, PBXAggregateTarget, PBXLegacyTarget, PBXApplicationTarget
@property (nonatomic, retain) NSArray* targets;
@end

@interface XPPBXReferenceProxy : XCObject {
    NSString* fileType;
    NSString* name;
    NSString* path;
    XPPBXContainerItemProxy* remoteRef;
    NSString* sourceTree;
}
@property (nonatomic, retain) NSString* fileType;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* path;
@property (nonatomic, retain) XPPBXContainerItemProxy* remoteRef;
@property (nonatomic, retain) NSString* sourceTree;
@end

@interface XPPBXResourcesBuildPhase : XCObject {
    NSString* buildActionMask;
    NSArray* files;
    NSString* runOnlyForDeploymentPostprocessing;
}
@property (nonatomic, retain) NSString* buildActionMask;
// types in files: PBXBuildFile
@property (nonatomic, retain) NSArray* files;
@property (nonatomic, retain) NSString* runOnlyForDeploymentPostprocessing;
@end

@interface XPPBXRezBuildPhase : XCObject {
    NSString* buildActionMask;
    NSArray* files;
    NSString* runOnlyForDeploymentPostprocessing;
}
@property (nonatomic, retain) NSString* buildActionMask;
// types in files: PBXBuildFile
@property (nonatomic, retain) NSArray* files;
@property (nonatomic, retain) NSString* runOnlyForDeploymentPostprocessing;
@end

@interface XPPBXShellScriptBuildPhase : XCObject {
    NSString* buildActionMask;
    NSArray* inputPaths;
    NSString* name;
    NSArray* outputPaths;
    NSString* runOnlyForDeploymentPostprocessing;
    NSString* shellPath;
    NSString* shellScript;
    NSString* showEnvVarsInLog;
}
@property (nonatomic, retain) NSString* buildActionMask;
// types in inputPaths: NSString
@property (nonatomic, retain) NSArray* inputPaths;
@property (nonatomic, retain) NSString* name;
// types in outputPaths: NSString
@property (nonatomic, retain) NSArray* outputPaths;
@property (nonatomic, retain) NSString* runOnlyForDeploymentPostprocessing;
@property (nonatomic, retain) NSString* shellPath;
@property (nonatomic, retain) NSString* shellScript;
@property (nonatomic, retain) NSString* showEnvVarsInLog;
@end

@interface XPPBXSourcesBuildPhase : XCObject {
    NSString* buildActionMask;
    NSArray* files;
    NSString* runOnlyForDeploymentPostprocessing;
}
@property (nonatomic, retain) NSString* buildActionMask;
// types in files: PBXBuildFile
@property (nonatomic, retain) NSArray* files;
@property (nonatomic, retain) NSString* runOnlyForDeploymentPostprocessing;
@end

@interface XPPBXTargetDependency : XCObject {
    NSString* name;
    XPPBXNativeTarget* target;
    XPPBXContainerItemProxy* targetProxy;
}
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) XPPBXNativeTarget* target;
@property (nonatomic, retain) XPPBXContainerItemProxy* targetProxy;
@end

@interface XPPBXVariantGroup : XCObject {
    NSArray* children;
    NSString* name;
    NSString* path;
    NSString* refType;
    NSString* sourceTree;
}
// types in children: PBXVariantGroup, PBXFileReference
@property (nonatomic, retain) NSArray* children;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* path;
@property (nonatomic, retain) NSString* refType;
@property (nonatomic, retain) NSString* sourceTree;
@end

@interface XPXCBuildConfiguration : XCObject {
    XPPBXFileReference* baseConfigurationReference;
    NSDictionary* buildSettings;
    NSString* name;
}
@property (nonatomic, retain) XPPBXFileReference* baseConfigurationReference;
@property (nonatomic, retain) NSDictionary* buildSettings;
@property (nonatomic, retain) NSString* name;
@end

@interface XPXCConfigurationList : XCObject {
    NSArray* buildConfigurations;
    NSString* defaultConfigurationIsVisible;
    NSString* defaultConfigurationName;
}
// types in buildConfigurations: XCBuildConfiguration
@property (nonatomic, retain) NSArray* buildConfigurations;
@property (nonatomic, retain) NSString* defaultConfigurationIsVisible;
@property (nonatomic, retain) NSString* defaultConfigurationName;
@end

@interface XPXCVersionGroup : XCObject {
    NSArray* children;
    XPPBXFileReference* currentVersion;
    NSString* path;
    NSString* sourceTree;
    NSString* versionGroupType;
}
// types in children: PBXFileReference
@property (nonatomic, retain) NSArray* children;
@property (nonatomic, retain) XPPBXFileReference* currentVersion;
@property (nonatomic, retain) NSString* path;
@property (nonatomic, retain) NSString* sourceTree;
@property (nonatomic, retain) NSString* versionGroupType;
@end

