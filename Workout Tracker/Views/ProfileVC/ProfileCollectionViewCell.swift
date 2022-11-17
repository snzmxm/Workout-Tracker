//
//  ProfileCollectionViewCell.swift
//  Workout Tracker
//
//  Created by SNZ on 15.11.2022.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {

    private let nameLabel = UILabel(text: "PUSH UPS",
                                    font: .robotoBold24(),
                                    textColor: .white,
                                    textAlignment: .center)

    private let numberLabel = UILabel(text: "180",
                                      font: .robotoBold48(),
                                      textColor: .white,
                                      textAlignment: .center)

    private let workoutImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "pushUps")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        layer.cornerRadius = 20
        backgroundColor = .specialDarkYellow

        addSubview(nameLabel)
        addSubview(workoutImageView)
        addSubview(numberLabel)
    }

    func cellConfigure(model: ResultWorkout) {
        nameLabel.text = model.name
        numberLabel.text = "\(model.result)"

        guard let data = model.imageData else { return }
        let image = UIImage(data: data)
        workoutImageView.image = image
    }
}

extension ProfileCollectionViewCell {
    private func setConstraints() {

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            workoutImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            workoutImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            workoutImageView.heightAnchor.constraint(equalToConstant: 57),
            workoutImageView.widthAnchor.constraint(equalToConstant: 57)
        ])

        NSLayoutConstraint.activate([
            numberLabel.centerYAnchor.constraint(equalTo: workoutImageView.centerYAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: workoutImageView.trailingAnchor, constant: 10)
        ])
    }
}
