//
//  TimerWorkoutViewCell.swift
//  Workout Tracker
//
//  Created by SNZ on 09.11.2022.
//

import UIKit

protocol NextSetTimerProtocol: AnyObject {
    func nextSetTimerTapped()
    func editingTimerTapped()
}

class TimerWorkoutViewCell: UIView {

    //MARK: - Cозадние

    private let nameWorkoutlabel = UILabel(text: "Squats",
                                           font: .robotoMedium24(),
                                           textColor: .specialGray)
    //SETS
    private var setsStackView = UIStackView()
    private let setsLabel = UILabel(text: "Sets",
                                    font: .robotoMedium18(),
                                    textColor: .specialGray)

    private let numberSetsLabel = UILabel(text: "1/4",
                                          font: .robotoMedium24(),
                                          textColor: .specialGray)
    private let setsLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //time of sets
    private var timeOfSetStack = UIStackView()
    private let timeOfSetLabel = UILabel(text: "Time of Set",
                                    font: .robotoMedium18(),
                                    textColor: .specialGray)

    private let numberTimeOfSetLabel = UILabel(text: "1 min 30 sec",
                                          font: .robotoMedium24(),
                                          textColor: .specialGray)
    private let timeOfSetLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //Cоздаем кнопку редактировать
    private lazy var editingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Editing", for: .normal)
        button.tintColor = .specialDarkGreen
        button.titleLabel?.font = .robotoMedium16()
        button.setImage(UIImage(named: "pencil"), for: .normal)
        button.addTarget(self, action: #selector(editingButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc private func editingButtonTapped() {
        cellNextSetTimerDelegate?.editingTimerTapped()
    }

    //add button next set
    lazy var nextSetButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.addShadowOnView()
        button.backgroundColor = .specialYellow
        button.tintColor = .specialDarkGreen
        button.setTitle("NEXT SET", for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextSetButtonTapped), for: .touchUpInside)
        return button
    }()

    weak var cellNextSetTimerDelegate: NextSetTimerProtocol?

    @objc private func nextSetButtonTapped() {
        cellNextSetTimerDelegate?.nextSetTimerTapped()
    }
    //MARK: - Добавление на вью
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView() {
        backgroundColor = .specialBrown
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(nameWorkoutlabel)

        setsStackView = UIStackView(arrangedSubviews: [setsLabel, numberSetsLabel],
                                    axis: .horizontal,
                                    spacing: 10)
        addSubview(setsStackView)
        addSubview(setsLineView)

        timeOfSetStack = UIStackView(arrangedSubviews: [timeOfSetLabel, numberTimeOfSetLabel],
                                    axis: .horizontal,
                                    spacing: 10)
        addSubview(timeOfSetStack)
        addSubview(timeOfSetLineView)
        addSubview(editingButton)
        addSubview(nextSetButton)
    }
}
//MARK: - SetConstrains
extension TimerWorkoutViewCell {

    private func setConstraints() {

        NSLayoutConstraint.activate([
            nameWorkoutlabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameWorkoutlabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            setsStackView.topAnchor.constraint(equalTo: nameWorkoutlabel.bottomAnchor,constant: 10),
            setsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])

        NSLayoutConstraint.activate([
            setsLineView.topAnchor.constraint(equalTo: setsStackView.bottomAnchor, constant: 0),
            setsLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setsLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            setsLineView.heightAnchor.constraint(equalToConstant: 1)
        ])

        NSLayoutConstraint.activate([
            timeOfSetStack.topAnchor.constraint(equalTo: setsLineView.bottomAnchor, constant: 20),
            timeOfSetStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            timeOfSetStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])

        NSLayoutConstraint.activate([
            timeOfSetLineView.topAnchor.constraint(equalTo: timeOfSetStack.bottomAnchor, constant: 0),
            timeOfSetLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            timeOfSetLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            timeOfSetLineView.heightAnchor.constraint(equalToConstant: 1)
        ])

        NSLayoutConstraint.activate([
            editingButton.topAnchor.constraint(equalTo: timeOfSetLineView.bottomAnchor, constant: 5),
            editingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])

        NSLayoutConstraint.activate([
            nextSetButton.topAnchor.constraint(equalTo: editingButton.bottomAnchor, constant: 10),
            nextSetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            nextSetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            nextSetButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
