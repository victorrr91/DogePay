//
//  ChartTableViewCell.swift
//  DogePay
//
//  Created by Victor Lee on 2023/03/13.
//

import UIKit
import FlexLayout
import PinLayout

class ChartTableViewCell: UITableViewCell {

    private let coinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 1

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(data: ChartHome.ConnectWebSocket.ViewModel.DisplayedPrice) {
        coinImage.image = data.coinImage
        priceLabel.text = data.price
    }

    private func setupViews() {
        selectionStyle = .none
        contentView.addSubview(coinImage)
        contentView.addSubview(priceLabel)

        NSLayoutConstraint.activate([
            coinImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            coinImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coinImage.widthAnchor.constraint(equalToConstant: 40),
            coinImage.heightAnchor.constraint(equalToConstant: 40),

            priceLabel.leadingAnchor.constraint(equalTo: coinImage.trailingAnchor, constant: 16),
            priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
}
