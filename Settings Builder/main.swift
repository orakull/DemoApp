//
//  main.swift
//  Settings Builder
//
//  Created by Ruslan Olkhovka on 14.07.2022.
//

import Foundation

#if DEBUG
let isDebug = true
#else
let isDebug = false
#endif

let createSettings = isDebug ? true : ProcessInfo.processInfo.environment["CREATE_APP_SETTINGS"] == "true"

if createSettings {
    log("Creating the Settings.bundle content")
    
    let settings = SettingsCreator(
        server: isDebug ? EnvironmentVariables.serverEnvironment : try .fromConfig()
    ).create()
    try SettingsWriter().write(settings)
} else {
    log("Deleting the Settings.bundle content")
    
    let fileManager = FileManager.default
    let settingsBundleContent = try fileManager.contentsOfDirectory(
        at: try .settingsURL, includingPropertiesForKeys: nil,
        options: .skipsHiddenFiles
    )
    for url in settingsBundleContent {
        log("Delete", url)
        try fileManager.removeItem(at: url)
    }
}

private extension EnvironmentVariables.ServerEnvironment {
    static func fromConfig() throws -> EnvironmentVariables.ServerEnvironment {
        try PlistReader<EnvironmentVariables.Config>(url: try .environmentVariablesURL).read().serverEnvironment
    }
}
