//
//  LocationListingTests.swift
//  LocationListingTests
//
//  Created by Billy Chan on 5/5/2021.
//

import XCTest
@testable import LocationListing

class LocationListingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDAPIGetPersonList() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let apiService = APIService()
        apiService.DAPI.request(.personsList) { result in
            switch result {
            case .success(let response):
                if let persons = try? response.map([Person].self) {
                    XCTAssert(persons.count > 0, "Total: \(persons.count) persons in the list")
                }

            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
