//
//  WrldresetAPIConfiguration.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 30/08/2026.
//

import Foundation

struct WrldresetAPIConfiguration {
    let baseURL: URL

    static let development = WrldresetAPIConfiguration(
        baseURL: URL(string: "http://192.168.1.94:8080")!
    )
}
