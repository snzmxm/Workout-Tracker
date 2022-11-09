//
//  StartWorkoutViewCell.swift
//  Workout Tracker
//
//  Created by SNZ on 09.11.2022.
//

import UIKit

class StartWorkoutViewCell: UIView {

    //MARK: - Cозадние

    private let nameWorkoutlabel = UILabel(text: "Biceps",
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
    //REPS
    private var repsStackView = UIStackView()
    private let repsLabel = UILabel(text: "Reps",
                                    font: .robotoMedium18(),
                                    textColor: .specialGray)

    private let numberRepsLabel = UILabel(text: "20",
                                          font: .robotoMedium24(),
                                          textColor: .specialGray)
    private let repsLineView: UIView = {
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
        print("editingButtonTapped")
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

    @objc private func nextSetButtonTapped() {
        print("nextSetButtonTapped")
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

        repsStackView = UIStackView(arrangedSubviews: [repsLabel, numberRepsLabel],
                                    axis: .horizontal,
                                    spacing: 10)
        addSubview(repsStackView)
        addSubview(repsLineView)
        addSubview(editingButton)
        addSubview(nextSetButton)
    }
}
//MARK: - SetConstrains
extension StartWorkoutViewCell {

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
            repsStackView.topAnchor.constraint(equalTo: setsLineView.bottomAnchor, constant: 20),
            repsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])

        NSLayoutConstraint.activate([
            repsLineView.topAnchor.constraint(equalTo: repsStackView.bottomAnchor, constant: 0),
            repsLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            repsLineView.heightAnchor.constraint(equalToConstant: 1)
        ])

        NSLayoutConstraint.activate([
            editingButton.topAnchor.constraint(equalTo: repsLineView.bottomAnchor, constant: 5),
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