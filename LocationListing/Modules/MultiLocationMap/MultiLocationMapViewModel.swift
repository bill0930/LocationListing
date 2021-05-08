//
//  MultiLocationMapViewModel.swift
//  LocationListing
//
//  Created by Billy Chan on 8/5/2021.
//

import Foundation
import GoogleMaps

private struct Constants {
    static let failedMarkerColor = UIColor(named: "pink005")!
}

protocol MultiLocationMapViewModelProtocol {
    var viewController: MultiLocationMapViewModelDelegate? { get set }
    var storageService: StorageServiceProtocol { get }
    var persons: [Person] { get set }
    var markers: [GMSMarker] { get set }

    func updatePersonList()
}

protocol MultiLocationMapViewModelDelegate: AnyObject {
    func getMapView() -> GMSMapView
}

class MultiLocationMapViewModel: MultiLocationMapViewModelProtocol {

    weak var viewController: MultiLocationMapViewModelDelegate?

    var storageService: StorageServiceProtocol = StorageService()

    var persons: [Person] = []
    var markers: [GMSMarker] = []

    init() {}

    func updatePersonList() {
        storageService.retrievePersonlistFrom(.cache) { persons, _ in
            self.persons = persons
        }

        let markers = persons.map { person -> GMSMarker in
            let marker = GMSMarker()
            marker.snippet = person.email
            let first = person.name.first ?? ""
            let last = person.name.last ?? ""
            if let lat = person.location.latitude.value, let lon = person.location.longitude.value {
                marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                marker.title = "\(first) \(last)"
            } else {
                marker.position = CLLocationCoordinate2D(latitude: GoogleMapConstants.defaultLatitude,
                                                         longitude: GoogleMapConstants.defaultLongitude)
                marker.title = "\(first) \(last) (Estimated)"
                marker.icon = GMSMarker.markerImage(with: Constants.failedMarkerColor)
            }

            marker.map = viewController?.getMapView()
            return marker
        }
        self.markers = markers
    }

}
