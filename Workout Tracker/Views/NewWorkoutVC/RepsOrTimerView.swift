//
//  RepsOrTimerView.swift
//  Workout Tracker
//
//  Created by SNZ on 07.11.2022.
//

import UIKit

class RepsOrTimerView: UIView {

    private let setsLabel = UILabel(text: "Sets",
                                    font: .robotoMedium18(),
                                    textColor: .specialGray)
    
    private let numberSetsLabel = UILabel(text: "0",
                                          font: .robotoMedium24(),
                                    textColor: .specialGray)

    private let repsLabel = UILabel(text: "Reps",
                                    font: .robotoMedium18(),
                                    textColor: .specialGray)

    private let numberRepsLabel = UILabel(text: "0",
                                    font: .robotoMedium24(),
                                    textColor: .specialGray)

    private let timerLabel = UILabel(text: "Timer",
                                    font: .robotoMedium18(),
                                     textColor: .specialGray)

    private let timerTimeLabel = UILabel(text: "0 min",
                                    font: .robotoMedium24(),
                                    textColor: .specialGray)

    private let chooseLabel = UILabel(text: "Choose repeat or timer")

    private lazy var setsSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.minimumTrackTintColor = .specialGreen
        slider.maximumTrackTintColor = .specialLine
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(setsChangeValueSlider), for: .valueChanged)
        return slider
    }()

    private lazy var repsSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.minimumTrackTintColor = .specialGreen
        slider.maximumTrackTintColor = .specialLine
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(repsChangeValueSlider), for: .valueChanged)
        return slider
    }()

    private lazy var timerSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 600
        slider.minimumTrackTintColor = .specialGreen
        slider.maximumTrackTintColor = .specialLine
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(timerChangeValueSlider), for: .valueChanged)
        return slider
    }()

    private var setsStackView = UIStackView()
    private var repsStackView = UIStackView()
    private var timerStackView = UIStackView()

    @objc private func setsChangeValueSlider() {
        numberSetsLabel.text = "\(Int(setsSlider.value))"
    }

    @objc private func repsChangeValueSlider() {
        numberRepsLabel.text = "\(Int(repsSlider.value))"

        setNegative(label: timerLabel, numberLabel: timerTimeLabel, slider: timerSlider)
        setActive(label: repsLabel, numberLabel: numberRepsLabel, slider: repsSlider)
    }

    @objc private func timerChangeValueSlider() {
        let (min, sec) = { (secs: Int) -> (Int, Int) in
            return (secs / 60, secs % 60)}(Int(timerSlider.value))

        timerTimeLabel.text = (sec != 0 ? "\(min) min \(sec) sec" : "\(min) min")
//        timerTimeLabel.text = (min != 0 ? "\(min) min \(sec) sec" : "\(sec) sec")

        setNegative(label: repsLabel, numberLabel: numberRepsLabel, slider: repsSlider)
          setActive(label: timerLabel, numberLabel: timerTimeLabel, slider: timerSlider)
    }

    private func setNegative(label: UILabel, numberLabel: UILabel, slider: UISlider) {
        label.alpha = 0.5
        numberLabel.alpha = 0.5
        numberLabel.text = "0"
        slider.alpha = 0.5
        slider.value = 0
    }

    private func setActive(label: UILabel, numberLabel: UILabel, slider: UISlider) {
        label.alpha = 1
        numberLabel.alpha = 1
        slider.alpha = 1
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .specialBrown
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false

        setsStackView = UIStackView(arrangedSubviews: [setsLabel, numberSetsLabel],
                                    axis: .horizontal,
                                    spacing: 10)
        addSubview(setsStackView)
        addSubview(setsSlider)
        addSubview(chooseLabel)

        repsStackView = UIStackView(arrangedSubviews: [repsLabel, numberRepsLabel],
                                    axis: .horizontal,
                                    spacing: 10)
        addSubview(repsStackView)
        addSubview(repsSlider)

        timerStackView = UIStackView(arrangedSubviews: [timerLabel, timerTimeLabel],
                                     axis: .horizontal,
                                     spacing: 10)
        addSubview(timerStackView)
        addSubview(timerSlider)
    }

    private func getSliderValue() -> (Int, Int, Int) {
        let setsSliderValue = Int(setsSlider.value)
        let repsSliderValue = Int(repsSlider.value)
        let timerSliderValue = Int(timerSlider.value)
        return (setsSliderValue, repsSliderValue, timerSliderValue)
    }

    public func setSliderValue() -> (Int, Int, Int) {
        getSliderValue()
    }
}

extension RepsOrTimerView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            setsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            setsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])

        NSLayoutConstraint.activate([
            setsSlider.topAnchor.constraint(equalTo: setsStackView.bottomAnchor, constant: 10),
            setsSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setsSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])

        NSLayoutConstraint.activate([
            chooseLabel.topAnchor.constraint(equalTo: setsSlider.bottomAnchor, constant: 10),
            chooseLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            repsStackView.topAnchor.constraint(equalTo: chooseLabel.bottomAnchor, constant: 10),
            repsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])

        NSLayoutConstraint.activate([
            repsSlider.topAnchor.constraint(equalTo: repsStackView.bottomAnchor, constant: 10),
            repsSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])

        NSLayoutConstraint.activate([
            timerStackView.topAnchor.constraint(equalTo: repsSlider.bottomAnchor, constant: 10),
            timerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            timerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])

        NSLayoutConstraint.activate([
            timerSlider.topAnchor.constraint(equalTo: timerStackView.bottomAnchor, constant: 10),
            timerSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            timerSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
