//
//  WeatherView.swift
//  Workout Tracker
//
//  Created by SNZ on 04.11.2022.
//

import UIKit

class WeatherView: UIView {

    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "Солнечно"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionOfTheWeather: UILabel = {
        let label = UILabel()
        label.text = "Хорошая погода, чтобы позаниматься на улице"
        label.textColor = .specialGray
        label.font = .robotoMedium14()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let weatherSun: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "weatherSun")
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
        backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(weatherLabel)
        addSubview(descriptionOfTheWeather)
        addSubview(weatherSun)
    }
}

extension WeatherView {
    private func setConstraints() {

        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            weatherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weatherLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            descriptionOfTheWeather.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            descriptionOfTheWeather.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionOfTheWeather.trailingAnchor.constraint(equalTo: weatherSun.leadingAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            weatherSun.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherSun.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            weatherSun.heightAnchor.constraint(equalToConstant: 62),
            weatherSun.widthAnchor.constraint(equalToConstant: 62)
        ])
    }
}
