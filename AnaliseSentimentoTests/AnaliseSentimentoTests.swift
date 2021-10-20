import XCTest
import Alamofire
@testable import AnaliseSentimento

class AnaliseSentimentoTests: XCTestCase {
    
    var sut: Session!
    let networkMonitor = NetworkMonitor.shared

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AF
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testUserEndpointSuccessfulConnection() throws {
        try XCTSkipUnless(networkMonitor.isReachable, "Network connectivity needed for this test")
        
        // Dado
        let twitterUserEndpoint = TwitterEndpoint.twitterUser("Twitter")
        let url = twitterUserEndpoint.url
        let headers = twitterUserEndpoint.headers
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // Quando
        sut.request(url, headers: headers)
            .response { httpResponse in
                statusCode = httpResponse.response?.statusCode
                responseError = httpResponse.error
                promise.fulfill()
            }
        wait(for: [promise], timeout: 5)
        
        // Então
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testTwittsEndpointSuccessfulConnection() throws {
        try XCTSkipUnless(networkMonitor.isReachable, "Network connectivity needed for this test")
        
        // Dado
        let twitterUserEndpoint = TwitterEndpoint.userTwitts(from: "Twitter")
        let url = twitterUserEndpoint.url
        let headers = twitterUserEndpoint.headers
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // Quando
        sut.request(url, headers: headers)
            .response { httpResponse in
                statusCode = httpResponse.response?.statusCode
                responseError = httpResponse.error
                promise.fulfill()
            }
        wait(for: [promise], timeout: 5)
        
        // Então
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }

}
