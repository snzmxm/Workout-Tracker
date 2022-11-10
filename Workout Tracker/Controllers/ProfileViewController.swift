//
//  ProfileViewController.swift
//  Workout Tracker
//
//  Created by SNZ on 10.11.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    //MARK: - Сreate
    private let profileLabel = UILabel(text: "PROFILE",
                                       font: .robotoMedium24(),
                                       textColor: .specialGray)

    private let profileNameLabel = UILabel(text: "Maxim Bogdanov",
                                           font: .robotoBold24(),
                                           textColor: .white)

    private let heightLabel = UILabel(text: "Height: 170",
                                      font: .robotoMedium16(),
                                      textColor: .specialGray)

    private let weightLabel = UILabel(text: "Weight: 65",
                                      font: .robotoMedium16(),
                                      textColor: .specialGray)

    private lazy var editingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Editing ", for: .normal)
        button.tintColor = .specialGreen
        button.titleLabel?.font = .robotoMedium16()
        button.setImage(UIImage(named: "editingButton"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editingButtonTapped), for: .touchUpInside)
        return button
    }()

    private var parametrsLabelStackView = UIStackView()

    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.7607843137, blue: 0.7607843137, alpha: 1)
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let backgroundProfileView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialGreen
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //MARK: - addView
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setConstraints()
    }

    private func setupViews() {
        view.backgroundColor = .specialBackground

        view.addSubview(profileLabel)
        view.addSubview(backgroundProfileView)
        view.addSubview(userPhotoImageView)
        view.addSubview(profileNameLabel)

        parametrsLabelStackView = UIStackView(arrangedSubviews: [heightLabel, weightLabel],
                                              axis: .horizontal,
                                              spacing: 10)
        view.addSubview(parametrsLabelStackView)
        view.addSubview(editingButton)
    }

    @objc private func editingButtonTapped() {
        print("editingButtonTapped")
    }
}

//MARK: - setConstraints
extension ProfileViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 20),
            userPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])

        NSLayoutConstraint.activate([
            backgroundProfileView.topAnchor.constraint(equalTo: userPhotoImageView.centerYAnchor),
            backgroundProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backgroundProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            backgroundProfileView.heightAnchor.constraint(equalToConstant: 110)
        ])

        NSLayoutConstraint.activate([
            profileNameLabel.topAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor, constant: 20),
            profileNameLabel.centerXAnchor.constraint(equalTo: backgroundProfileView.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            parametrsLabelStackView.topAnchor.constraint(equalTo: backgroundProfileView.bottomAnchor, constant: 5),
            parametrsLabelStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])

        NSLayoutConstraint.activate([
            editingButton.topAnchor.constraint(equalTo: backgroundProfileView.bottomAnchor, constant: 5),
            editingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
}
