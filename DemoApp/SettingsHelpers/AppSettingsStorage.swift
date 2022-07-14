//
//  AppSettingsStorage.swift
//  DemoApp
//
//  Created by Ruslan Olkhovka on 03.06.2022.
//

import Foundation

final class AppSettingsStorage {
    
    static let appSettingsSuiteName = "group.com.orakull.appSettings"
    
    private let defaults = UserDefaults(suiteName: appSettingsSuiteName)!
    
    private var isNeedToReset = false {
        didSet {
            guard isNeedToReset != oldValue, isNeedToReset else { return }
            reset()
        }
    }
    
    init(monitorSettingsReset: Bool = false) {
        if monitorSettingsReset {
            NotificationCenter.default.addObserver(self, selector: #selector(onChanged), name: UserDefaults.didChangeNotification, object: nil)
        }
    }
    
    @objc
    private func onChanged() {
        isNeedToReset = defaults.bool(forKey: "Reset")
    }
    
    private func reset() {
        defaults.removePersistentDomain(forName: AppSettingsStorage.appSettingsSuiteName)
    }
    
    private func isStored(_ key: String) -> Bool {
        defaults.object(forKey: key) != nil
    }
}

extension AppSettingsStorage {
    
    func bool(forKey key: String) -> Bool? {
        guard isStored(key) else { return nil }
        return defaults.bool(forKey: key)
    }
    
    func string(forKey key: String) -> String? {
        defaults.string(forKey: key)
    }
}
