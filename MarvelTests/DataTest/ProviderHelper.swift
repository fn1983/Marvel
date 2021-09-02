@testable import Marvel
import Foundation

struct ProviderHelper {
    static let timedOutResponse = SampleResponse.networkError(NSError(domain: NSURLErrorDomain,
                                                               code: URLError.timedOut.rawValue,
                                                               userInfo: nil))
    static let errorResponse = SampleResponse.networkResponse(500, Data())
    static let emptyResponse = SampleResponse.networkResponse(200, Data())
}
