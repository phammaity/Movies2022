//
//  MovieDetailViewModelTests.swift
//  MoviesTests
//
//  Created by Ty Pham on 21/01/2022.
//

import XCTest
@testable import Movies

class MovieDetailViewModelTests: XCTestCase {
    var sut : MovieDetailViewModel!
    
    override func setUpWithError() throws {
        sut = MovieDetailViewModel(movieModel: MovieModel())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStarImagesGenerate() {
        XCTAssertEqual(sut.starImagesGenerate(point: 0), ["star","star","star","star","star"])
        XCTAssertEqual(sut.starImagesGenerate(point: 10), ["star.fill","star.fill","star.fill","star.fill","star.fill"])
        XCTAssertEqual(sut.starImagesGenerate(point: 5.0), ["star.fill","star.fill","star.leadinghalf.filled","star","star"])
        XCTAssertEqual(sut.starImagesGenerate(point: 0.5), ["star.leadinghalf.filled","star","star","star","star"])
        XCTAssertEqual(sut.starImagesGenerate(point: 5.5), ["star.fill","star.fill","star.leadinghalf.filled","star","star"])
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
