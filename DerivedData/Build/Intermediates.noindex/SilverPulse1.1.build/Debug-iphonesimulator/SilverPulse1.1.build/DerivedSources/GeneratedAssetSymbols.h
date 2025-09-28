#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "emma" asset catalog image resource.
static NSString * const ACImageNameEmma AC_SWIFT_PRIVATE = @"emma";

/// The "james" asset catalog image resource.
static NSString * const ACImageNameJames AC_SWIFT_PRIVATE = @"james";

/// The "laura" asset catalog image resource.
static NSString * const ACImageNameLaura AC_SWIFT_PRIVATE = @"laura";

/// The "matt" asset catalog image resource.
static NSString * const ACImageNameMatt AC_SWIFT_PRIVATE = @"matt";

/// The "mood_lonely" asset catalog image resource.
static NSString * const ACImageNameMoodLonely AC_SWIFT_PRIVATE = @"mood_lonely";

/// The "mood_okay" asset catalog image resource.
static NSString * const ACImageNameMoodOkay AC_SWIFT_PRIVATE = @"mood_okay";

/// The "mood_tired" asset catalog image resource.
static NSString * const ACImageNameMoodTired AC_SWIFT_PRIVATE = @"mood_tired";

/// The "mood_worried" asset catalog image resource.
static NSString * const ACImageNameMoodWorried AC_SWIFT_PRIVATE = @"mood_worried";

#undef AC_SWIFT_PRIVATE
