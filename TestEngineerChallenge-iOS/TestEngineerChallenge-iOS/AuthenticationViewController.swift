//
//  ViewController.swift
//  TestEngineerChallenge-iOS
//
//  Created by Daniel Krofchick on 2021-08-06.
//

import UIKit

class AuthenticationViewController: UIViewController {
    private let heading = UILabel()
    private let username = UITextField()
    private let password = UITextField()
    private let submit = UIButton(type: .system)
    private let authenticator = Authenticator()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.accessibilityIdentifier = "authentication"
        navigationItem.backButtonTitle = "Logout"

        heading.text = "Sign-Up"
        heading.font = UIFont.systemFont(ofSize: 50)

        username.placeholder = "Username"
        username.font = UIFont.systemFont(ofSize: 30)
        username.layer.cornerRadius = 5
        username.backgroundColor = .init(white: 0.95, alpha: 1)
        username.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        username.accessibilityIdentifier = "username"
        username.delegate = self

        password.placeholder = "Pasword"
        password.font = UIFont.systemFont(ofSize: 30)
        password.layer.cornerRadius = 5
        password.backgroundColor = .init(white: 0.95, alpha: 1)
        password.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        password.accessibilityIdentifier = "password"
        password.delegate = self

        submit.setTitle("Submit", for: .normal)
        submit.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        submit.layer.cornerRadius = 5
        submit.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        submit.addTarget(self, action: #selector(submitTap), for: .touchUpInside)
        submit.accessibilityIdentifier = "submit"

        view.addSubview(heading)
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(submit)

        updateSubmit()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let headingTopMargin: CGFloat = 20
        let headingSize = heading.intrinsicContentSize
        let passwordTopMargin: CGFloat = 20
        let fieldWidth = view.frame.width * 0.7
        let fieldHeight = username.intrinsicContentSize.height
        let submitSize = submit.intrinsicContentSize


        heading.frame = CGRect(
            x: (view.frame.width - headingSize.width) / 2,
            y: view.safeAreaInsets.top + headingTopMargin,
            width: headingSize.width,
            height: headingSize.height
        )

        username.frame = CGRect(
            x: (view.frame.width - fieldWidth) / 2,
            y: (view.frame.height - fieldHeight * 2 - passwordTopMargin) / 2,
            width: fieldWidth,
            height: fieldHeight
        )

        password.frame = CGRect(
            x: (view.frame.width - fieldWidth) / 2,
            y: username.frame.maxY + passwordTopMargin,
            width: fieldWidth,
            height: fieldHeight
        )

        submit.frame = CGRect(
            x: (view.frame.width - submitSize.width) / 2,
            y: view.frame.height - submitSize.height - view.safeAreaInsets.bottom,
            width: submitSize.width,
            height: submitSize.height
        )
    }

    @objc private func submitTap() {
        let result = authenticator.authenticate(username: username.text, password: password.text)

        switch result {
        case .success:
            // Simulating network connection with random delay
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(.random(in: 1...5))) {
                self.navigationController?.pushViewController(LoggedInViewController(), animated: true)
            }
        case .failure(let error):
            let alert = UIAlertController(title: "Error", message: error.errorMessage(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }

    @objc private func textDidChange() {
        updateSubmit()
    }

    private func updateSubmit() {
        let isValidLogin: Bool = {
            let result = authenticator.authenticate(username: username.text, password: password.text)
            switch result {
            case .success:
                return true
            case .failure:
                return false
            }
        }()

        submit.backgroundColor = isValidLogin ? .init(red: 0.7, green: 1.0, blue: 0.7, alpha: 1) : .init(red: 1.0, green: 0.7, blue: 0.7, alpha: 1)
        submit.accessibilityValue = isValidLogin ? "valid" : "invalid"
    }
}

extension AuthenticationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
