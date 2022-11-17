//
//  NewWorkoutViewController.swift
//  Workout Tracker
//
//  Created by SNZ on 07.11.2022.
//

import UIKit

class NewWorkoutViewController: UIViewController {
    
    private let newWorkoutLabel = UILabel(text: "NEW WORKOUT", font: .robotoMedium24(), textColor: .specialGray)
    
    private let nameLabel = UILabel(text: "Name")
    private let dateAndRepeatLabel = UILabel(text: "Date and repeat")
    private let repsOrTimerLabel = UILabel(text: "Reps or timer")
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .specialBrown
        textField.layer.cornerRadius = 10
        textField.borderStyle = .none
        textField.font = .robotoBold20()
        textField.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 15,
                                                  height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialGreen
        button.layer.cornerRadius = 10
        button.setTitle("SAVE", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .robotoBold16()
        button.addShadowOnView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let dateAndRepeatStackView = DateAndRepeatView()
    private let repsOrTimerStavkView = RepsOrTimerView()
    
    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius = closeButton.frame.width / 2
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegates()
        addTaps()
    }
    
    //Добавление на главный экран(вью)
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(newWorkoutLabel)
        view.addSubview(closeButton)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(dateAndRepeatLabel)
        view.addSubview(dateAndRepeatStackView)
        view.addSubview(repsOrTimerLabel)
        view.addSubview(repsOrTimerStavkView)
        view.addSubview(saveButton)
    }
    
    private func setDelegates() {
        nameTextField.delegate = self
    }

    private func addTaps() {
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapScreen)

        let swipeScreen = UISwipeGestureRecognizer(target: self, action: #selector(swipeHideKeyboard))
        view.addGestureRecognizer(swipeScreen)
        swipeScreen.cancelsTouchesInView = false
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }

    @objc private func swipeHideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        setModel()
        saveModel()
    }
    
    private var workoutModel = WorkoutModel()
    private let testImage = UIImage(named: "biceps")
    
    //метод, который собирает все данные для нашей модели
    private func setModel() {
        guard let nameWorkout = nameTextField.text else { return }
        workoutModel.workoutName = nameWorkout
        
        let dateFromPicker = dateAndRepeatStackView.setDateAndRepeat().0
        workoutModel.workoutDate = dateFromPicker
        workoutModel.workoutNumberOfDay = dateFromPicker.getWeekdayNumber()
        
        workoutModel.workoutRepeat = dateAndRepeatStackView.setDateAndRepeat().1
        //получаем значение 3-х слайдеров
        workoutModel.workoutSets = repsOrTimerStavkView.setSliderValue().0
        workoutModel.workoutReps = repsOrTimerStavkView.setSliderValue().1
        workoutModel.workoutTimer = repsOrTimerStavkView.setSliderValue().2

        guard let imageData = testImage?.pngData() else { return }
        workoutModel.workoutImage = imageData
    }

    private func saveModel() {
        guard let text = nameTextField.text else { return }
        let count = text.filter { $0.isNumber || $0.isLetter }.count

        if count != 0 &&
            workoutModel.workoutSets != 0 &&
            (workoutModel.workoutReps != 0 || workoutModel.workoutTimer != 0) {
            RealmManager.shared.saveWorkoutModel(model: workoutModel)
            createNotifications()
            workoutModel = WorkoutModel()
            refreshObjects()
            alertOk(tittle: "SUCCESS", message: nil)
        } else {
            alertOk(tittle: "ERROR", message: "Enter all paremeters")
        }
    }

    //Значения в исходное
    private func refreshObjects() {
        dateAndRepeatStackView.refreshDatePickerAndSwitch()
        repsOrTimerStavkView.refreshLabelsAndSliders()
        nameTextField.text = ""
    }

    private func createNotifications() {
        let notifications = Notifications()
        let stringDate = workoutModel.workoutDate.ddMMyyyyFromDate()
        //тренировки, которые были созданы сегодня были с индентификатором "название тренировки + дата"
        notifications.scheduleDateNotification(date: workoutModel.workoutDate, id: "workout" + stringDate)

    }
}
//MARK: - UITextViewDelegate
extension NewWorkoutViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
    }
}
//MARK: - SetConstrains

extension NewWorkoutViewController {
    private func setConstraints() {

        NSLayoutConstraint.activate([
            newWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            newWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: newWorkoutLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: newWorkoutLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 38)
        ])

        NSLayoutConstraint.activate([
            dateAndRepeatLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            dateAndRepeatLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            dateAndRepeatLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])

        NSLayoutConstraint.activate([
            dateAndRepeatStackView.topAnchor.constraint(equalTo: dateAndRepeatLabel.bottomAnchor, constant: 3),
            dateAndRepeatStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateAndRepeatStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateAndRepeatStackView.heightAnchor.constraint(equalToConstant: 93)
        ])

        NSLayoutConstraint.activate([
            repsOrTimerLabel.topAnchor.constraint(equalTo: dateAndRepeatStackView.bottomAnchor, constant: 20),
            repsOrTimerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            repsOrTimerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            repsOrTimerStavkView.topAnchor.constraint(equalTo: repsOrTimerLabel.bottomAnchor, constant: 3),
            repsOrTimerStavkView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repsOrTimerStavkView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            repsOrTimerStavkView.heightAnchor.constraint(equalToConstant: 275)
        ])

        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: repsOrTimerStavkView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
