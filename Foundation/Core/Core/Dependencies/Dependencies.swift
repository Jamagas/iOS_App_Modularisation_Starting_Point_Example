public final class Dependencies {
    public static var networkingProvider: () -> Networking {
        get { ServiceLocator.shared.resolve() }
        set { ServiceLocator.shared.register(newValue) }
    }
    public static var analyticsTrackingProvider: AnalyticsTracking {
        get { ServiceLocator.shared.resolve() }
        set { ServiceLocator.shared.register { newValue } }
    }
}
