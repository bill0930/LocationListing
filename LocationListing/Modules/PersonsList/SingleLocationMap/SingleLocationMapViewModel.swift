//
//  SingleLocationMapViewModel.swift
//  LocationListing
//
//  Created by Billy Chan on 7/5/2021.
//

import Foundation
import GoogleMaps

protocol SingleLocationMapViewModelProtocol {
    var person: Person { get set }
    var marker: GMSMarker { get set }

    func setMarker(for person: Person, to mapView: GMSMapView)
}

protocol SingleLocationMapViewModelDelegate: AnyObject {
    func getMapView() -> GMSMapView
}

class SingleLocationMapViewModel: SingleLocationMapViewModelProtocol {
    var person: Person
    var marker: GMSMarker = GMSMarker()

    init(person: Person) {
        self.person = person
    }

    func setMarker(for person: Person, to mapView: GMSMapView) {
        let marker = GMSMarker()
        marker.snippet = person.email
        let first = person.name.first ?? ""
        let last = person.name.last ?? ""
        if let lat = person.location.latitude.value, let lon = person.location.longitude.value {
            mapView.camera = GMSCameraPosition(latitude: lat, longitude: lon, zoom: GoogleMapConstants.defaultZoomLevel)
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            marker.title = "\(first) \(last)"
        } else {
            marker.position = CLLocationCoordinate2D(latitude: GoogleMapConstants.defaultLatitude,
                                                     longitude: GoogleMapConstants.defaultLongitude)
            marker.title = "\(first) \(last) (Estimated)"
            marker.icon = GMSMarker.markerImage(with: UIColor(named: "pink005"))
        }
        marker.map = mapView
        self.marker = marker
    }
}
