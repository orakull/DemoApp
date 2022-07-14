//
//  Sources.swift
//  Settings Builder
//
//  Created by Ruslan Olkhovka on 26.05.2022.
//

import Foundation

extension URL {
    private static var sourcesRoot: URL {
        get throws {
            let path: String
            if  ProcessInfo.processInfo.arguments.count > 1 {
                path = ProcessInfo.processInfo.arguments[1]
            } else if let srcRoot = ProcessInfo.processInfo.environment["SRCROOT"] {
                path = srcRoot
            } else {
                throw NSError(domain: "The sources path is not specified. Set argument or SRCROOT env var", code: 1)
            }
            return URL(fileURLWithPath: path)
        }
    }
    
    static var environmentVariablesURL: URL {
        get throws {
            try sourcesRoot.appendingPathComponent("EnvironmentVariables.plist")
        }
    }
    
    static var settingsURL: URL {
        get throws {
            try sourcesRoot.appendingPathComponent("DemoApp/Resources/Settings.bundle")
        }
    }
    
    static func settingsPlistURL(for name: String) throws -> URL {
        try settingsURL.appendingPathComponent("\(name).plist")
    }
}
