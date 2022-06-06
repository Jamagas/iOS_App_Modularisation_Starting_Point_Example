protocol ServiceLocating {
    func register<T>(_ service: @escaping () -> T)
    func clearServices()
    func resolve<T>() -> T
}
