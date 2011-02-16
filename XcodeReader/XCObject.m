//
//  XCObject.m
//  XcodeProj
//
//  Created by David Brown on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XCObject.h"


@implementation XCObject
@synthesize xcodeObjectType;

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

- (void)inflateFromDictionary:(NSDictionary*)dict {
}

- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
}

+ (XCObject*)XCObjectFromDictionary:(NSDictionary*)dict {
    NSString* objIsa = [dict objectForKey:@"isa"];
    XCObject* xcobj = [[[NSClassFromString([NSString stringWithFormat:@"XP%@", objIsa]) alloc] init] autorelease];
    xcobj.xcodeObjectType = objIsa;
    [xcobj inflateFromDictionary:dict];
    return xcobj;
}

@end

@implementation XPPBXAggregateTarget
@synthesize buildConfigurationList;
@synthesize buildPhases;
@synthesize dependencies;
@synthesize name;
@synthesize productName;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.name = [dict objectForKey:@"name"];
    self.productName = [dict objectForKey:@"productName"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    self.buildConfigurationList = [store objectForKey:[dict objectForKey:@"buildConfigurationList"]];
    NSMutableArray* buildPhasesArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"buildPhases"]) {
        [buildPhasesArray addObject:[store objectForKey:objectName]];
    }
    self.buildPhases = buildPhasesArray;
    NSMutableArray* dependenciesArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"dependencies"]) {
        [dependenciesArray addObject:[store objectForKey:objectName]];
    }
    self.dependencies = dependenciesArray;
}
- (void)dealloc {
    [buildConfigurationList release], buildConfigurationList = nil;
    [buildPhases release], buildPhases = nil;
    [dependencies release], dependencies = nil;
    [name release], name = nil;
    [productName release], productName = nil;
    [super dealloc];
}
@end

@implementation XPPBXAppleScriptBuildPhase
@synthesize buildActionMask;
@synthesize contextName;
@synthesize files;
@synthesize isSharedContext;
@synthesize runOnlyForDeploymentPostprocessing;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.buildActionMask = [dict objectForKey:@"buildActionMask"];
    self.contextName = [dict objectForKey:@"contextName"];
    self.isSharedContext = [dict objectForKey:@"isSharedContext"];
    self.runOnlyForDeploymentPostprocessing = [dict objectForKey:@"runOnlyForDeploymentPostprocessing"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    NSMutableArray* filesArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"files"]) {
        [filesArray addObject:[store objectForKey:objectName]];
    }
    self.files = filesArray;
}
- (void)dealloc {
    [buildActionMask release], buildActionMask = nil;
    [contextName release], contextName = nil;
    [files release], files = nil;
    [isSharedContext release], isSharedContext = nil;
    [runOnlyForDeploymentPostprocessing release], runOnlyForDeploymentPostprocessing = nil;
    [super dealloc];
}
@end

@implementation XPPBXApplicationReference
@synthesize path;
@synthesize refType;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.path = [dict objectForKey:@"path"];
    self.refType = [dict objectForKey:@"refType"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
}
- (void)dealloc {
    [path release], path = nil;
    [refType release], refType = nil;
    [super dealloc];
}
@end

@implementation XPPBXApplicationTarget
@synthesize buildConfigurationList;
@synthesize buildPhases;
@synthesize buildSettings;
@synthesize name;
@synthesize productInstallPath;
@synthesize productName;
@synthesize productReference;
@synthesize productSettingsXML;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.buildSettings = [dict objectForKey:@"buildSettings"];
    self.name = [dict objectForKey:@"name"];
    self.productInstallPath = [dict objectForKey:@"productInstallPath"];
    self.productName = [dict objectForKey:@"productName"];
    self.productSettingsXML = [dict objectForKey:@"productSettingsXML"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    self.buildConfigurationList = [store objectForKey:[dict objectForKey:@"buildConfigurationList"]];
    NSMutableArray* buildPhasesArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"buildPhases"]) {
        [buildPhasesArray addObject:[store objectForKey:objectName]];
    }
    self.buildPhases = buildPhasesArray;
    self.productReference = [store objectForKey:[dict objectForKey:@"productReference"]];
}
- (void)dealloc {
    [buildConfigurationList release], buildConfigurationList = nil;
    [buildPhases release], buildPhases = nil;
    [buildSettings release], buildSettings = nil;
    [name release], name = nil;
    [productInstallPath release], productInstallPath = nil;
    [productName release], productName = nil;
    [productReference release], productReference = nil;
    [productSettingsXML release], productSettingsXML = nil;
    [super dealloc];
}
@end

@implementation XPPBXBuildFile
@synthesize fileRef;
@synthesize settings;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.settings = [dict objectForKey:@"settings"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    self.fileRef = [store objectForKey:[dict objectForKey:@"fileRef"]];
}
- (void)dealloc {
    [fileRef release], fileRef = nil;
    [settings release], settings = nil;
    [super dealloc];
}
@end

@implementation XPPBXBuildRule
@synthesize compilerSpec;
@synthesize filePatterns;
@synthesize fileType;
@synthesize isEditable;
@synthesize outputFiles;
@synthesize script;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.compilerSpec = [dict objectForKey:@"compilerSpec"];
    self.filePatterns = [dict objectForKey:@"filePatterns"];
    self.fileType = [dict objectForKey:@"fileType"];
    self.isEditable = [dict objectForKey:@"isEditable"];
    self.script = [dict objectForKey:@"script"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    NSMutableArray* outputFilesArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"outputFiles"]) {
        [outputFilesArray addObject:objectName];
    }
    self.outputFiles = outputFilesArray;
}
- (void)dealloc {
    [compilerSpec release], compilerSpec = nil;
    [filePatterns release], filePatterns = nil;
    [fileType release], fileType = nil;
    [isEditable release], isEditable = nil;
    [outputFiles release], outputFiles = nil;
    [script release], script = nil;
    [super dealloc];
}
@end

@implementation XPPBXBuildStyle
@synthesize buildSettings;
@synthesize name;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.buildSettings = [dict objectForKey:@"buildSettings"];
    self.name = [dict objectForKey:@"name"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
}
- (void)dealloc {
    [buildSettings release], buildSettings = nil;
    [name release], name = nil;
    [super dealloc];
}
@end

@implementation XPPBXContainerItemProxy
@synthesize containerPortal;
@synthesize proxyType;
@synthesize remoteGlobalIDString;
@synthesize remoteInfo;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.proxyType = [dict objectForKey:@"proxyType"];
    self.remoteInfo = [dict objectForKey:@"remoteInfo"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    self.containerPortal = [store objectForKey:[dict objectForKey:@"containerPortal"]];
    self.remoteGlobalIDString = [store objectForKey:[dict objectForKey:@"remoteGlobalIDString"]];
}
- (void)dealloc {
    [containerPortal release], containerPortal = nil;
    [proxyType release], proxyType = nil;
    [remoteGlobalIDString release], remoteGlobalIDString = nil;
    [remoteInfo release], remoteInfo = nil;
    [super dealloc];
}
@end

@implementation XPPBXCopyFilesBuildPhase
@synthesize buildActionMask;
@synthesize dstPath;
@synthesize dstSubfolderSpec;
@synthesize files;
@synthesize name;
@synthesize runOnlyForDeploymentPostprocessing;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.buildActionMask = [dict objectForKey:@"buildActionMask"];
    self.dstPath = [dict objectForKey:@"dstPath"];
    self.dstSubfolderSpec = [dict objectForKey:@"dstSubfolderSpec"];
    self.name = [dict objectForKey:@"name"];
    self.runOnlyForDeploymentPostprocessing = [dict objectForKey:@"runOnlyForDeploymentPostprocessing"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    NSMutableArray* filesArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"files"]) {
        [filesArray addObject:[store objectForKey:objectName]];
    }
    self.files = filesArray;
}
- (void)dealloc {
    [buildActionMask release], buildActionMask = nil;
    [dstPath release], dstPath = nil;
    [dstSubfolderSpec release], dstSubfolderSpec = nil;
    [files release], files = nil;
    [name release], name = nil;
    [runOnlyForDeploymentPostprocessing release], runOnlyForDeploymentPostprocessing = nil;
    [super dealloc];
}
@end

@implementation XPPBXFileReference
@synthesize explicitFileType;
@synthesize fileEncoding;
@synthesize includeInIndex;
@synthesize indentWidth;
@synthesize languageSpecificationIdentifier;
@synthesize lastKnownFileType;
@synthesize lineEnding;
@synthesize name;
@synthesize path;
@synthesize plistStructureDefinitionIdentifier;
@synthesize refType;
@synthesize sourceTree;
@synthesize tabWidth;
@synthesize usesTabs;
@synthesize wrapsLines;
@synthesize xcLanguageSpecificationIdentifier;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.explicitFileType = [dict objectForKey:@"explicitFileType"];
    self.fileEncoding = [dict objectForKey:@"fileEncoding"];
    self.includeInIndex = [dict objectForKey:@"includeInIndex"];
    self.indentWidth = [dict objectForKey:@"indentWidth"];
    self.languageSpecificationIdentifier = [dict objectForKey:@"languageSpecificationIdentifier"];
    self.lastKnownFileType = [dict objectForKey:@"lastKnownFileType"];
    self.lineEnding = [dict objectForKey:@"lineEnding"];
    self.name = [dict objectForKey:@"name"];
    self.path = [dict objectForKey:@"path"];
    self.plistStructureDefinitionIdentifier = [dict objectForKey:@"plistStructureDefinitionIdentifier"];
    self.refType = [dict objectForKey:@"refType"];
    self.sourceTree = [dict objectForKey:@"sourceTree"];
    self.tabWidth = [dict objectForKey:@"tabWidth"];
    self.usesTabs = [dict objectForKey:@"usesTabs"];
    self.wrapsLines = [dict objectForKey:@"wrapsLines"];
    self.xcLanguageSpecificationIdentifier = [dict objectForKey:@"xcLanguageSpecificationIdentifier"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
}
- (void)dealloc {
    [explicitFileType release], explicitFileType = nil;
    [fileEncoding release], fileEncoding = nil;
    [includeInIndex release], includeInIndex = nil;
    [indentWidth release], indentWidth = nil;
    [languageSpecificationIdentifier release], languageSpecificationIdentifier = nil;
    [lastKnownFileType release], lastKnownFileType = nil;
    [lineEnding release], lineEnding = nil;
    [name release], name = nil;
    [path release], path = nil;
    [plistStructureDefinitionIdentifier release], plistStructureDefinitionIdentifier = nil;
    [refType release], refType = nil;
    [sourceTree release], sourceTree = nil;
    [tabWidth release], tabWidth = nil;
    [usesTabs release], usesTabs = nil;
    [wrapsLines release], wrapsLines = nil;
    [xcLanguageSpecificationIdentifier release], xcLanguageSpecificationIdentifier = nil;
    [super dealloc];
}
@end

@implementation XPPBXFrameworkReference
@synthesize name;
@synthesize path;
@synthesize refType;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.name = [dict objectForKey:@"name"];
    self.path = [dict objectForKey:@"path"];
    self.refType = [dict objectForKey:@"refType"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
}
- (void)dealloc {
    [name release], name = nil;
    [path release], path = nil;
    [refType release], refType = nil;
    [super dealloc];
}
@end

@implementation XPPBXFrameworksBuildPhase
@synthesize buildActionMask;
@synthesize files;
@synthesize runOnlyForDeploymentPostprocessing;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.buildActionMask = [dict objectForKey:@"buildActionMask"];
    self.runOnlyForDeploymentPostprocessing = [dict objectForKey:@"runOnlyForDeploymentPostprocessing"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    NSMutableArray* filesArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"files"]) {
        [filesArray addObject:[store objectForKey:objectName]];
    }
    self.files = filesArray;
}
- (void)dealloc {
    [buildActionMask release], buildActionMask = nil;
    [files release], files = nil;
    [runOnlyForDeploymentPostprocessing release], runOnlyForDeploymentPostprocessing = nil;
    [super dealloc];
}
@end

@implementation XPPBXGroup
@synthesize children;
@synthesize name;
@synthesize path;
@synthesize refType;
@synthesize sourceTree;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.name = [dict objectForKey:@"name"];
    self.path = [dict objectForKey:@"path"];
    self.refType = [dict objectForKey:@"refType"];
    self.sourceTree = [dict objectForKey:@"sourceTree"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    NSMutableArray* childrenArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"children"]) {
        [childrenArray addObject:[store objectForKey:objectName]];
    }
    self.children = childrenArray;
}
- (void)dealloc {
    [children release], children = nil;
    [name release], name = nil;
    [path release], path = nil;
    [refType release], refType = nil;
    [sourceTree release], sourceTree = nil;
    [super dealloc];
}
@end

@implementation XPPBXHeadersBuildPhase
@synthesize buildActionMask;
@synthesize files;
@synthesize runOnlyForDeploymentPostprocessing;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.buildActionMask = [dict objectForKey:@"buildActionMask"];
    self.runOnlyForDeploymentPostprocessing = [dict objectForKey:@"runOnlyForDeploymentPostprocessing"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    NSMutableArray* filesArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"files"]) {
        [filesArray addObject:[store objectForKey:objectName]];
    }
    self.files = filesArray;
}
- (void)dealloc {
    [buildActionMask release], buildActionMask = nil;
    [files release], files = nil;
    [runOnlyForDeploymentPostprocessing release], runOnlyForDeploymentPostprocessing = nil;
    [super dealloc];
}
@end

@implementation XPPBXLegacyTarget
@synthesize buildArgumentsString;
@synthesize buildConfigurationList;
@synthesize buildToolPath;
@synthesize buildWorkingDirectory;
@synthesize name;
@synthesize passBuildSettingsInEnvironment;
@synthesize productName;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.buildArgumentsString = [dict objectForKey:@"buildArgumentsString"];
    self.buildToolPath = [dict objectForKey:@"buildToolPath"];
    self.buildWorkingDirectory = [dict objectForKey:@"buildWorkingDirectory"];
    self.name = [dict objectForKey:@"name"];
    self.passBuildSettingsInEnvironment = [dict objectForKey:@"passBuildSettingsInEnvironment"];
    self.productName = [dict objectForKey:@"productName"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    self.buildConfigurationList = [store objectForKey:[dict objectForKey:@"buildConfigurationList"]];
}
- (void)dealloc {
    [buildArgumentsString release], buildArgumentsString = nil;
    [buildConfigurationList release], buildConfigurationList = nil;
    [buildToolPath release], buildToolPath = nil;
    [buildWorkingDirectory release], buildWorkingDirectory = nil;
    [name release], name = nil;
    [passBuildSettingsInEnvironment release], passBuildSettingsInEnvironment = nil;
    [productName release], productName = nil;
    [super dealloc];
}
@end

@implementation XPPBXNativeTarget
@synthesize buildConfigurationList;
@synthesize buildPhases;
@synthesize buildRules;
@synthesize buildSettings;
@synthesize dependencies;
@synthesize name;
@synthesize productInstallPath;
@synthesize productName;
@synthesize productReference;
@synthesize productType;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.buildSettings = [dict objectForKey:@"buildSettings"];
    self.name = [dict objectForKey:@"name"];
    self.productInstallPath = [dict objectForKey:@"productInstallPath"];
    self.productName = [dict objectForKey:@"productName"];
    self.productType = [dict objectForKey:@"productType"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    self.buildConfigurationList = [store objectForKey:[dict objectForKey:@"buildConfigurationList"]];
    NSMutableArray* buildPhasesArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"buildPhases"]) {
        [buildPhasesArray addObject:[store objectForKey:objectName]];
    }
    self.buildPhases = buildPhasesArray;
    NSMutableArray* buildRulesArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"buildRules"]) {
        [buildRulesArray addObject:[store objectForKey:objectName]];
    }
    self.buildRules = buildRulesArray;
    NSMutableArray* dependenciesArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"dependencies"]) {
        [dependenciesArray addObject:[store objectForKey:objectName]];
    }
    self.dependencies = dependenciesArray;
    self.productReference = [store objectForKey:[dict objectForKey:@"productReference"]];
}
- (void)dealloc {
    [buildConfigurationList release], buildConfigurationList = nil;
    [buildPhases release], buildPhases = nil;
    [buildRules release], buildRules = nil;
    [buildSettings release], buildSettings = nil;
    [dependencies release], dependencies = nil;
    [name release], name = nil;
    [productInstallPath release], productInstallPath = nil;
    [productName release], productName = nil;
    [productReference release], productReference = nil;
    [productType release], productType = nil;
    [super dealloc];
}
@end

@implementation XPPBXProject
@synthesize attributes;
@synthesize buildConfigurationList;
@synthesize buildSettings;
@synthesize buildStyles;
@synthesize compatibilityVersion;
@synthesize developmentRegion;
@synthesize hasScannedForEncodings;
@synthesize knownRegions;
@synthesize mainGroup;
@synthesize productRefGroup;
@synthesize projectDirPath;
@synthesize projectReferences;
@synthesize projectRoot;
@synthesize shouldCheckCompatibility;
@synthesize targets;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.attributes = [dict objectForKey:@"attributes"];
    self.buildSettings = [dict objectForKey:@"buildSettings"];
    self.compatibilityVersion = [dict objectForKey:@"compatibilityVersion"];
    self.developmentRegion = [dict objectForKey:@"developmentRegion"];
    self.hasScannedForEncodings = [dict objectForKey:@"hasScannedForEncodings"];
    self.projectDirPath = [dict objectForKey:@"projectDirPath"];
    self.projectRoot = [dict objectForKey:@"projectRoot"];
    self.shouldCheckCompatibility = [dict objectForKey:@"shouldCheckCompatibility"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    self.buildConfigurationList = [store objectForKey:[dict objectForKey:@"buildConfigurationList"]];
    NSMutableArray* buildStylesArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"buildStyles"]) {
        [buildStylesArray addObject:[store objectForKey:objectName]];
    }
    self.buildStyles = buildStylesArray;
    NSMutableArray* knownRegionsArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"knownRegions"]) {
        [knownRegionsArray addObject:objectName];
    }
    self.knownRegions = knownRegionsArray;
    self.mainGroup = [store objectForKey:[dict objectForKey:@"mainGroup"]];
    self.productRefGroup = [store objectForKey:[dict objectForKey:@"productRefGroup"]];
    NSMutableArray* projectReferencesArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"projectReferences"]) {
        [projectReferencesArray addObject:objectName];
    }
    self.projectReferences = projectReferencesArray;
    NSMutableArray* targetsArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"targets"]) {
        [targetsArray addObject:[store objectForKey:objectName]];
    }
    self.targets = targetsArray;
}
- (void)dealloc {
    [attributes release], attributes = nil;
    [buildConfigurationList release], buildConfigurationList = nil;
    [buildSettings release], buildSettings = nil;
    [buildStyles release], buildStyles = nil;
    [compatibilityVersion release], compatibilityVersion = nil;
    [developmentRegion release], developmentRegion = nil;
    [hasScannedForEncodings release], hasScannedForEncodings = nil;
    [knownRegions release], knownRegions = nil;
    [mainGroup release], mainGroup = nil;
    [productRefGroup release], productRefGroup = nil;
    [projectDirPath release], projectDirPath = nil;
    [projectReferences release], projectReferences = nil;
    [projectRoot release], projectRoot = nil;
    [shouldCheckCompatibility release], shouldCheckCompatibility = nil;
    [targets release], targets = nil;
    [super dealloc];
}
@end

@implementation XPPBXReferenceProxy
@synthesize fileType;
@synthesize name;
@synthesize path;
@synthesize remoteRef;
@synthesize sourceTree;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.fileType = [dict objectForKey:@"fileType"];
    self.name = [dict objectForKey:@"name"];
    self.path = [dict objectForKey:@"path"];
    self.sourceTree = [dict objectForKey:@"sourceTree"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    self.remoteRef = [store objectForKey:[dict objectForKey:@"remoteRef"]];
}
- (void)dealloc {
    [fileType release], fileType = nil;
    [name release], name = nil;
    [path release], path = nil;
    [remoteRef release], remoteRef = nil;
    [sourceTree release], sourceTree = nil;
    [super dealloc];
}
@end

@implementation XPPBXResourcesBuildPhase
@synthesize buildActionMask;
@synthesize files;
@synthesize runOnlyForDeploymentPostprocessing;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.buildActionMask = [dict objectForKey:@"buildActionMask"];
    self.runOnlyForDeploymentPostprocessing = [dict objectForKey:@"runOnlyForDeploymentPostprocessing"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    NSMutableArray* filesArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"files"]) {
        [filesArray addObject:[store objectForKey:objectName]];
    }
    self.files = filesArray;
}
- (void)dealloc {
    [buildActionMask release], buildActionMask = nil;
    [files release], files = nil;
    [runOnlyForDeploymentPostprocessing release], runOnlyForDeploymentPostprocessing = nil;
    [super dealloc];
}
@end

@implementation XPPBXRezBuildPhase
@synthesize buildActionMask;
@synthesize files;
@synthesize runOnlyForDeploymentPostprocessing;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.buildActionMask = [dict objectForKey:@"buildActionMask"];
    self.runOnlyForDeploymentPostprocessing = [dict objectForKey:@"runOnlyForDeploymentPostprocessing"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    NSMutableArray* filesArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"files"]) {
        [filesArray addObject:[store objectForKey:objectName]];
    }
    self.files = filesArray;
}
- (void)dealloc {
    [buildActionMask release], buildActionMask = nil;
    [files release], files = nil;
    [runOnlyForDeploymentPostprocessing release], runOnlyForDeploymentPostprocessing = nil;
    [super dealloc];
}
@end

@implementation XPPBXShellScriptBuildPhase
@synthesize buildActionMask;
@synthesize inputPaths;
@synthesize name;
@synthesize outputPaths;
@synthesize runOnlyForDeploymentPostprocessing;
@synthesize shellPath;
@synthesize shellScript;
@synthesize showEnvVarsInLog;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.buildActionMask = [dict objectForKey:@"buildActionMask"];
    self.name = [dict objectForKey:@"name"];
    self.runOnlyForDeploymentPostprocessing = [dict objectForKey:@"runOnlyForDeploymentPostprocessing"];
    self.shellPath = [dict objectForKey:@"shellPath"];
    self.shellScript = [dict objectForKey:@"shellScript"];
    self.showEnvVarsInLog = [dict objectForKey:@"showEnvVarsInLog"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    NSMutableArray* inputPathsArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"inputPaths"]) {
        [inputPathsArray addObject:objectName];
    }
    self.inputPaths = inputPathsArray;
    NSMutableArray* outputPathsArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"outputPaths"]) {
        [outputPathsArray addObject:objectName];
    }
    self.outputPaths = outputPathsArray;
}
- (void)dealloc {
    [buildActionMask release], buildActionMask = nil;
    [inputPaths release], inputPaths = nil;
    [name release], name = nil;
    [outputPaths release], outputPaths = nil;
    [runOnlyForDeploymentPostprocessing release], runOnlyForDeploymentPostprocessing = nil;
    [shellPath release], shellPath = nil;
    [shellScript release], shellScript = nil;
    [showEnvVarsInLog release], showEnvVarsInLog = nil;
    [super dealloc];
}
@end

@implementation XPPBXSourcesBuildPhase
@synthesize buildActionMask;
@synthesize files;
@synthesize runOnlyForDeploymentPostprocessing;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.buildActionMask = [dict objectForKey:@"buildActionMask"];
    self.runOnlyForDeploymentPostprocessing = [dict objectForKey:@"runOnlyForDeploymentPostprocessing"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    NSMutableArray* filesArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"files"]) {
        [filesArray addObject:[store objectForKey:objectName]];
    }
    self.files = filesArray;
}
- (void)dealloc {
    [buildActionMask release], buildActionMask = nil;
    [files release], files = nil;
    [runOnlyForDeploymentPostprocessing release], runOnlyForDeploymentPostprocessing = nil;
    [super dealloc];
}
@end

@implementation XPPBXTargetDependency
@synthesize name;
@synthesize target;
@synthesize targetProxy;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.name = [dict objectForKey:@"name"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    self.target = [store objectForKey:[dict objectForKey:@"target"]];
    self.targetProxy = [store objectForKey:[dict objectForKey:@"targetProxy"]];
}
- (void)dealloc {
    [name release], name = nil;
    [target release], target = nil;
    [targetProxy release], targetProxy = nil;
    [super dealloc];
}
@end

@implementation XPPBXVariantGroup
@synthesize children;
@synthesize name;
@synthesize path;
@synthesize refType;
@synthesize sourceTree;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.name = [dict objectForKey:@"name"];
    self.path = [dict objectForKey:@"path"];
    self.refType = [dict objectForKey:@"refType"];
    self.sourceTree = [dict objectForKey:@"sourceTree"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    NSMutableArray* childrenArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"children"]) {
        [childrenArray addObject:[store objectForKey:objectName]];
    }
    self.children = childrenArray;
}
- (void)dealloc {
    [children release], children = nil;
    [name release], name = nil;
    [path release], path = nil;
    [refType release], refType = nil;
    [sourceTree release], sourceTree = nil;
    [super dealloc];
}
@end

@implementation XPXCBuildConfiguration
@synthesize baseConfigurationReference;
@synthesize buildSettings;
@synthesize name;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.buildSettings = [dict objectForKey:@"buildSettings"];
    self.name = [dict objectForKey:@"name"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    self.baseConfigurationReference = [store objectForKey:[dict objectForKey:@"baseConfigurationReference"]];
}
- (void)dealloc {
    [baseConfigurationReference release], baseConfigurationReference = nil;
    [buildSettings release], buildSettings = nil;
    [name release], name = nil;
    [super dealloc];
}
@end

@implementation XPXCConfigurationList
@synthesize buildConfigurations;
@synthesize defaultConfigurationIsVisible;
@synthesize defaultConfigurationName;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.defaultConfigurationIsVisible = [dict objectForKey:@"defaultConfigurationIsVisible"];
    self.defaultConfigurationName = [dict objectForKey:@"defaultConfigurationName"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    NSMutableArray* buildConfigurationsArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"buildConfigurations"]) {
        [buildConfigurationsArray addObject:[store objectForKey:objectName]];
    }
    self.buildConfigurations = buildConfigurationsArray;
}
- (void)dealloc {
    [buildConfigurations release], buildConfigurations = nil;
    [defaultConfigurationIsVisible release], defaultConfigurationIsVisible = nil;
    [defaultConfigurationName release], defaultConfigurationName = nil;
    [super dealloc];
}
@end

@implementation XPXCVersionGroup
@synthesize children;
@synthesize currentVersion;
@synthesize path;
@synthesize sourceTree;
@synthesize versionGroupType;
- (void)inflateFromDictionary:(NSDictionary*)dict {
    self.path = [dict objectForKey:@"path"];
    self.sourceTree = [dict objectForKey:@"sourceTree"];
    self.versionGroupType = [dict objectForKey:@"versionGroupType"];
}
- (void)connectFromDictionary:(NSDictionary*)dict usingObjectStore:(NSDictionary*)store {
    NSMutableArray* childrenArray = [NSMutableArray array];
    for (id objectName in [dict objectForKey:@"children"]) {
        [childrenArray addObject:[store objectForKey:objectName]];
    }
    self.children = childrenArray;
    self.currentVersion = [store objectForKey:[dict objectForKey:@"currentVersion"]];
}
- (void)dealloc {
    [children release], children = nil;
    [currentVersion release], currentVersion = nil;
    [path release], path = nil;
    [sourceTree release], sourceTree = nil;
    [versionGroupType release], versionGroupType = nil;
    [super dealloc];
}
@end

