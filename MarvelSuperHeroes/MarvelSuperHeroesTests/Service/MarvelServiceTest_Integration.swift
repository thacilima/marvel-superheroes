//
//  MarvelServiceTest+Integration.swift
//  MarvelSuperHeroesTests
//
//  Created by Thaciana Lima on 26/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import XCTest
@testable import MarvelSuperHeroes

class MarvelServiceTest_Integration: XCTestCase {
    let marvelService = MarvelService()
    
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
    
    func testGetHeroes_WithLimitThree_ReturnsThreeHeroes() {
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
    }
    
    func testGetHeroes_ReturnsAtLeastOneHeroWithContent() {
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
        XCTAssertNotEqual(heroes?[0].id ?? 0, 0)
    }
    
    func testGetComics_ReturnsAtLeastOneComicWithContent() {
        let expectation1 = expectation(description: "Wait for getComics completion.")
        var error: Error?
        var comicsResult: String?
        marvelService.getComics(forHeroId: 1011334, limit: 3, offset: 0, callback: { returnedComics, returnedError in
            error = returnedError
            comicsResult = returnedComics
            expectation1.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNil(error)
        XCTAssertNotNil(comicsResult)
        XCTAssertFalse(comicsResult?.isEmpty ?? true)
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
        marvelService.getHttpRequest(urlString: "https://www.googlek.com", callback: { returnedData, returnedError in
            error = returnedError
            data = returnedData
            expectation1.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(error)
        XCTAssertNil(data)
    }
}
