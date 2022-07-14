//
//  EnvironmentVariables.swift
//  DemoApp
//
//  Created by Vladimir Kokhanevich on 31/10/2018.
//  Copyright © 2018 Reksoft. All rights reserved.
//

import Foundation

struct EnvironmentVariables {
    
    struct Config: Decodable {
        let serverEnvironment: ServerEnvironment
            
        private enum CodingKeys: String, CodingKey {
            case serverEnvironment = "ServerEnvironment"
        }
    }
    
    enum ServerEnvironment: String, CaseIterable, Decodable {
        case test
        case preProd
        case prod
    }
    
    private static let config: Config? = try? PlistReader(name: "EnvironmentVariables")?.read()
    
    static var serverEnvironment: ServerEnvironment {
        
        if let storedValue = AppSettingsStorage().environment {
            return storedValue
        }
        
        #if !DEBUG
        return config?.serverEnvironment ?? .prod
        #else
        return .test
        #endif
    }
}

private extension AppSettingsStorage {
    var environment: EnvironmentVariables.ServerEnvironment? {
        string(forKey: "Server").flatMap { .init(rawValue: $0) }
    }
}
