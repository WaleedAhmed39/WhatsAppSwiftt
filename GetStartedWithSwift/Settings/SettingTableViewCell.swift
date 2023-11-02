//
//  SettingTableViewCell.swift
//  GetStartedWithSwift
//
//  Created by Waleed Iftikhar on 3/7/2023.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
 static let identifier = "SettingTableViewCell"
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        return imageView
    }()
    private let label: UILabel = {
    let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    override init (style: UITableViewCell.CellStyle , reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - 12
        iconImageView.frame  = CGRect(x:15 , y:6 , width: size, height: size)
        
        label.frame = CGRect (x: 25 + iconImageView.frame.size.width, y: 0 , width: contentView.frame.size.width - 15 - iconImageView.frame.size.width ,
                              height:  contentView.frame.size.height)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
    }
    public func configure(with model: SettingsOption) {
        label.text = model.title
        iconImageView.image = model.icon
        iconImageView.backgroundColor = model.iconBackgroundColor
    }
}
