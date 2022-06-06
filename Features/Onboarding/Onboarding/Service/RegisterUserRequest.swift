import Core

struct RegisterUser: Requestable {
    let email: String
    let name: String
    let surname: String
    let password: String

    var method: RequestMethod { .post }
    var path: String { "/user/register" }
}
