//
//  SingleLocationMapViewController.swift
//  LocationListing
//
//  Created by Billy Chan on 7/5/2021.
//

import UIKit
import GoogleMaps

private struct Constants {
    static let viewBackgroundColor = UIColor(named: "pink005")!
    static let avatarCornerRadius = CGFloat(22.0)
    static let avatarImageSize = CGFloat(44)
    static let labelFont = UIFont(name: "Avenir", size: 14.0)
    static let labelTextColor = UIColor(named: "pink001")
}

class SingleLocationMapViewController: UIViewController {

    var viewModel: SingleLocationMapViewModelProtocol

    lazy private var mapView: GMSMapView = {
        let mapView = GMSMapView()
        mapView.camera = GMSCameraPosition(latitude: GoogleMapConstants.defaultLatitude,
                                           longitude: GoogleMapConstants.defaultLongitude,
                                           zoom: GoogleMapConstants.defaultZoomLevel)
        return mapView
    }()

    lazy private var bottomInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.viewBackgroundColor
        return view
    }()

    lazy private var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.avatarCornerRadius
        imageView.layer.masksToBounds = true
        return imageView
    }()

    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Constants.labelFont
        label.textColor = Constants.labelTextColor
        return label
    }()

    lazy private var emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Constants.labelFont
        label.textColor = Constants.labelTextColor
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
        let person = viewModel.person
        nameLabel.text = "\(person.name.first!)  \(person.name.last!)"
        emailLabel.text = viewModel.person.email

        let urlString = viewModel.person.picture
        let url = URL(string: urlString)
        avatarView.sd_setImage(with: url)
        viewModel.setMarker(for: person, to: mapView)
    }
}
