#!/bin/bash

echo "🔧 Creating new Xcode project..."

# Create project directory structure
mkdir -p SilverPulse.xcodeproj

# Create project.pbxproj with all files properly included
cat > SilverPulse.xcodeproj/project.pbxproj << 'EOF'
// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 56;
	objects = {

/* Begin PBXBuildFile section */
		AA0000000000000001 /* SilverPulseApp.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000002 /* SilverPulseApp.swift */; };
		AA0000000000000003 /* ContentView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000004 /* ContentView.swift */; };
		AA0000000000000005 /* AppSession.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000006 /* AppSession.swift */; };
		AA0000000000000007 /* QuotaViewModel.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000008 /* QuotaViewModel.swift */; };
		AA0000000000000009 /* Mood.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000010 /* Mood.swift */; };
		AA0000000000000011 /* Coach.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000012 /* Coach.swift */; };
		AA0000000000000013 /* UserQuota.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000014 /* UserQuota.swift */; };
		AA0000000000000015 /* CallSession.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000016 /* CallSession.swift */; };
		AA0000000000000017 /* APIClient.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000018 /* APIClient.swift */; };
		AA0000000000000019 /* KeychainService.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000020 /* KeychainService.swift */; };
		AA0000000000000021 /* QuotaService.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000022 /* QuotaService.swift */; };
		AA0000000000000023 /* TimeSync.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000024 /* TimeSync.swift */; };
		AA0000000000000025 /* Analytics.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000026 /* Analytics.swift */; };
		AA0000000000000027 /* OnboardingFlowView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000028 /* OnboardingFlowView.swift */; };
		AA0000000000000029 /* MoodSelectionView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000030 /* MoodSelectionView.swift */; };
		AA0000000000000031 /* MoodConfirmationView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000032 /* MoodConfirmationView.swift */; };
		AA0000000000000033 /* CoachSelectionView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000034 /* CoachSelectionView.swift */; };
		AA0000000000000035 /* FinalConfirmationView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000036 /* FinalConfirmationView.swift */; };
		AA0000000000000037 /* LobbyView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000038 /* LobbyView.swift */; };
		AA0000000000000039 /* CoachWebView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000040 /* CoachWebView.swift */; };
		AA0000000000000041 /* Colors.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000042 /* Colors.swift */; };
		AA0000000000000043 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = AA0000000000000044 /* Assets.xcassets */; };
		AA0000000000000045 /* Preview Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = AA0000000000000046 /* Preview Assets.xcassets */; };
/* End PBXBuildFile section */

/* Begin PBXFileReference section */
		AA0000000000000000 /* SilverPulse.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = SilverPulse.app; sourceTree = BUILT_PRODUCTS_DIR; };
		AA0000000000000002 /* SilverPulseApp.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SilverPulseApp.swift; sourceTree = "<group>"; };
		AA0000000000000004 /* ContentView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ContentView.swift; sourceTree = "<group>"; };
		AA0000000000000006 /* AppSession.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppSession.swift; sourceTree = "<group>"; };
		AA0000000000000008 /* QuotaViewModel.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = QuotaViewModel.swift; sourceTree = "<group>"; };
		AA0000000000000010 /* Mood.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = Mood.swift; sourceTree = "<group>"; };
		AA0000000000000012 /* Coach.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = Coach.swift; sourceTree = "<group>"; };
		AA0000000000000014 /* UserQuota.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = UserQuota.swift; sourceTree = "<group>"; };
		AA0000000000000016 /* CallSession.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = CallSession.swift; sourceTree = "<group>"; };
		AA0000000000000018 /* APIClient.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = APIClient.swift; sourceTree = "<group>"; };
		AA0000000000000020 /* KeychainService.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = KeychainService.swift; sourceTree = "<group>"; };
		AA0000000000000022 /* QuotaService.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = QuotaService.swift; sourceTree = "<group>"; };
		AA0000000000000024 /* TimeSync.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = TimeSync.swift; sourceTree = "<group>"; };
		AA0000000000000026 /* Analytics.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = Analytics.swift; sourceTree = "<group>"; };
		AA0000000000000028 /* OnboardingFlowView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = OnboardingFlowView.swift; sourceTree = "<group>"; };
		AA0000000000000030 /* MoodSelectionView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = MoodSelectionView.swift; sourceTree = "<group>"; };
		AA0000000000000032 /* MoodConfirmationView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = MoodConfirmationView.swift; sourceTree = "<group>"; };
		AA0000000000000034 /* CoachSelectionView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = CoachSelectionView.swift; sourceTree = "<group>"; };
		AA0000000000000036 /* FinalConfirmationView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = FinalConfirmationView.swift; sourceTree = "<group>"; };
		AA0000000000000038 /* LobbyView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = LobbyView.swift; sourceTree = "<group>"; };
		AA0000000000000040 /* CoachWebView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = CoachWebView.swift; sourceTree = "<group>"; };
		AA0000000000000042 /* Colors.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = Colors.swift; sourceTree = "<group>"; };
		AA0000000000000044 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; };
		AA0000000000000046 /* Preview Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = "Preview Assets.xcassets"; sourceTree = "<group>"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		AA0000000000000047 /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		AA0000000000000048 = {
			isa = PBXGroup;
			children = (
				AA0000000000000049 /* SilverPulse */,
				AA0000000000000050 /* Products */,
			);
			sourceTree = "<group>";
		};
		AA0000000000000049 /* SilverPulse */ = {
			isa = PBXGroup;
			children = (
				AA0000000000000002 /* SilverPulseApp.swift */,
				AA0000000000000004 /* ContentView.swift */,
				AA0000000000000051 /* Models */,
				AA0000000000000052 /* Views */,
				AA0000000000000053 /* Services */,
				AA0000000000000054 /* AppState */,
				AA0000000000000055 /* ViewModels */,
				AA0000000000000044 /* Assets.xcassets */,
				AA0000000000000056 /* Preview Content */,
			);
			path = SilverPulse;
			sourceTree = "<group>";
		};
		AA0000000000000050 /* Products */ = {
			isa = PBXGroup;
			children = (
				AA0000000000000000 /* SilverPulse.app */,
			);
			name = Products;
			sourceTree = "<group>";
		};
		AA0000000000000051 /* Models */ = {
			isa = PBXGroup;
			children = (
				AA0000000000000010 /* Mood.swift */,
				AA0000000000000012 /* Coach.swift */,
				AA0000000000000014 /* UserQuota.swift */,
				AA0000000000000016 /* CallSession.swift */,
			);
			path = Models;
			sourceTree = "<group>";
		};
		AA0000000000000052 /* Views */ = {
			isa = PBXGroup;
			children = (
				AA0000000000000057 /* Onboarding */,
				AA0000000000000058 /* Lobby */,
				AA0000000000000059 /* Call */,
			);
			path = Views;
			sourceTree = "<group>";
		};
		AA0000000000000053 /* Services */ = {
			isa = PBXGroup;
			children = (
				AA0000000000000018 /* APIClient.swift */,
				AA0000000000000020 /* KeychainService.swift */,
				AA0000000000000022 /* QuotaService.swift */,
				AA0000000000000024 /* TimeSync.swift */,
				AA0000000000000026 /* Analytics.swift */,
			);
			path = Services;
			sourceTree = "<group>";
		};
		AA0000000000000054 /* AppState */ = {
			isa = PBXGroup;
			children = (
				AA0000000000000006 /* AppSession.swift */,
			);
			path = AppState;
			sourceTree = "<group>";
		};
		AA0000000000000055 /* ViewModels */ = {
			isa = PBXGroup;
			children = (
				AA0000000000000008 /* QuotaViewModel.swift */,
			);
			path = ViewModels;
			sourceTree = "<group>";
		};
		AA0000000000000056 /* Preview Content */ = {
			isa = PBXGroup;
			children = (
				AA0000000000000046 /* Preview Assets.xcassets */,
			);
			path = "Preview Content";
			sourceTree = "<group>";
		};
		AA0000000000000057 /* Onboarding */ = {
			isa = PBXGroup;
			children = (
				AA0000000000000028 /* OnboardingFlowView.swift */,
				AA0000000000000030 /* MoodSelectionView.swift */,
				AA0000000000000032 /* MoodConfirmationView.swift */,
				AA0000000000000034 /* CoachSelectionView.swift */,
				AA0000000000000036 /* FinalConfirmationView.swift */,
			);
			path = Onboarding;
			sourceTree = "<group>";
		};
		AA0000000000000058 /* Lobby */ = {
			isa = PBXGroup;
			children = (
				AA0000000000000038 /* LobbyView.swift */,
			);
			path = Lobby;
			sourceTree = "<group>";
		};
		AA0000000000000059 /* Call */ = {
			isa = PBXGroup;
			children = (
				AA0000000000000040 /* CoachWebView.swift */,
			);
			path = Call;
			sourceTree = "<group>";
		};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		AA0000000000000060 /* SilverPulse */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = AA0000000000000061 /* Build configuration list for PBXNativeTarget "SilverPulse" */;
			buildPhases = (
				AA0000000000000062 /* Sources */,
				AA0000000000000047 /* Frameworks */,
				AA0000000000000063 /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = SilverPulse;
			productName = SilverPulse;
			productReference = AA0000000000000000 /* SilverPulse.app */;
			productType = "com.apple.product-type.application";
		};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		AA0000000000000064 /* Project object */ = {
			isa = PBXProject;
			attributes = {
				BuildIndependentTargetsInParallel = 1;
				LastSwiftUpdateCheck = 1500;
				LastUpgradeCheck = 1500;
				TargetAttributes = {
					AA0000000000000060 = {
						CreatedOnToolsVersion = 15.0;
					};
				};
			};
			buildConfigurationList = AA0000000000000065 /* Build configuration list for PBXProject "SilverPulse" */;
			compatibilityVersion = "Xcode 14.0";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = AA0000000000000048;
			productRefGroup = AA0000000000000050 /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				AA0000000000000060 /* SilverPulse */,
			);
		};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		AA0000000000000063 /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				AA0000000000000045 /* Preview Assets.xcassets in Resources */,
				AA0000000000000043 /* Assets.xcassets in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		AA0000000000000062 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				AA0000000000000003 /* ContentView.swift in Sources */,
				AA0000000000000001 /* SilverPulseApp.swift in Sources */,
				AA0000000000000005 /* AppSession.swift in Sources */,
				AA0000000000000007 /* QuotaViewModel.swift in Sources */,
				AA0000000000000009 /* Mood.swift in Sources */,
				AA0000000000000011 /* Coach.swift in Sources */,
				AA0000000000000013 /* UserQuota.swift in Sources */,
				AA0000000000000015 /* CallSession.swift in Sources */,
				AA0000000000000017 /* APIClient.swift in Sources */,
				AA0000000000000019 /* KeychainService.swift in Sources */,
				AA0000000000000021 /* QuotaService.swift in Sources */,
				AA0000000000000023 /* TimeSync.swift in Sources */,
				AA0000000000000025 /* Analytics.swift in Sources */,
				AA0000000000000027 /* OnboardingFlowView.swift in Sources */,
				AA0000000000000029 /* MoodSelectionView.swift in Sources */,
				AA0000000000000031 /* MoodConfirmationView.swift in Sources */,
				AA0000000000000033 /* CoachSelectionView.swift in Sources */,
				AA0000000000000035 /* FinalConfirmationView.swift in Sources */,
				AA0000000000000037 /* LobbyView.swift in Sources */,
				AA0000000000000039 /* CoachWebView.swift in Sources */,
				AA0000000000000041 /* Colors.swift in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXSourcesBuildPhase section */

/* Begin XCBuildConfiguration section */
		AA0000000000000066 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_ENABLE_OBJC_WEAK = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = dwarf;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_TESTABILITY = YES;
				ENABLE_USER_SCRIPT_SANDBOXING = YES;
				GCC_C_LANGUAGE_STANDARD = gnu17;
				GCC_DYNAMIC_NO_PIC = NO;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_OPTIMIZATION_LEVEL = 0;
				GCC_PREPROCESSOR_DEFINITIONS = (
					"DEBUG=1",
					"$(inherited)",
				);
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				LOCALIZATION_PREFERS_STRING_CATALOGS = YES;
				MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
				MTL_FAST_MATH = YES;
				ONLY_ACTIVE_ARCH = YES;
				SDKROOT = iphoneos;
				SWIFT_ACTIVE_COMPILATION_CONDITIONS = "DEBUG $(inherited)";
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
			};
			name = Debug;
		};
		AA0000000000000067 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_ENABLE_OBJC_WEAK = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
				ENABLE_NS_ASSERTIONS = NO;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_USER_SCRIPT_SANDBOXING = YES;
				GCC_C_LANGUAGE_STANDARD = gnu17;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				LOCALIZATION_PREFERS_STRING_CATALOGS = YES;
				MTL_ENABLE_DEBUG_INFO = NO;
				MTL_FAST_MATH = YES;
				SDKROOT = iphoneos;
				SWIFT_COMPILATION_MODE = wholemodule;
				VALIDATE_PRODUCT = YES;
			};
			name = Release;
		};
		AA0000000000000068 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				DEVELOPMENT_ASSET_PATHS = "\"SilverPulse/Preview Content\"";
				ENABLE_PREVIEWS = YES;
				GENERATE_INFOPLIST_FILE = YES;
				INFOPLIST_KEY_NSMicrophoneUsageDescription = "This app needs microphone access for coach calls.";
				INFOPLIST_KEY_UIApplicationSceneManifest_Generation = YES;
				INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
				INFOPLIST_KEY_UILaunchScreen_Generation = YES;
				INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
				INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone = "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.silverpulse.app;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_EMIT_LOC_STRINGS = YES;
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Debug;
		};
		AA0000000000000069 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				DEVELOPMENT_ASSET_PATHS = "\"SilverPulse/Preview Content\"";
				ENABLE_PREVIEWS = YES;
				GENERATE_INFOPLIST_FILE = YES;
				INFOPLIST_KEY_NSMicrophoneUsageDescription = "This app needs microphone access for coach calls.";
				INFOPLIST_KEY_UIApplicationSceneManifest_Generation = YES;
				INFOPLIST_KEY_UIApplicationSceneManifest_Generation = YES;
				INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
				INFOPLIST_KEY_UILaunchScreen_Generation = YES;
				INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
				INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone = "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.silverpulse.app;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_EMIT_LOC_STRINGS = YES;
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Release;
		};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		AA0000000000000061 /* Build configuration list for PBXNativeTarget "SilverPulse" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				AA0000000000000068 /* Debug */,
				AA0000000000000069 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		AA0000000000000065 /* Build configuration list for PBXProject "SilverPulse" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				AA0000000000000066 /* Debug */,
				AA0000000000000067 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */
	};
	rootObject = AA0000000000000064 /* Project object */;
}
EOF

echo "✅ New Xcode project created!"
echo "🚀 Now you can open SilverPulse.xcodeproj in Xcode"

