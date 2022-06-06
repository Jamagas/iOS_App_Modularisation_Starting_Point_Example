public protocol AnalyticsTracking {
    func track(event: String, properties: [String: AnalyticsPropertyValue])
    func track(_ event: AnalyticsEvent)
}

public protocol AnalyticsEvent {
    var name: String { get }
    var properties: [String: AnalyticsPropertyValue] { get }
}

public enum AnalyticsPropertyValue {
    case string(String)
    case strings([String])
    case int(Int)
    case date(Date)
    
    public static func value(_ value: String) -> Self {
        return .string(value)
    }
    
    public static func value(_ value: [String]) -> Self {
        return .strings(value)
    }
    
    public static func value(_ value: Int) -> Self {
        return .int(value)
    }
    
    public static func value(_ value: Date) -> Self {
        return .date(value)
    }
}
