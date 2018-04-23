//
//  MarvelSuperHeroesTests.swift
//  MarvelSuperHeroesTests
//
//  Created by Thaciana Lima on 21/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import XCTest
@testable import MarvelSuperHeroes

class MarvelSuperHeroesTests: XCTestCase {
    
    let marvelService = MarvelService()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetHeroes_WithLimitZero_ReturnsError() {
        let expectation1 = expectation(description: "Wait for getHeroes completion.")
        var error: Error?
        var heroes: [Hero]?
        marvelService.getHeroes(limit:0, offset:0, callback: { returnedHeroes, returnedError in
            error = returnedError
            heroes = returnedHeroes
            expectation1.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(heroes)
        XCTAssertNotNil(error)
    }
    
    func testGetHeroes_WithLimitThree_ReturnsThreeHeroesWithContent() {
        let expectation1 = expectation(description: "Wait for getHeroes completion.")
        var error: Error?
        var heroes: [Hero]?
        marvelService.getHeroes(limit:3, offset:0, callback: { returnedHeroes, returnedError in
            error = returnedError
            heroes = returnedHeroes
            expectation1.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(error)
        XCTAssertNotNil(heroes)
        XCTAssertEqual(heroes!.count, 3)
        XCTAssertNotEqual(heroes![0].id, 0)
    }
    
    func testGetHttpRequest_WithValidUrl_ReturnsData() {
        let expectation1 = expectation(description: "Wait for getHttpRequest completion.")
        var error: Error?
        var data: Data?
        marvelService.getHttpRequest(urlString: "https://www.google.com", callback: { returnedData, returnedError in
            error = returnedError
            data = returnedData
            expectation1.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(error)
        XCTAssertNotNil(data)
    }
    
    func testGetHttpRequest_WithInvalidUrl_ReturnsError() {
        let expectation1 = expectation(description: "Wait for getHttpRequest completion.")
        var error: Error?
        var data: Data?
        marvelService.getHttpRequest(urlString: "https://www.googlekkk.com", callback: { returnedData, returnedError in
            error = returnedError
            data = returnedData
            expectation1.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(error)
        XCTAssertNil(data)
    }
}
