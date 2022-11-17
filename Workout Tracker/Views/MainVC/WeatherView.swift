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
        label.text = ""
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionOfTheWeather: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .specialGray
        label.font = .robotoMedium14()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let weatherImage: UIImageView = {
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
        addSubview(weatherImage)
    }

    private func updateLabel(model: WeatherModel) {
        weatherLabel.text = model.weather[0].myDescription + " \(model.main.temperatureCelsius)°C"

        switch model.weather[0].weatherDescription {
        case "clear sky":
            descriptionOfTheWeather.text = "Замечательная погода, чтобы пробежаться за пивом"
        case "few clouds":
            descriptionOfTheWeather.text = "В принципе можешь потренироваться ну или за пивом сходить"
        case "scattered clouds":
            descriptionOfTheWeather.text = "Если тебя не смущают облака можно прогуляться без тренировки"
        case "broken clouds":
            descriptionOfTheWeather.text = "Темные тучи мордора, лучше занимайся дома"
        case "shower rain":
            descriptionOfTheWeather.text = "Самый противный дождь из всех дождей"
        case "rain":
            descriptionOfTheWeather.text = "Дождь из мужиков алилуяяяя"
        case "thunderstorm":
            descriptionOfTheWeather.text = "Гром гремит земля тресется это бывшая жрать несется"
        case "snow":
            descriptionOfTheWeather.text = "На улице падает сверху кокаин, но это обман"
        case "mist":
            descriptionOfTheWeather.text = "Смотрел сериал мгла? Лучше сиди дома..."
        default :
            descriptionOfTheWeather.text = "No data"
        }
    }

    private func updateImage(data: Data) {
        guard let image = UIImage(data: data) else { return }
        weatherImage.image = image
    }

    public func setWeather(model: WeatherModel) {
        updateLabel(model: model)
    }

    public func setImage(data: Data) {
        updateImage(data: data)
    }
}

extension WeatherView {
    private func setConstraints() {

        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weatherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weatherLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            descriptionOfTheWeather.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            descriptionOfTheWeather.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionOfTheWeather.trailingAnchor.constraint(equalTo: weatherImage.leadingAnchor, constant: -10),
            descriptionOfTheWeather.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 0)
        ])

        NSLayoutConstraint.activate([
            weatherImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            weatherImage.heightAnchor.constraint(equalToConstant: 62),
            weatherImage.widthAnchor.constraint(equalToConstant: 62)
        ])
    }
}
