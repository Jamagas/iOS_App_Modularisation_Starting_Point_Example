import Core

final class CoreFramework {
    
    static func setup() {
        Core.Dependencies.networkingProvider = { NetworkingProvider() } // It is explicitly done in closure that each time networking is access new instance if returned. Basically to allow properly deal with dealocation of parent which is doing networking
        Core.Dependencies.analyticsTrackingProvider = AnalyticsTrackingProvider()
    }
}


