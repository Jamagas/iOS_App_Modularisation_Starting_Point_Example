public protocol AnalyticsEvent {
    var name: String { get }
    var properties: [String: AnalyticsPropertyValue] { get }
}
