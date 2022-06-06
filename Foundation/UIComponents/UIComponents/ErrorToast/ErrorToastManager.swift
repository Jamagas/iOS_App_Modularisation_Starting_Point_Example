public final class ErrorToastManager {
    
    public static func showErrorToast(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let invocationPoint = makeInvocationPoint(file: file, function: function, line: line)
        Dependencies.analyticsTrackingProvider.track(
            event: "Error Toast",
            properties: [
                "Message": .value(message),
                "Invocation Point": .value(invocationPoint)
            ]
        )
    }
    
    private static func makeInvocationPoint(file: String, function: String, line: Int) -> String {
        let file = URL(string: file)?.lastPathComponent ?? ""
        return "file: \(file) function: \(function) line: \(line)"
    }
}
