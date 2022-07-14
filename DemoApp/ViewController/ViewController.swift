//
//  ViewController.swift
//  DemoApp
//
//  Created by Ruslan Olkhovka on 14.07.2022.
//

import UIKit

class ViewController: UIViewController {

    private let storage = AppSettingsStorage(monitorSettingsReset: true)
    
    @IBOutlet var envLabel: UILabel!
    
    @IBAction func onReloadButtonTap() {
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    private func updateUI() {
        let env = EnvironmentVariables.serverEnvironment.rawValue
        envLabel.text = "Environment: \(env)"
    }
}
