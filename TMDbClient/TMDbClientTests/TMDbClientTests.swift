//
//  TMDbClientTests.swift
//  TMDbClientTests
//
//  Created by Anderson Santos Gusmão on 29/12/2017.
//  Copyright © 2017 Anderson Santos Gusmão. All rights reserved.
//

import XCTest
@testable import TMDbClient

class TMDbClientTests: XCTestCase {

    var moveApi: MovieApi!

    override func setUp() {
        super.setUp()
        moveApi = MovieApi(apiKey: "9a74372440cacf0cd102b3521edbbd0c")
        self.continueAfterFailure = true
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetGenresForcingCallbackError() {

        let expectationForAnswer = expectation(description: "Wait for api answer")

        MovieApi(apiKey: "NO_KEY").getGenres { (response) in
            switch response {
            case .success:
                XCTFail("This call couldn't success")
            case .error:
                assert(true)
            }
            expectationForAnswer.fulfill()
        }

        waitForExpectations(timeout: 5.0) { (error) in
            if error != nil {
                XCTFail((error?.localizedDescription) ?? String.Empty)
            }
        }
    }

    func testGetMoviesForcingCallbackError() {

        let expectationForAnswer = expectation(description: "Wait for api answer")

        MovieApi(apiKey: "NO_KEY").getMoviesByGenre(genderId: -1000, callback: { (response) in
            switch response {
            case .success:
                XCTFail("This call couldn't success")
            case .error:
                assert(true)
            }
            expectationForAnswer.fulfill()
        })

        waitForExpectations(timeout: 5.0) { (error) in
            if error != nil {
                XCTFail((error?.localizedDescription) ?? String.Empty)
            }
        }
    }

    func testGetGenres() {

        let expectationForAnswer = expectation(description: "Wait for api answer")

        moveApi.getGenres { (response) in
            switch response {
            case .success(let response):
                assert(response.result?.count ?? 0 > 0
                    && response.result?.first?.id != nil
                    && response.result?.first?.name != nil)
            case .error:
                assertionFailure()
            }

            expectationForAnswer.fulfill()
        }

        waitForExpectations(timeout: 5.0) { (error) in
            if error != nil {
                XCTFail((error?.localizedDescription) ?? String.Empty)
            }
        }
    }

    func testGetMoviesByGenre() {

        let expectationForAnswer = expectation(description: "Wait for api answer")

        moveApi.getGenres { (response) in
            switch response {
            case .success(let response):
                self.moveApi.getMoviesByGenre(genderId: response.result?.first?.id ?? -1000,
                                              callback: { (response) in

                                                switch response {
                                                case .success(let response):
                                                    assert(response.result?.count ?? 0 > 0
                                                        && response.result?.first?.id != nil
                                                        && response.result?.first?.title != nil)
                                                case .error:
                                                    assertionFailure()
                                                }
                                                expectationForAnswer.fulfill()
                })
            case .error:
                assertionFailure()
                expectationForAnswer.fulfill()
            }
        }

        waitForExpectations(timeout: 5.0) { (error) in
            if error != nil {
                XCTFail((error?.localizedDescription) ?? String.Empty)
            }
        }
    }

    func testPerformanceTwoCalls() {
        self.measure {
            testGetMoviesByGenre()
        }
    }
}
