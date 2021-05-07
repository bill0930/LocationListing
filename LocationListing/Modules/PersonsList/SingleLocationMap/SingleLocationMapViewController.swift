//
//  SingleLocationMapViewController.swift
//  LocationListing
//
//  Created by Billy Chan on 7/5/2021.
//

import UIKit
import GoogleMaps

struct Constants {
    static let defaultLatitude: Double = 22.302711
    static let defaultLongitude: Double = 114.177216
    static let defaultZoomLevel: Float = 12.0
}

class SingleLocationMapViewController: UIViewController {

    let viewModel: SingleLocationMapViewModelProtocol

    lazy private var mapView: GMSMapView = {
        let mapView = GMSMapView()
        mapView.camera = GMSCameraPosition(latitude: Constants.defaultLatitude,
                                           longitude: Constants.defaultLongitude,
                                           zoom: Constants.defaultZoomLevel)
        return mapView
    }()

    lazy private var bottomInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "pink005")
        return view
    }()

    lazy private var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()

    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "Avenir", size: 14.0)
        label.textColor = UIColor(named: "pink001")
        return label
    }()

    lazy private var emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "Avenir", size: 14.0)
        label.textColor = UIColor(named: "pink001")
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        makeConstraints()
    }

    init(viewModel: SingleLocationMapViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        updateViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SingleLocationMapViewController {
    private func addSubViews() {
        view.addSubview(mapView)
        bottomInfoView.addSubview(avatarView)
        bottomInfoView.addSubview(nameLabel)
        bottomInfoView.addSubview(emailLabel)
        view.addSubview(bottomInfoView)

    }

    private func makeConstraints() {
        bottomInfoView.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
            $0.height.equalTo(76)
        }

        mapView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(bottomInfoView.snp.top)

        }

        avatarView.snp.makeConstraints {
            $0.leading.equalTo(16)
            $0.top.equalTo(16)
            $0.size.equalTo(44)
            $0.bottom.equalTo(-16)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(avatarView.snp.top)
            $0.leading.equalTo(avatarView.snp.trailing).offset(12)
            $0.height.equalTo(20)
            $0.width.equalTo(200)
        }

        emailLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(0)
            $0.leading.equalTo(avatarView.snp.trailing).offset(12)
            $0.bottom.equalTo(avatarView.snp.bottom)
            $0.height.equalTo(20)
            $0.width.greaterThanOrEqualTo(200)
        }
    }

    func updateViews() {
        if let firstName = viewModel.person.name?.first, let lastName = viewModel.person.name?.last {
            nameLabel.text = "\(firstName) \(lastName)"
        }

        emailLabel.text = viewModel.person.email

        let urlString = viewModel.person.picture
        let url = URL(string: urlString)
        avatarView.sd_setImage(with: url)

        let marker = GMSMarker()
        if let lat = viewModel.person.location.latitude.value, let lon = viewModel.person.location.longitude.value {
            mapView.camera = GMSCameraPosition(latitude: lat, longitude: lon, zoom: Constants.defaultZoomLevel)
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            marker.title = nameLabel.text
            marker.snippet = viewModel.person.email
        } else {
            marker.position = CLLocationCoordinate2D(latitude: Constants.defaultLatitude,
                                                     longitude: Constants.defaultLongitude)
            marker.title = nameLabel.text! + "\n (Estimated Location)"
            marker.snippet = viewModel.person.email
            marker.icon = GMSMarker.markerImage(with: UIColor(named: "pink005"))
        }

        marker.map = mapView

    }
}
