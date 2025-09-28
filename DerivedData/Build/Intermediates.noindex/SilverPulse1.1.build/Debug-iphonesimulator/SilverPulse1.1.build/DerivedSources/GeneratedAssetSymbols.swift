import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ColorResource {

}

// MARK: - Image Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ImageResource {

    /// The "emma" asset catalog image resource.
    static let emma = DeveloperToolsSupport.ImageResource(name: "emma", bundle: resourceBundle)

    /// The "james" asset catalog image resource.
    static let james = DeveloperToolsSupport.ImageResource(name: "james", bundle: resourceBundle)

    /// The "laura" asset catalog image resource.
    static let laura = DeveloperToolsSupport.ImageResource(name: "laura", bundle: resourceBundle)

    /// The "matt" asset catalog image resource.
    static let matt = DeveloperToolsSupport.ImageResource(name: "matt", bundle: resourceBundle)

    /// The "mood_lonely" asset catalog image resource.
    static let moodLonely = DeveloperToolsSupport.ImageResource(name: "mood_lonely", bundle: resourceBundle)

    /// The "mood_okay" asset catalog image resource.
    static let moodOkay = DeveloperToolsSupport.ImageResource(name: "mood_okay", bundle: resourceBundle)

    /// The "mood_tired" asset catalog image resource.
    static let moodTired = DeveloperToolsSupport.ImageResource(name: "mood_tired", bundle: resourceBundle)

    /// The "mood_worried" asset catalog image resource.
    static let moodWorried = DeveloperToolsSupport.ImageResource(name: "mood_worried", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "emma" asset catalog image.
    static var emma: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .emma)
#else
        .init()
#endif
    }

    /// The "james" asset catalog image.
    static var james: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .james)
#else
        .init()
#endif
    }

    /// The "laura" asset catalog image.
    static var laura: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .laura)
#else
        .init()
#endif
    }

    /// The "matt" asset catalog image.
    static var matt: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .matt)
#else
        .init()
#endif
    }

    /// The "mood_lonely" asset catalog image.
    static var moodLonely: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .moodLonely)
#else
        .init()
#endif
    }

    /// The "mood_okay" asset catalog image.
    static var moodOkay: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .moodOkay)
#else
        .init()
#endif
    }

    /// The "mood_tired" asset catalog image.
    static var moodTired: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .moodTired)
#else
        .init()
#endif
    }

    /// The "mood_worried" asset catalog image.
    static var moodWorried: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .moodWorried)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "emma" asset catalog image.
    static var emma: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .emma)
#else
        .init()
#endif
    }

    /// The "james" asset catalog image.
    static var james: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .james)
#else
        .init()
#endif
    }

    /// The "laura" asset catalog image.
    static var laura: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .laura)
#else
        .init()
#endif
    }

    /// The "matt" asset catalog image.
    static var matt: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .matt)
#else
        .init()
#endif
    }

    /// The "mood_lonely" asset catalog image.
    static var moodLonely: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .moodLonely)
#else
        .init()
#endif
    }

    /// The "mood_okay" asset catalog image.
    static var moodOkay: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .moodOkay)
#else
        .init()
#endif
    }

    /// The "mood_tired" asset catalog image.
    static var moodTired: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .moodTired)
#else
        .init()
#endif
    }

    /// The "mood_worried" asset catalog image.
    static var moodWorried: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .moodWorried)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

