//
//  NewsTableViewCell.swift
//  Orioks_iOS
//
//  Created by User on 21.11.2025.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    
    // MARK: - UI Elements
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let eyeIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "eye.fill")
        imageView.tintColor = UIColor(red: 0.29, green: 0.56, blue: 0.71, alpha: 1.0)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(eyeIconImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Date Label
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            dateLabel.widthAnchor.constraint(equalToConstant: 100),
            
            // Title Label
            titleLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: eyeIconImageView.leadingAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            // Eye Icon
            eyeIconImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            eyeIconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            eyeIconImageView.widthAnchor.constraint(equalToConstant: 24),
            eyeIconImageView.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    // MARK: - Public Methods
    func configure(with news: News) {
        dateLabel.text = news.formattedDate
        titleLabel.text = news.title
        
        // Если прочитано - серый цвет
        if news.isRead {
            titleLabel.textColor = .secondaryLabel
            eyeIconImageView.tintColor = .secondaryLabel
        } else {
            titleLabel.textColor = .label
            eyeIconImageView.tintColor = UIColor(red: 0.29, green: 0.56, blue: 0.71, alpha: 1.0)
        }
    }
}
