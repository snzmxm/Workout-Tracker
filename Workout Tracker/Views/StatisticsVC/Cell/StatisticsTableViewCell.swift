//
//  StatisticsTableViewCell.swift
//  Workout Tracker
//
//  Created by SNZ on 06.11.2022.
//

import UIKit

class StatisticsTableViewCell: UITableViewCell {

    private let nameWorkoutLabel = UILabel(text: "Biceps", font: .robotoMedium24(), textColor: .specialGray, textAlignment: .left)

    private let beforeLabel = UILabel(text: "Before: 18")
    private let nowLabel = UILabel(text: "Now: 20")

    private let differenceLabel = UILabel(text: "+2", font: .robotoMedium24(), textColor: .specialGreen, textAlignment: .right)

    private var labelStackView = UIStackView()

    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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

        addSubview(nameWorkoutLabel)

        labelStackView = UIStackView(arrangedSubviews: [beforeLabel, nowLabel],
                                axis: .horizontal,
                                spacing: 10)
        addSubview(labelStackView)
        addSubview(differenceLabel)
        addSubview(lineView)
    }
}

extension StatisticsTableViewCell {
    private func setConstraints() {

        NSLayoutConstraint.activate([
            nameWorkoutLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            nameWorkoutLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameWorkoutLabel.trailingAnchor.constraint(equalTo: differenceLabel.leadingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: nameWorkoutLabel.bottomAnchor, constant: 0),
            labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            differenceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            differenceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            differenceLabel.widthAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
