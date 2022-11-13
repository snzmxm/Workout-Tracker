//
//  TimerWorkoutViewController.swift
//  Workout Tracker
//
//  Created by SNZ on 09.11.2022.
//

import UIKit

class TimerWorkoutViewController: UIViewController {

    //MARK: - создание
    private let startWorkoutLabel = UILabel(text: "START WORKOUT", font: .robotoMedium24(), textColor: .specialGray)

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc private func closeButtonTapped() {
        dismiss(animated: true)
        timer.invalidate()
    }

    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "1:35"
        label.textColor = .specialGray
        label.font = .robotoBold48()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var ellipseImageView = addImage(width: "timerElipse")

    private let detailsLabel = UILabel(text: "Details")

    var workoutModel = WorkoutModel()
    private let customAlert = CustomAlert()

    //Timer
    private var durationTimer = 0
    private var numberOfSet = 0
    private var shapeLayer = CAShapeLayer()
    private var timer = Timer()

    //add button finish
    lazy var finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.addShadowOnView()
        button.backgroundColor = .specialGreen
        button.tintColor = .specialWhite
        button.setTitle("FINISH", for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
        return button
    }()

    @objc private func finishButtonTapped() {
        if numberOfSet == workoutModel.workoutSets {
            dismiss(animated: true)
            RealmManager.shared.updateStatusWorkoutModel(model: workoutModel)
        } else {
            alertOkCancel(title: "WARNING",
                          message: "You haven't finished your workout") {
                self.dismiss(animated: true)
            }
        }
    }

    private let timerWorkoutParametersView = TimerWorkoutViewCell()

    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius = closeButton.frame.height / 2

        animationCircular()
    }

    //MARK: - Добавление на вью
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setConstraints()
        setDelegates()
        addTaps()
        setWorkoutParameters()
    }

    //Добавление на главный экран(вью)
    private func setupViews() {
        view.backgroundColor = .specialBackground

        view.addSubview(startWorkoutLabel)
        view.addSubview(closeButton)
        view.addSubview(ellipseImageView)
        view.addSubview(timerLabel)
        view.addSubview(detailsLabel)
        view.addSubview(timerWorkoutParametersView)
        view.addSubview(finishButton)
    }

    //MARK: - Medots
    private func addImage(width named: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: named)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    private func setDelegates() {
        timerWorkoutParametersView.cellNextSetTimerDelegate = self
    }

    private func addTaps() {
        let tapLabel = UITapGestureRecognizer(target: self, action: #selector(startTimer))
        timerLabel.isUserInteractionEnabled = true
        timerLabel.addGestureRecognizer(tapLabel)
    }

    @objc private func startTimer() {
        timerWorkoutParametersView.editingButton.isEnabled = false
        timerWorkoutParametersView.nextSetButton.isEnabled = false

        if numberOfSet == workoutModel.workoutSets {
            alertOk(tittle: "Error", message: "Finish your workout")
        } else {
            basicAnimation()
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(timerAction),
                                         userInfo: nil,
                                         repeats: true)
        }
    }

    @objc private func timerAction() {
        durationTimer -= 1
        print(durationTimer)

        if durationTimer == 0 {
            timer.invalidate()
            durationTimer = workoutModel.workoutTimer

            numberOfSet += 1
            timerWorkoutParametersView.numberSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"

            timerWorkoutParametersView.editingButton.isEnabled = true
            timerWorkoutParametersView.nextSetButton.isEnabled = true
        }
        let (min, sec) = durationTimer.convertSeconds()
        timerLabel.text = "\(min):\(sec.setZeroForSecond())"
    }
    private func setWorkoutParameters() {
        timerWorkoutParametersView.nameWorkoutlabel.text = workoutModel.workoutName
        timerWorkoutParametersView.numberSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"

        let(min, sec) = workoutModel.workoutTimer.convertSeconds()
        timerWorkoutParametersView.numberOfTimerLabel.text = "\(min) min \(sec) sec"

        timerLabel.text = "\(min):\(sec.setZeroForSecond())"
        durationTimer = workoutModel.workoutTimer
    }
}
//MARK: - Animation timer
extension TimerWorkoutViewController {
    private func animationCircular() {

        let center = CGPoint(x: ellipseImageView.frame.width / 2,
                             y: ellipseImageView.frame.height / 2)
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle

        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: 127,//поменять под разные экраны
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: false )

        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 21
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = .round
        shapeLayer.strokeColor = UIColor.specialGreen.cgColor
        ellipseImageView.layer.addSublayer(shapeLayer)
    }

    private func basicAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(durationTimer)
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
}
//MARK: - NextSetTimerProtocol

extension TimerWorkoutViewController: NextSetTimerProtocol {

    func nextSetTimerTapped() {
        if numberOfSet < workoutModel.workoutSets {
            numberOfSet += 1
            timerWorkoutParametersView.numberSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        } else {
            alertOk(tittle: "ERROR", message: "Finish your workout")
        }
    }

    func editingTimerTapped() {
        customAlert.customAlert(viewController: self,
                                repsTimer: "Timer of set") { [self] sets, timerOfSet in
            if sets != "" && timerOfSet != "" {
                guard let numberOfSets = Int(sets) else { return }
                guard let numberOfTimer = Int(timerOfSet) else { return }
                let (min, sec) = numberOfTimer.convertSeconds()
                timerWorkoutParametersView.numberSetsLabel.text = "\(numberOfSet)/\(sets)"
                timerWorkoutParametersView.numberOfTimerLabel.text = "\(min) min \(sec) sec"
                timerLabel.text = "\(min):\(sec.setZeroForSecond())"
                durationTimer = numberOfTimer
                RealmManager.shared.updateSetsTimerWorkoutModel(model: workoutModel,
                                                                sets: numberOfSets,
                                                                timer: numberOfTimer)
            }
        }
    }
}

//MARK: - SetConstrains
extension TimerWorkoutViewController {

    private func setConstraints() {

        NSLayoutConstraint.activate([
            startWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])

        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: startWorkoutLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            ellipseImageView.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 20),
            ellipseImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ellipseImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            ellipseImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])

        NSLayoutConstraint.activate([
            timerLabel.leadingAnchor.constraint(equalTo: ellipseImageView.leadingAnchor, constant: 40),
            timerLabel.trailingAnchor.constraint(equalTo: ellipseImageView.trailingAnchor, constant: -40),
            timerLabel.centerYAnchor.constraint(equalTo: ellipseImageView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: ellipseImageView.bottomAnchor, constant: 30),
            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            detailsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        //        NSLayoutConstraint.activate([
        //            detailsStack.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 0),
        //            detailsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        //            detailsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        //            detailsStack.heightAnchor.constraint(equalToConstant: 238)
        //        ])

        NSLayoutConstraint.activate([
            timerWorkoutParametersView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5),
            timerWorkoutParametersView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timerWorkoutParametersView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timerWorkoutParametersView.heightAnchor.constraint(equalToConstant: 230)
        ])

        NSLayoutConstraint.activate([
            finishButton.topAnchor.constraint(equalTo: timerWorkoutParametersView.bottomAnchor, constant: 20),
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])

    }
}

