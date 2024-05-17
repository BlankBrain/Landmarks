//
//  LandmaksCollectionViewCell.swift
//  Landmaks
//
//  Created by Md. Mehedi Hasan on 17/5/24.
//

import UIKit

class LandmaksCollectionViewCell: UICollectionViewCell {
    
    //MARK: Components
    private lazy var baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "LandMark Name"
        label.numberOfLines = 0
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.text = "LandMark SubTitle"
        label.numberOfLines = 0
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    private lazy var landmarkImage: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var landmarkDetailsStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(subTitleLabel)
        return stackView
    }()
    private lazy var mainStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.addArrangedSubview(landmarkImage)
        stackView.addArrangedSubview(landmarkDetailsStackView)
        return stackView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.addSubviews()
        self.addConstraint()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    private func addSubviews() {
        self.addSubview(baseView)
        baseView.addSubview(mainStackView)
    }

    private func addConstraint() {
        NSLayoutConstraint.activate([
            // Constraints for baseView
            baseView.topAnchor.constraint(equalTo: self.topAnchor),
            baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            // Constraints for mainStackView
            mainStackView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -8),
            mainStackView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -8),
            
            // Constraints for landmarkImage
            landmarkImage.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: 2/3),
            landmarkImage.heightAnchor.constraint(equalTo: landmarkImage.widthAnchor, multiplier: 9/16), 
            landmarkImage.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            landmarkImage.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            
            // Constraints for nameLabel and subTitleLabel
            nameLabel.leadingAnchor.constraint(equalTo: landmarkDetailsStackView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: landmarkDetailsStackView.trailingAnchor),
            subTitleLabel.leadingAnchor.constraint(equalTo: landmarkDetailsStackView.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: landmarkDetailsStackView.trailingAnchor),
            
            // Spacing between nameLabel and subTitleLabel
            nameLabel.bottomAnchor.constraint(equalTo: subTitleLabel.topAnchor, constant: -8),
        ])
    }


    //Setup cell
    public func setupCell( landmark: LandmaksModel){
        nameLabel.text = landmark.name
        subTitleLabel.text = landmark.subtitle
        landmarkImage.image = UIImage(named: landmark.imageName)
    }
}
