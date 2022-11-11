//
//  WorkoutTableViewCell.swift
//  Workout Tracker
//
//  Created by SNZ on 06.11.2022.
//

import UIKit

protocol StartWorkoutProtocol: AnyObject {
    func startButtonTaped(model: WorkoutModel)
}

class WorkoutTableViewCell: UITableViewCell {

    private let backgroundCell: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .specialBrown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let workoutBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBackground
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let workoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "biceps")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let workoutNameLabel = UILabel(text: "Pull Ups",
                                           font: .robotoMedium22(),
                                           textColor: .specialBlack)

    private let workoutRepsLabel = UILabel(text: "Reps: 10",
                                           font: .robotoMedium16(),
                                           textColor: .specialGray)

    private let workoutSetsLabel = UILabel(text: "Sets: 2",
                                           font: .robotoMedium16(),
                                           textColor: .specialGray)

    //add button
    lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.addShadowOnView()
        button.titleLabel?.font = .robotoBold16()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()

    var labelStackView = UIStackView()

    var workoutModel = WorkoutModel()
    weak var cellStartWorkoutDelegate: StartWorkoutProtocol?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none

        addSubview(backgroundCell)
        addSubview(workoutBackgroundView)
        workoutBackgroundView.addSubview(workoutImageView)
        addSubview(workoutNameLabel)

        labelStackView = UIStackView(arrangedSubviews: [workoutRepsLabel, workoutSetsLabel],
                                     axis: .horizontal,
                                     spacing: 10)
        addSubview(labelStackView)
        contentView.addSubview(startButton)
    }

    @objc private func startButtonTapped() {
        cellStartWorkoutDelegate?.startButtonTaped(model: workoutModel)
    }
    //получаем модель и раскидываем по лейблам
    func cellConfigure(model: WorkoutModel) {

        workoutModel = model
        
        workoutNameLabel.text = model.workoutName

        let (min, sec) = { (secs: Int) -> (Int, Int) in
            return (secs / 60, secs % 60)}(Int(model.workoutTimer))

        workoutSetsLabel.text = "Sets: \(model.workoutSets)"
        workoutRepsLabel.text = model.workoutTimer == 0 ? "Reps: \(model.workoutReps)" : "Timer: \(min) min \(sec) sec"

        //если тренировка завершена делаем кнопку начала тренировки не активной
        if model.workoutStatus {
            startButton.setTitle("COMPLETE", for: .normal)
            startButton.tintColor = .white
            startButton.backgroundColor = .specialGreen
            startButton.isEnabled = false
        } else {
            startButton.setTitle("START", for: .normal)
            startButton.tintColor = .specialDarkGreen
            startButton.backgroundColor = .specialYellow
            startButton.isEnabled = true
        }

        guard let imageData = model.workoutImage else { return }
        guard let image = UIImage(data: imageData) else { return }

        workoutImageView.image = image.withRenderingMode(.alwaysTemplate)
    }
}

extension WorkoutTableViewCell {
    private func setConstraints() {

        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])

        NSLayoutConstraint.activate([
            workoutBackgroundView.centerYAnchor.constraint(equalTo: backgroundCell.centerYAnchor),
            workoutBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            workoutBackgroundView.heightAnchor.constraint(equalToConstant: 70),
            workoutBackgroundView.widthAnchor.constraint(equalToConstant: 70)
        ])

        NSLayoutConstraint.activate([
            workoutImageView.topAnchor.constraint(equalTo: workoutBackgroundView.topAnchor, constant: 10),
            workoutImageView.leadingAnchor.constraint(equalTo: workoutBackgroundView.leadingAnchor, constant: 10),
            workoutImageView.trailingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: -10),
            workoutImageView.bottomAnchor.constraint(equalTo: workoutBackgroundView.bottomAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            workoutNameLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 5),
            workoutNameLabel.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
            workoutNameLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 0),
            labelStackView.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
            labelStackView.heightAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 5),
            startButton.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
            startButton.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            startButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
