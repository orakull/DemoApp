//
//  SettingsWriter.swift
//  Settings Builder
//
//  Created by Ruslan Olkhovka on 26.05.2022.
//

import Foundation

final class SettingsWriter {
    func write(_ settings: Settings) throws {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        let data = try encoder.encode(settings)
        let url = try URL.settingsPlistURL(for: settings.name)
        log("Write", url)
        log("Settings:")
        settings.prefs.forEach { log($0) }
        try data.write(to: url)
    }
}
