//
//  LoggedInViewController.swift
//  TestEngineerChallenge-iOS
//
//  Created by Daniel Krofchick on 2021-08-06.
//

import UIKit

class LoggedInViewController: UIViewController {
    private var didLoad: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        didLoad = {
            self.view.backgroundColor = self.view.backgroundColor
        }

        view.backgroundColor = .green
        view.accessibilityIdentifier = "loggedIn"
    }
}
