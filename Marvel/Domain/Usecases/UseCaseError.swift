enum UseCaseError: Error {
    case mapping(Swift.Error)
    case timeout(Swift.Error)
    case noConnection(Swift.Error)
    case marvelApi(MarvelApiError)
    case generic(Swift.Error)
}

enum MarvelApiError: Error {
    case error400(Swift.Error)
    case error500(Swift.Error)
}
