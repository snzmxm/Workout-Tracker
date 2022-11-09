//
//  StartWorkoutViewController.swift
//  Workout Tracker
//
//  Created by SNZ on 09.11.2022.
//

import UIKit

class StartWorkoutViewController: UIViewController {
    
    private let startWorkoutLabel = UILabel(text: "START WORKOUT", font: .robotoBold24(), textColor: .specialGray)

    private lazy var cloceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var startWorkoutImage = addImage(width: "startWorkout")

    private let detailsLabel = UILabel(text: "Details")

    private let detailsStack = StartWorkoutViewCell()

    //add button finish
    lazy var finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.addShadowOnView()
        button.backgroundColor = .specialGreen
        button.tintColor = .specialWhite
        button.setTitle("FINISH", for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
        return button
    }()

    @objc private func finishButtonTapped() {
        print("finishButtonTapped")
    }

    @objc private func closeButtonTapped() {
        print("closeButtonTapped")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setConstraints()
    }

    private func  setupViews() {
        view.backgroundColor = .specialBackground

        view.addSubview(startWorkoutLabel)
        view.addSubview(cloceButton)
        view.addSubview(startWorkoutImage)
        view.addSubview(detailsLabel)
        view.addSubview(detailsStack)
        view.addSubview(finishButton)

    }

    private func addImage(width named: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: named)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}

extension StartWorkoutViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            startWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            startWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            cloceButton.centerYAnchor.constraint(equalTo: startWorkoutLabel.centerYAnchor),
            cloceButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cloceButton.heightAnchor.constraint(equalToConstant: 30),
            cloceButton.widthAnchor.constraint(equalToConstant: 30)
            
        ])

        NSLayoutConstraint.activate([
            startWorkoutImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startWorkoutImage.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 28),
            startWorkoutImage.heightAnchor.constraint(equalToConstant: 250),
            startWorkoutImage.widthAnchor.constraint(equalToConstant: 190)
        ])

        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: startWorkoutImage.bottomAnchor, constant: 30),
            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            detailsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])

        NSLayoutConstraint.activate([
            detailsStack.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 0),
            detailsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailsStack.heightAnchor.constraint(equalToConstant: 238)
        ])

        NSLayoutConstraint.activate([
            finishButton.topAnchor.constraint(equalTo: detailsStack.bottomAnchor, constant: 15),
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
