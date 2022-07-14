//
//  PlistReader.swift
//  DemoApp
//
//  Created by Ruslan Olkhovka on 29.06.2022.
//

import Foundation

final class PlistReader<T: Decodable> {
    
    private let decoder = PropertyListDecoder()
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    convenience init?(name: String, bundle: Bundle = .main) {
        guard let url = bundle.url(forResource: name, withExtension: "plist") else { return nil }
        self.init(url: url)
    }
    
    func read() throws -> T {
        let data = try Data(contentsOf: url)
        return try decoder.decode(T.self, from: data)
    }
}
