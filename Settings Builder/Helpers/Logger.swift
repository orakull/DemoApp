//
//  Logger.swift
//  Settings Builder
//
//  Created by Ruslan Olkhovka on 16.06.2022.
//

func log(_ items: Any...) {
    let out = items.map { String(describing: $0) }.joined(separator: " ")
    print(out)
}
