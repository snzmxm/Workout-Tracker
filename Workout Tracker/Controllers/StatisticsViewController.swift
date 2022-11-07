//
//  StatisticsViewController.swift
//  Workout Tracker
//
//  Created by SNZ on 06.11.2022.
//

import UIKit

class StatisticsViewController: UIViewController {

    private let statisticsLabel = UILabel(text: "STATISTICS", font: .robotoBold24(), textColor: .specialGray)

    private let exercisesLabel = UILabel(text: "Exercises")

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.delaysContentTouches = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Week", "Month"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .specialGreen
        segmentedControl.selectedSegmentTintColor = .specialYellow
        let font = UIFont(name: "Roboto-Medium", size: 16)
        segmentedControl.setTitleTextAttributes([.font: font as Any,
                                                 .foregroundColor: UIColor.white],
                                                for: .normal)
        segmentedControl.setTitleTextAttributes([.font: font as Any,
                                                 .foregroundColor: UIColor.specialGray],
                                                for: .selected)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentedChange), for: .valueChanged)
        return segmentedControl
    }()

    private let idWorkoutTableVIewCell = "idWorkoutTableVIewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setConstraints()
        setDelegates()
    }

    //Добавление на главный экран(вью)
    private func setupViews() {
        view.backgroundColor = .specialBackground

        view.addSubview(statisticsLabel)
        view.addSubview(segmentedControl)
        view.addSubview(exercisesLabel)

        view.addSubview(tableView)
        tableView.register(StatisticsTableViewCell.self, forCellReuseIdentifier: idWorkoutTableVIewCell)
    }

    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    @objc private func segmentedChange() {
        if segmentedControl.selectedSegmentIndex == 0 {
            print("Week")
        } else {
            print("Month")
        }
    }
}

//MARK: - UITableViewDataSource

extension StatisticsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idWorkoutTableVIewCell, for: indexPath) as?
                StatisticsTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
    //MARK: - UITableViewDataSource

    extension StatisticsViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 55
        }
    }
    //MARK: - SetConstrains

    extension StatisticsViewController {
        private func setConstraints() {

            NSLayoutConstraint.activate([
                statisticsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                statisticsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])

            NSLayoutConstraint.activate([
                segmentedControl.topAnchor.constraint(equalTo: statisticsLabel.bottomAnchor, constant: 10),
                segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])

            NSLayoutConstraint.activate([
                exercisesLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
                exercisesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                exercisesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])

            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: exercisesLabel.bottomAnchor, constant: 0),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
        }
    }

