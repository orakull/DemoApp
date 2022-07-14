//
//  Feature+Mapping.swift
//  Settings Builder
//
//  Created by Ruslan Olkhovka on 26.05.2022.
//

struct SettingsCreator {
    var server: EnvironmentVariables.ServerEnvironment
    
    func create() -> Settings {
        .init(prefs: [
            environmentPref(key: "Server"),
            .group(title: nil),
            .toggle(title: "Reset Settings", key: "Reset", value: false)
        ])
    }
    
    private func environmentPref(key: String) -> Pref {
        let values = EnvironmentVariables.ServerEnvironment.allCases.map { $0.rawValue }
        return .select(title: "Server", key: key, value: server.rawValue, values: values, titles: values)
    }
}
