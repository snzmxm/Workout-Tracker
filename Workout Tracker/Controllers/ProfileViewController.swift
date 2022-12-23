//
//  ProfileViewController.swift
//  Workout Tracker
//
//  Created by SNZ on 10.11.2022.
//

import UIKit
import RealmSwift

struct ResultWorkout {
    let name: String
    let result: Int
    let imageData: Data?
}

class ProfileViewController: UIViewController {
    
    //MARK: - Creating Elements
    
    private let profileLabel = UILabel(text: "PROFILE",
                                       font: .robotoMedium24(),
                                       textColor: .specialGray)
    
    private let profileNameLabel = UILabel(text: "Your name",
                                           font: .robotoBold24(),
                                           textColor: .white)
    
    private let userHeightLabel = UILabel(text: "Height: _",
                                          font: .robotoMedium16(),
                                          textColor: .specialGray)
    
    private let userWeightLabel = UILabel(text: "Weight: _",
                                          font: .robotoMedium16(),
                                          textColor: .specialGray)
    
    private let targetLabel = UILabel(text: "TARGET: 0 workouts",
                                      font: .robotoBold16(),
                                      textColor: .specialGray)
    
    private let workoutsNowLabel = UILabel(text: "0",
                                           font: .robotoBold24(),
                                           textColor: .specialGray)
    
    private let workoutsTargetLabel = UILabel(text: "0",
                                              font: .robotoBold24(),
                                              textColor: .specialGray)
    
    private lazy var editingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Editing ", for: .normal)
        button.tintColor = .specialGreen
        button.titleLabel?.font = .robotoMedium16()
        button.setImage(UIImage(named: "editingButton"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editingButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.7607843137, blue: 0.7607843137, alpha: 1)
        imageView.layer.borderWidth = 5
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let backgroundProfileView = UIView(backgroundColor: .specialGreen, cornerRadius: 10)

    private let targetView = UIView(backgroundColor: .specialBrown, cornerRadius: 15)

    //создание коллекции
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionVIew = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionVIew.translatesAutoresizingMaskIntoConstraints = false
        collectionVIew.bounces = false
        collectionVIew.showsHorizontalScrollIndicator = false
        collectionVIew.backgroundColor = .none
        return collectionVIew
    }()
    
    
    private var parametrsLabelStackView = UIStackView()
    private var targetStackView = UIStackView()
    
    private let idProfileCollectionViewCell = "idProfileCollectionViewCell"
    
    private let localRealm = try! Realm()
    private var workoutArray: Results<WorkoutModel>!
    private var userArray: Results<UserModel>!
    
    
    private var resultWorkout = [ResultWorkout]()
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resultWorkout = [ResultWorkout]()
        getWorkoutResults()
        collectionView.reloadData()
        setupUserParameters()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //при загрузке загружаем юзера
        userArray = localRealm.objects(UserModel.self)
        
        setupViews()
        setConstraints()
        setDelegates()
    }
    
    //MARK: - Hierarchy View
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(profileLabel)
        view.addSubview(backgroundProfileView)
        view.addSubview(userPhotoImageView)
        view.addSubview(profileNameLabel)
        
        parametrsLabelStackView = UIStackView(arrangedSubviews: [userHeightLabel, userWeightLabel],
                                              axis: .horizontal,
                                              spacing: 10)
        view.addSubview(parametrsLabelStackView)
        view.addSubview(editingButton)
        view.addSubview(collectionView)
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: idProfileCollectionViewCell)
        
        view.addSubview(targetLabel)
        targetStackView = UIStackView(arrangedSubviews: [workoutsNowLabel, workoutsTargetLabel],
                                      axis: .horizontal,
                                      spacing: 10)
        view.addSubview(targetStackView)
        view.addSubview(targetView)
        view.addSubview(progressView)
    }
    
    //MARK: - Methods
    
    @objc private func editingButtonTapped() {
        let settingViewController = SettingProfileViewController()
        settingViewController.modalPresentationStyle = .fullScreen
        present(settingViewController, animated: true)
    }
    
    
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func getWorkoutsName() -> [String] { //сделать в отдельный файл т.к код повторяется
        
        var nameArray = [String]()
        workoutArray = localRealm.objects(WorkoutModel.self)
        
        for workoutModel in workoutArray {
            if !nameArray.contains(workoutModel.workoutName) {
                nameArray.append(workoutModel.workoutName)
            }
        }
        return nameArray
    }
    
    private func getWorkoutResults() {
        
        let nameArray = getWorkoutsName()
        
        for name in nameArray {
            let predicateName = NSPredicate(format: "workoutName = '\(name)'")
            workoutArray = localRealm.objects(WorkoutModel.self).filter(predicateName).sorted(byKeyPath: "workoutName")
            var result = 0
            var image: Data?
            workoutArray.forEach { model in
                result += model.workoutReps
                image = model.workoutImage
            }
            let resultModel = ResultWorkout(name: name, result: result, imageData: image)
            resultWorkout.append(resultModel)
        }
    }
    
    private func setupUserParameters() {
        
        if userArray.count != 0 {
            profileNameLabel.text = userArray[0].userFirstName + " " + userArray[0].userSecondName
            userHeightLabel.text = "Height: \(userArray[0].userHeight)"
            userWeightLabel.text = "Weight: \(userArray[0].userWeight)"
            targetLabel.text = "TARGET: \(userArray[0].userTarget)"
            workoutsTargetLabel.text = "\(userArray[0].userTarget)"
            
            guard let data = userArray[0].userImage else { return }
            guard let image = UIImage(data: data) else { return }
            userPhotoImageView.image = image
        }
    }
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.trackTintColor = .specialBrown
        progressView.progressTintColor = .specialGreen
        progressView.layer.cornerRadius = 14
        progressView.clipsToBounds = true
        progressView.setProgress(0, animated: false)
        progressView.layer.sublayers?[1].cornerRadius = 14
        progressView.subviews[1].clipsToBounds = true
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
}

//MARK: - UICollectionViewDataSource

extension ProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        resultWorkout.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idProfileCollectionViewCell, for: indexPath) as! ProfileCollectionViewCell
        let model = resultWorkout[indexPath.row]
        cell.cellConfigure(model: model)
        cell.backgroundColor = (indexPath.row % 4 == 0 || indexPath.row % 4 == 3 ? .specialGreen : .specialDarkYellow)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 2.07,
               height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        progressView.setProgress(0.6, animated: true)
    }
}

//MARK: - setConstraints

extension ProfileViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 20),
            userPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            backgroundProfileView.topAnchor.constraint(equalTo: userPhotoImageView.centerYAnchor),
            backgroundProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backgroundProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            backgroundProfileView.heightAnchor.constraint(equalToConstant: 110)
        ])
        
        NSLayoutConstraint.activate([
            profileNameLabel.topAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor, constant: 20),
            profileNameLabel.centerXAnchor.constraint(equalTo: backgroundProfileView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            parametrsLabelStackView.topAnchor.constraint(equalTo: backgroundProfileView.bottomAnchor, constant: 5),
            parametrsLabelStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            editingButton.topAnchor.constraint(equalTo: backgroundProfileView.bottomAnchor, constant: 5),
            editingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: parametrsLabelStackView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            targetLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
            targetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            targetStackView.topAnchor.constraint(equalTo: targetLabel.bottomAnchor, constant: 10),
            targetStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            targetStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            targetView.topAnchor.constraint(equalTo: targetStackView.bottomAnchor, constant: 3),
            targetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            targetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            targetView.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 20),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            progressView.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
}
