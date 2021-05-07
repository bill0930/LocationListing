//
//  MultiLocationMapViewController.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import UIKit
import GoogleMaps

final class MultiLocationMapViewController: UIViewController {

    var viewModel: MultiLocationMapViewModelProtocol

    lazy private var mapView: GMSMapView = {
        let mapView = GMSMapView()
        mapView.camera = GMSCameraPosition(latitude: GoogleMapConstants.defaultLatitude,
                                           longitude: GoogleMapConstants.defaultLongitude,
                                           zoom: GoogleMapConstants.defaultZoomLevel - 2)
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addSubviews()
        makeConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        viewModel.updatePersonList()
    }

    init(viewModel: MultiLocationMapViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewController = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MultiLocationMapViewController {
    private func addSubviews() {
        view.addSubview(mapView)
    }

    private func makeConstraints() {
        mapView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
}

extension MultiLocationMapViewController: MultiLocationMapViewModelDelegate {
    func getMapView() -> GMSMapView {
        return self.mapView
    }
}
