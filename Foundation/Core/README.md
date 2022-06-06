# How to use ModuleCore

## Networking

**Network worker**

Executing request via network worker

```
@Injected private var networkWorker: Networking

networkWorker.perform(request: request) { (result: Result<VoidResponse, StandardError>) in
    switch result {
    case .success:
        break
    case let .failure(error):
        break
    }
}
```

`VoidResponse` is used when request returns empty response otherwise concrete response object should be used instead.

**Request**

Simple GET example

```
struct ActivityListRequest: Requestable {
    var method: RequestMethod { .get }
    var path: String { "/activities-restapi/v1/all/" }
}
```

Example when request parameters are included as query or body parameters

```
struct UpdateEmailRequest: Requestable {
    let email: String

    var method: RequestMethod { .post }
    var path: String { "/user-settings-restapi/email/" }
}
```

Example when **all** request parameters are **not** included as query or body parameters

```
struct UserStatusRequest: Requestable {
    let identifier: UUID

    var method: RequestMethod { .get }
    var path: String { "/client-authentication/user-status/" + identifier.uuidString }

    private enum CodingKeys: CodingKey { } // Include none of the parameters in query or body
}
```

Example when **some** request parameters are included as query or body parameters

```
struct ValidatePaymentRequest: Requestable {
    let paymentId: String 
    let amount: Money
    let currency: String

    var method: RequestMethod { .post }
    var path: String { "/payment-restapi/api/v1/general-payment/\(paymentId)/validate" }
    
    private enum CodingKeys: CodingKey { // Include `amount` and `currency` in query or body and exclude `paymentId` which is used as part of path
        case amount
        case currency
    }
}
```

## Analytics

**V1, tract directly**
```
@Injected private var analyticsTracker: AnalyticsTracking

analyticsTracker.track(
    event: "My Event", 
    properties: [
        "Some Key": .value(10),
        "Other Key": .value("Title")
    ]
)
```

**V2, track event object**

Tracking execution
```
@Injected private var analyticsTracker: AnalyticsTracking

let event = PaymentEvent(payment: self.payment)
analyticsTracker.track(event)
```

Declaration of event
```
struct PaymentEvent {
    let payment: Payment
}

extension MyPaymentEvent: AnalyticsEvent {
    var name: String { "Payment Completed" }
    var properties: [String: AnalyticsPropertyValue] { 
        [
            "Amount": .value(payment.amount),
            "Product Name": .value(payment.productName)
        ]
    }
}
```
