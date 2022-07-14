//
//  Settings.swift
//  Settings Builder
//
//  Created by Ruslan Olkhovka on 26.05.2022.
//

import Foundation

struct Settings: Encodable {
    let appGroup = AppSettingsStorage.appSettingsSuiteName
    var name = "Root"
    var prefs: [Pref]
    
    private enum CodingKeys: String, CodingKey {
        case name = "StringsTable"
        case prefs = "PreferenceSpecifiers"
        case appGroup = "ApplicationGroupContainerIdentifier"
    }
}

enum Pref {
    case group(title: String?)
    case toggle(title: String, key: String, value: Bool)
    case select(title: String, key: String, value: String, values: [String], titles: [String])
    case choose(title: String? = nil, key: String, value: String, values: [String], titles: [String], footer: String? = nil)
    case title(title: String? = nil, key: String, value: String, values: [String] = [], titles: [String] = [])
}

extension Pref: Encodable {
    
    fileprivate struct Group: Encodable {
        let `Type` = "PSGroupSpecifier"
        var Title: String?
    }
    
    fileprivate struct Toggle: Encodable {
        let `Type` = "PSToggleSwitchSpecifier"
        var Title: String
        var Key: String
        var DefaultValue: Bool
    }
    
    fileprivate struct Multi: Encodable {
        let `Type` = "PSMultiValueSpecifier"
        var Title: String
        var Key: String
        var DefaultValue: String
        var Values: [String]
        var Titles: [String]
    }
    
    fileprivate struct Radio: Encodable {
        let `Type` = "PSRadioGroupSpecifier"
        var Title: String?
        var Key: String
        var FooterText: String?
        var DefaultValue: String
        var Values: [String]
        var Titles: [String]
    }
    
    fileprivate struct Title: Encodable {
        let `Type` = "PSTitleValueSpecifier"
        var Title: String?
        var Key: String
        var DefaultValue: String
        var Values: [String]
        var Titles: [String]
    }
    
    private var asEncodable: Encodable {
        switch self {
        case let .group(title):
            return Group(Title: title)
        case let .toggle(title, key, value):
            return Toggle(Title: title, Key: key, DefaultValue: value)
        case let .select(title, key, value, values, titles):
            return Multi(Title: title, Key: key, DefaultValue: value, Values: values, Titles: titles)
        case let .choose(title, key, value, values, titles, footer):
            return Radio(Title: title, Key: key, FooterText: footer, DefaultValue: value, Values: values, Titles: titles)
        case let .title(title, key, value, values, titles):
            return Title(Title: title, Key: key, DefaultValue: value, Values: values, Titles: titles)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        try asEncodable.encode(to: encoder)
    }
}

extension Pref: CustomStringConvertible {
    var description: String {
        switch self {
        case let .group(title):
            return "\(title ?? "Group"):"
        case let .toggle(title, _, value):
            return "\t\(title): \(value)"
        case let .select(title, _, value, _, _):
            return "\t\(title): \(value)"
        case let .choose(title, key, value, _, _, _):
            return "\t\(title ?? key): \(value)"
        case let .title(title, _, value, _, _):
            return "\t\(title ?? ""): \(value)"
        }
    }
}
