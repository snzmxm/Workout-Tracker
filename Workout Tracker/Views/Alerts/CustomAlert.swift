//
//  CustomAlert.swift
//  Workout Tracker
//
//  Created by SNZ on 12.11.2022.
//

import UIKit

class CustomAlert {

    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()

    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBackground
        view.layer.cornerRadius = 20
        return view
    }()

    private let scrollView = UIScrollView()

    private var mainView: UIView?

    private let setTextField = UITextField()
    private let repsTextField = UITextField()

    private var buttonAction: ( (String, String) ->Void )?

    func customAlert(viewController: UIViewController,
                     repsTimer: String,
                     completion: @escaping (String, String) -> Void) {

        registerForKeyboardNotification()

        guard let parentView = viewController.view else { return }
        mainView = parentView

        scrollView.frame = parentView.frame
        parentView.addSubview(scrollView)

        backgroundView.frame = parentView.frame
        scrollView.addSubview(backgroundView)
        //распологаем прям на 0 позиции нашей главной вью, чтобы он выезжал сверху вниз
        alertView.frame = CGRect(
            x: 40,
            y: -420,
            width: parentView.frame.width - 80,
            height: 420)
        scrollView.addSubview(alertView)

        let sportsmanImageView = UIImageView(frame: CGRect(
            x: (alertView.frame.width - alertView.frame.height * 0.4) / 2,
            y: 30,
            width: alertView.frame.height * 0.4,
            height: alertView.frame.height * 0.4))
        sportsmanImageView.image = UIImage(named: "sportsmanAlert")
        sportsmanImageView.contentMode = .scaleAspectFit
        alertView.addSubview(sportsmanImageView)

        let editingLabel = UILabel(frame: CGRect(
            x: 10,
            y: alertView.frame.height * 0.4 + 50,
            width: alertView.frame.width - 20,
            height: 25))

        editingLabel.text = "Editing"
        editingLabel.textAlignment = .center
        editingLabel.font = .robotoMedium22()
        alertView.addSubview(editingLabel)

        let setsLabel = UILabel(text: "Sets")
        setsLabel.translatesAutoresizingMaskIntoConstraints = true
        setsLabel.frame = CGRect(
            x: 30,
            y: editingLabel.frame.maxY + 10,
            width: alertView.frame.width - 60,
            height: 20)
        alertView.addSubview(setsLabel)

        setTextField.frame = CGRect(
            x: 20,
            y: setsLabel.frame.maxY,
            width: alertView.frame.width - 40,
            height: 30)

        setTextField.backgroundColor = .specialBrown
        setTextField.layer.cornerRadius = 10
        setTextField.borderStyle = .none
        setTextField.font = .robotoBold20()
        setTextField.leftView = UIView(frame: CGRect(x: 0,
                                                     y: 0,
                                                     width: 15,
                                                     height: setsLabel.frame.height))
        setTextField.leftViewMode = .always
        setTextField.clearButtonMode = .always
        setTextField.returnKeyType = .done
        setTextField.keyboardType = .numberPad
        alertView.addSubview(setTextField)

        let repsOrTimerLabel = UILabel(text: repsTimer)
        repsOrTimerLabel.translatesAutoresizingMaskIntoConstraints = true
        repsOrTimerLabel.frame = CGRect(
            x: 30,
            y: setTextField.frame.maxY + 3,
            width: alertView.frame.width - 60,
            height: 20)
        alertView.addSubview(repsOrTimerLabel)

        repsTextField.frame = CGRect(
            x: 20,
            y: repsOrTimerLabel.frame.maxY,
            width: alertView.frame.width - 40,
            height: 30)

        repsTextField.backgroundColor = .specialBrown
        repsTextField.layer.cornerRadius = 10
        repsTextField.borderStyle = .none
        repsTextField.font = .robotoBold20()
        repsTextField.leftView = UIView(frame: CGRect(x: 0,
                                                      y: 0,
                                                      width: 15,
                                                      height: setsLabel.frame.height))
        repsTextField.leftViewMode = .always
        repsTextField.clearButtonMode = .always
        repsTextField.returnKeyType = .done
        repsTextField.keyboardType = .numberPad
        alertView.addSubview(repsTextField)

        let okButton = UIButton(frame: CGRect(
            x: 50,
            y: repsTextField.frame.maxY + 15,
            width: alertView.frame.width - 100,
            height: 35))
        okButton.backgroundColor = .specialGreen
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.textColor = .white
        okButton.titleLabel?.font = .robotoMedium18()
        okButton.layer.cornerRadius = 10
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        alertView.addSubview(okButton)

        buttonAction = completion

        UIView.animate(withDuration: 0.3) {
            self.backgroundView.alpha = 0.8
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.3) {
                    self.alertView.center = parentView.center
                }
            }
        }
    }

    @objc private func okButtonTapped() {

        guard let setsNumber = setTextField.text else { return }
        guard let repsNumber = repsTextField.text else { return }
        buttonAction?(setsNumber, repsNumber)

        guard let targetView = mainView else { return }

        UIView.animate(withDuration: 0.3) {
            self.alertView.frame = CGRect(
                x: 40,
                y: targetView.frame.height,
                width: targetView.frame.width - 80,
                height: 420)
        } completion: { done in
            UIView.animate(withDuration: 0.3) {
                self.backgroundView.alpha = 0
            } completion: { done in
                if done {
                    self.alertView.removeFromSuperview()
                    self.backgroundView.removeFromSuperview()
                    self.scrollView.removeFromSuperview()
                    self.repsTextField.text = ""
                    self.setTextField.text = ""
                    self.removeForKeyboardNotification()
                }
            }
        }
    }
    //при открытии клавиатуры алерт уезжал наверх
    private func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbHideShow),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    //Удаляем из памяти
    private func removeForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }

    @objc private func kbWillShow() {
        scrollView.contentOffset = CGPoint(x: 0, y: 100)
    }

    @objc private func kbHideShow() {
        scrollView.contentOffset = CGPoint.zero
    }
}
