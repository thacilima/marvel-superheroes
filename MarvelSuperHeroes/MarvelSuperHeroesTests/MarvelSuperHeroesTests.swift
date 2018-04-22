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
    
    func testGetZeroHeroesFromService() {
        let result = marvelService.getHeroes(limit:0, offset:0)
        XCTAssertTrue(result.count == 0)
    }
    
    func testGetThreeHeroesFromService() {
        let result = marvelService.getHeroes(limit:3, offset:0)
        XCTAssertTrue(result.count == 3)
    }
    
    func testGetHeroesInfoFromService() {
        let result = marvelService.getHeroes(limit: 1, offset: 0)
        XCTAssertTrue(result[0].id != 0)
    }
}
