//
//  PersonsListTableViewCell.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import UIKit
import SnapKit
import SDWebImage

protocol PersonsListTableViewCellModelProtocol {
    var person: Person { get }
}

struct PersonsListTableViewCellModel: PersonsListTableViewCellModelProtocol {
    var person: Person
}

final class PersonsListTableViewCell: UITableViewCell {

    lazy private var avatarView: UIImageView = {
        let imageView = UIImageView()
//        imageView.backgroundColor = UIImage
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.isSkeletonable = true
        return imageView
    }()

    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "Avenir", size: 14.0)
        label.textColor = UIColor(named: "pink_003")
        label.isSkeletonable = true
        return label
    }()

    lazy private var emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "Avenir", size: 14.0)
        label.textColor = UIColor(named: "pink_003")
        label.isSkeletonable = true
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isSkeletonable = true
        contentView.isSkeletonable = true
        contentView.backgroundColor = .clear
        contentView.addSubview(avatarView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailLabel)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {

    }

}

extension PersonsListTableViewCell {
    func makeConstraints() {
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

    func setModel(with cellModel: PersonsListTableViewCellModelProtocol) {
        if let firstName = cellModel.person.name?.first,
           let lastName = cellModel.person.name?.last {
            nameLabel.text = "\(firstName) \(lastName)"
        }

        emailLabel.text = cellModel.person.email

        var urlString = cellModel.person.picture
        let url = URL(string: urlString)
        avatarView.sd_setImage(with: url)
    }
}
