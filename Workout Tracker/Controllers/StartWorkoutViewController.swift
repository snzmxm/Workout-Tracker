//
//  StartWorkoutViewController.swift
//  Workout Tracker
//
//  Created by SNZ on 09.11.2022.
//

import UIKit

class StartWorkoutViewController: UIViewController {
    
    private let startWorkoutLabel = UILabel(text: "START WORKOUT", font: .robotoMedium24(), textColor: .specialGray)

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var startWorkoutImage = addImage(width: "startWorkout")

    private let detailsLabel = UILabel(text: "Details")

    private let workoutParametersView = StartWorkoutViewCell()

    var workoutModel = WorkoutModel()
    let customAlert = CustomAlert()

    private var numberOfSet = 1

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
        if numberOfSet == workoutModel.workoutSets {
            dismiss(animated: true)
            RealmManager.shared.updateStatusWorkoutModel(model: workoutModel)
        } else {
            alertOkCancel(title: "WARNING", message: "You haven't finished your workout") {
                self.dismiss(animated: true)
            }
        }
    }
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setConstraints()
        setDelegates()
        setWorkoutsParameters()
    }

    private func  setupViews() {
        view.backgroundColor = .specialBackground

        view.addSubview(startWorkoutLabel)
        view.addSubview(closeButton)
        view.addSubview(startWorkoutImage)
        view.addSubview(detailsLabel)
        view.addSubview(workoutParametersView)
        view.addSubview(finishButton)

    }

    private func setDelegates() {
        workoutParametersView.cellNextSetDelegate = self
    }

    private func addImage(width named: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: named)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    private func setWorkoutsParameters() {
        workoutParametersView.nameWorkoutlabel.text = workoutModel.workoutName
        workoutParametersView.numberSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        workoutParametersView.numberRepsLabel.text = "\(workoutModel.workoutReps)"
    }
}
//MARK: - NextSetProtocol
extension StartWorkoutViewController: NextSetProtocol {

    func editingTapped() {
        customAlert.customAlert(viewController: self,
                                repsTimer: "Reps") { [self] sets, reps in
            if sets != "" && reps != "" {
                workoutParametersView.numberSetsLabel.text = "\(numberOfSet)/\(sets)"
                workoutParametersView.numberRepsLabel.text = reps
                guard let numberOfSets = Int(sets),
                      let numberOfReps = Int(reps) else { return }
                RealmManager.shared.updateSetsRepsWorkoutModel(model: workoutModel,
                                                               sets: numberOfSets,
                                                               reps: numberOfReps)
            }
        }
    }

    func nextSetTapped() {
        if numberOfSet < workoutModel.workoutSets {
            numberOfSet += 1
            workoutParametersView.numberSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        } else {
            alertOk(tittle: "ERROR", message: "Finish your workout")
        }
    }
}
//MARK: - setConstraints
extension StartWorkoutViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            startWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            startWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: startWorkoutLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
            
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
            workoutParametersView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5),
            workoutParametersView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            workoutParametersView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            workoutParametersView.heightAnchor.constraint(equalToConstant: 238)
        ])

        NSLayoutConstraint.activate([
            finishButton.topAnchor.constraint(equalTo: workoutParametersView.bottomAnchor, constant: 15),
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
