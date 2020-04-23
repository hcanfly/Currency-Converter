//
//  CurrencyTableViewCell.swift
//  Currency Converter
//
//  Created by Gary on 4/22/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit


final class CurrencyCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CurrencyCollectionViewCell"

    var currencyText: String? {
           didSet {
                self.currencyValueLabel.text = currencyText
                self.setNeedsLayout()
           }
       }

    var currencyValueLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name:"HelveticaNeue", size: 24.0)
        return label
    }()

    var countryNameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name:"HelveticaNeue", size: 18.0)
        return label
    }()

    var flagLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont(name:"HelveticaNeue", size: 78.0)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
        self.backgroundColor = .systemGray6
        self.layer.opacity = 0.8
        self.layer.cornerRadius = 10
        self.addSubview(self.flagLabel)
        self.addSubview(self.currencyValueLabel)
        self.addSubview(self.countryNameLabel)

        setupConstraints()
    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([
        flagLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
        flagLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
        flagLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),

        countryNameLabel.leftAnchor.constraint(equalTo: self.flagLabel.rightAnchor, constant: 8),
        countryNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
        countryNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),

        currencyValueLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 28),
        currencyValueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
        currencyValueLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
