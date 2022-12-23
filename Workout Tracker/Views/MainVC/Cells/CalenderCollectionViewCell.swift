//
//  CalenderCollectionViewCell.swift
//  Workout Tracker
//
//  Created by SNZ on 05.11.2022.
//

import UIKit

class CalenderCollectionViewCell: UICollectionViewCell {

    //MARK: - Creating Elements
    
    private let dayOfWeekLabel = UILabel(text: "We",
                                         font: .robotoBold16(),
                                         textColor: .white,
                                         textAlignment: .center)

    private let numberOfDayLabel = UILabel(text: "05",
                                           font: .robotoBold20(),
                                           textColor: .white,
                                           textAlignment: .center)

    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                backgroundColor = .specialYellow
                layer.cornerRadius = 10
                dayOfWeekLabel.textColor = .specialBlack
                numberOfDayLabel.textColor = .specialDarkGreen
            } else {
                backgroundColor = .specialGreen
                dayOfWeekLabel.textColor = .white
                numberOfDayLabel.textColor = .white
            }
        }
    }

    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Hierarchy View

    private func setupViews() {
        addSubview(dayOfWeekLabel)
        addSubview(numberOfDayLabel)
    }

    //MARK: - Methods
    
    //Формирование ячейки
    private func cellConfigure(numberOfDay: String, dayOfWeek: String) {
        numberOfDayLabel.text = numberOfDay
        dayOfWeekLabel.text = dayOfWeek
    }

    public func dateForCell(numberOfDay: String, dayOfWeek: String) {
        cellConfigure(numberOfDay: numberOfDay, dayOfWeek: dayOfWeek)
    }
}

//MARK: - setConstrains

extension CalenderCollectionViewCell {

    private func setConstraints() {

        NSLayoutConstraint.activate([
            dayOfWeekLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dayOfWeekLabel.topAnchor.constraint(equalTo: topAnchor, constant: 7)
        ])

        NSLayoutConstraint.activate([
            numberOfDayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberOfDayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
