//
//  PersonsListTableViewCell.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import UIKit
import SnapKit
import SDWebImage

private struct Constants {
    static let avatarCornerRadius = CGFloat(22.0)
    static let avatarImageSize = CGFloat(44)
    static let labelFont = UIFont(name: "Avenir", size: 14.0)
    static let labelTextColor = UIColor(named: "pink_003")
}

protocol PersonListTableViewCellModelProtocol {
    var person: Person { get }
}

struct PersonListTableViewCellModel: PersonListTableViewCellModelProtocol {
    var person: Person
}

final class PersonListTableViewCell: UITableViewCell {

    lazy private var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.avatarCornerRadius
        imageView.layer.masksToBounds = true
        imageView.isSkeletonable = true
        return imageView
    }()

    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Constants.labelFont
        label.textColor = Constants.labelTextColor
        label.isSkeletonable = true
        return label
    }()

    lazy private var emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Constants.labelFont
        label.textColor = Constants.labelTextColor
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

extension PersonListTableViewCell {
    private func makeConstraints() {
        avatarView.snp.makeConstraints {
            $0.size.equalTo(Constants.avatarImageSize)
            $0.leading.equalTo(16)
            $0.top.equalTo(16)
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

    func setModel(with cellModel: PersonListTableViewCellModelProtocol) {
        DispatchQueue.main.async {
            if let firstName = cellModel.person.name?.first,
               let lastName = cellModel.person.name?.last {
                self.nameLabel.text = "\(firstName) \(lastName)"
            }

            self.emailLabel.text = cellModel.person.email

            let urlString = cellModel.person.picture
            let url = URL(string: urlString)
            self.avatarView.sd_setImage(with: url)
        }

    }
}
