import UIComponents

final class UIComponentsFramework {
    
    static func setup() {
        UIComponents.Dependencies.analyticsTrackingProvider = AnalyticsTrackingProvider()
    }
}
