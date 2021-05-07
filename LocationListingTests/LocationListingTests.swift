//
//  LocationListingTests.swift
//  LocationListingTests
//
//  Created by Billy Chan on 5/5/2021.
//

import XCTest
@testable import LocationListing
import ObjectMapper
import Moya

class LocationListingTests: XCTestCase {

    var sut: APIServiceProtocol!

    override func setUp() {
        super.setUp()
        sut = APIService()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testDAPIGetPersonListAndMapping() {
        let promise = expectation(description: "DPI.getPersonList.mapping")

        sut.dapiService.provider.request(DAPI.personsList) { result in
            switch result {
            case .success(let response):
                if let json = try? response.mapJSON() {
                    if let persons = Mapper<Person>().mapArray(JSONObject: json) {
                        XCTAssertTrue(persons.count > 0, "persons.count == 0")
                        promise.fulfill()
                    } else {
                        XCTFail("🔴Mapper<Person>().mapArray(JSONObject: json) FAIL")
                    }
                } else {
                    XCTFail("🔴response.mapJSON() FAIL")
                }
            case .failure(let error):
                XCTFail("🔴error with \(error)")
            }
        }
        wait(for: [promise], timeout: 10)
    }
}
