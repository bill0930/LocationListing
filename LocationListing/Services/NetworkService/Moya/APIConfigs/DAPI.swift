//
//  DAPI.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import Foundation
import Moya

public enum DAPI {
    case personsList
}

extension DAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .personsList:
            return URL(string: "https://next.json-generator.com")!
        }
    }

    public var path: String {
        switch self {
        case .personsList:
            return "api/json/get/41P1_UhSI"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .personsList:
            return .get
        }
    }

    public var sampleData: Data {
        switch self {
        case .personsList:
            return MockData.personList
        }
    }

    public var task: Task {
        switch self {
        case .personsList:
            return .requestPlain
        }
    }

    public var headers: [String: String]? {
        switch self {
        case .personsList:
            return nil
        }
    }

}
