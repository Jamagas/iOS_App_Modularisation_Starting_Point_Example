import Core
import UIComponents
// import SomeAnalyticsTracker

final class AnalyticsTrackingProvider {}

extension AnalyticsTrackingProvider: Core.AnalyticsTracking {
    
    // let someAnalyticsTracker = SomeAnalyticsTracker()
    
    func track(event: String, properties: [String: Core.AnalyticsPropertyValue]) {
        // TODO: Implement concrete analytics tracker
        let bridgedProperties = bridgedProperties(properties)
        // someAnalyticsTracker.trackEvent(event, properties: bridgedProperties)
    }
    
    func track(_ event: Core.AnalyticsEvent) {
        // TODO: Implement concrete analytics tracker
        let bridgedProperties = bridgedProperties(event.properties)
        // someAnalyticsTracker.trackEvent(event.name, properties: bridgedProperties)
    }
    
    func setOnce(properties: [String: Core.AnalyticsPropertyValue]) {
        // TODO: Implement concrete analytics tracker
    }
    
    func set(properties: [String: Core.AnalyticsPropertyValue]) {
        // TODO: Implement concrete analytics tracker
    }
    
    func increment(properties: [String: Core.AnalyticsPropertyValue]) {
        // TODO: Implement concrete analytics tracker
    }
    
    /// Bridging abstracted properties to specific for analytics tracker which is used. As an example [String: String] dictionary is used
    private func bridgedProperties(_ properties: [String: Core.AnalyticsPropertyValue]) -> [String: String] {
        var bridgedProperties: [String: String] = [:]
        for (key, propertyValue) in properties {
            switch propertyValue {
            case let .string(value):
                bridgedProperties[key] = value
            case let .strings(value):
                bridgedProperties[key] = String(describing: value)
            case let .int(value):
                bridgedProperties[key] = String(describing: value)
            case let .date(value):
                bridgedProperties[key] = String(describing: value)
            }
        }
        return bridgedProperties
    }
}

extension AnalyticsTrackingProvider: UIComponents.AnalyticsTracking {
    
    // let someAnalyticsTracker = SomeAnalyticsTracker()
    
    func track(event: String, properties: [String: UIComponents.AnalyticsPropertyValue]) {
        // TODO: Implement concrete analytics tracker
        let bridgedProperties = bridgedProperties(properties)
        // someAnalyticsTracker.trackEvent(event, properties: bridgedProperties)
    }
    
    func track(_ event: UIComponents.AnalyticsEvent) {
        // TODO: Implement concrete analytics tracker
        let bridgedProperties = bridgedProperties(event.properties)
        // someAnalyticsTracker.trackEvent(event.name, properties: bridgedProperties)
    }
    
    /// Bridging abstracted properties to specific for analytics tracker which is used. As an example [String: String] dictionary is used
    private func bridgedProperties(_ properties: [String: UIComponents.AnalyticsPropertyValue]) -> [String: String] {
        var bridgedProperties: [String: String] = [:]
        for (key, propertyValue) in properties {
            switch propertyValue {
            case let .string(value):
                bridgedProperties[key] = value
            case let .strings(value):
                bridgedProperties[key] = String(describing: value)
            case let .int(value):
                bridgedProperties[key] = String(describing: value)
            case let .date(value):
                bridgedProperties[key] = String(describing: value)
            }
        }
        return bridgedProperties
    }
}
