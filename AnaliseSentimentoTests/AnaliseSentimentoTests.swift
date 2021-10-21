import XCTest
import Alamofire
@testable import AnaliseSentimento

class AnaliseSentimentoTests: XCTestCase {
    
    var sut: Session!
    let networkMonitor = NetworkMonitor.shared

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AF
        
        let mockTwitterUser = TwitterUser()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testEndpointUserSuccessfulConnection() throws {
        try XCTSkipUnless(networkMonitor.isReachable, "Network connectivity needed for this test")
        
        // Dado
        let twitterUserEndpoint = TwitterEndpoint.twitterUser("Twitter")
        let url = twitterUserEndpoint.url
        let headers = twitterUserEndpoint.headers
        let expectation = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // Quando
        sut.request(url, headers: headers)
            .response { httpResponse in
                statusCode = httpResponse.response?.statusCode
                responseError = httpResponse.error
                expectation.fulfill()
            }
        wait(for: [expectation], timeout: 5)
        
        // Então
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testEndpointTwittsSuccessfulConnection() throws {
        try XCTSkipUnless(networkMonitor.isReachable, "Network connectivity needed for this test")
        
        // Dado
        let twitterUserEndpoint = TwitterEndpoint.userTwitts(from: "Twitter")
        let url = twitterUserEndpoint.url
        let headers = twitterUserEndpoint.headers
        let expectation = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // Quando
        sut.request(url, headers: headers)
            .response { httpResponse in
                statusCode = httpResponse.response?.statusCode
                responseError = httpResponse.error
                expectation.fulfill()
            }
        wait(for: [expectation], timeout: 5)
        
        // Então
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testFetchingTwitterUser() throws {
        try XCTSkipUnless(networkMonitor.isReachable, "Network connectivity needed for this test")
        
        // Dado
        let userService = UserService()
        let expectation = expectation(description: "Completion handler invoked")
        var twitterUser: TwitterUser?
        var userFetchErrors: [UserFetchErrors]?
        
        // Quando
        userService.fetchUser("Twitter") { user, fetchErrors in
            twitterUser = user
            userFetchErrors = fetchErrors
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        
        //Então
        XCTAssertEqual(userFetchErrors?.count, 1)
        XCTAssertEqual(userFetchErrors?.first?.title, "")
        XCTAssertEqual(twitterUser?.location, "everywhere")
        XCTAssertEqual(twitterUser?.name, "Twitter")
        XCTAssertEqual(twitterUser?.username, "Twitter")
        XCTAssertEqual(twitterUser?.description, "what’s happening?!")
        XCTAssertEqual(twitterUser?.createdAt, "2007-02-20T14:35:54.000Z")
        XCTAssertEqual(twitterUser?.id, "783214")
        XCTAssertEqual(twitterUser?.profileImageUrl, "https://pbs.twimg.com/profile_images/1354479643882004483/Btnfm47p_normal.jpg")
    }
    
    func testFetchingUserTwitts() throws {
        try XCTSkipUnless(networkMonitor.isReachable, "Network connectivity needed for this test")
        
        // Dado
        let twittsService = TwittsService()
        let expectation = expectation(description: "Completion handler invoked")
        var userTwitts: [UserTwitt]?
        
        // Quando
        twittsService.fetchUserTwittsFrom(user: "Twitter") { twitts in
            userTwitts = twitts
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        
        // Então
        XCTAssertNotNil(userTwitts)
        XCTAssertFalse(userTwitts?.isEmpty ?? true)
        if let twitts = userTwitts {
            for twitt in twitts {
                XCTAssertNotEqual(twitt.id, "")
                XCTAssertNotEqual(twitt.text, "")
            }
        }
    }
    
    func testFetchingUserProfileImage() throws {
        try XCTSkipUnless(networkMonitor.isReachable, "Network connectivity needed for this test")
        
        // Dado
        let twittsService = TwittsService()
        let imageURL = "https://pbs.twimg.com/profile_images/1354479643882004483/Btnfm47p_normal.jpg"
        let expectation = expectation(description: "Completion handler invoked")
        var userProfileImageData: Data?
        
        // Quando
        twittsService.getUserProfileImage(from: imageURL) { imageData in
            userProfileImageData = imageData
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        
        // Então
        XCTAssertNotNil(userProfileImageData)
    }
    
    func testDataConvertion() {
        // Dado
        let userService = UserService()
        let expectation = expectation(description: "Completion handler invoked")
        var twitterUser: TwitterUser?
        var userFetchErrors: [UserFetchErrors]?
        
        // Quando
        userService.fetchUser("Twitter") { user, fetchErrors in
            twitterUser = user
            userFetchErrors = fetchErrors
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        
        //Então
        XCTAssertEqual(userFetchErrors?.count, 1)
        XCTAssertEqual(userFetchErrors?.first?.title, "")
        XCTAssertEqual(twitterUser?.formattedDate(), "20/02/2007")
    }

}
