//
//  MainTabBarController.swift
//  Workout Tracker
//
//  Created by SNZ on 06.11.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTubBar()
        setupViews()
    }

    private func setupTubBar() {
        tabBar.backgroundColor = .specialTabBar
        tabBar.tintColor = .specialDarkGreen
        tabBar.unselectedItemTintColor = .specialGray
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.specialLightBrown.cgColor
    }

    private func setupViews() {
        let mainVC = MainViewController()
        let statisticVC = StatisticsViewController()
        let profileVC = ProfileViewController()

        setViewControllers([mainVC, statisticVC, profileVC], animated: true)
        guard let items = tabBar.items else { return }

        items[0].title = "Main"
        items[1].title = "Statistic"
        items[2].title = "Profile"

        items[0].image = UIImage(named: "mainTabBar")
        items[1].image = UIImage(named: "statisticTabBar")
        items[2].image = UIImage(named: "profileTabBar")

        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(name: "Roboto-Bold", size: 12) as Any],
                                                         for: .normal)
    }
}
