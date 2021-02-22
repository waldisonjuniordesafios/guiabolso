//
//  JokeModel.swift
//  GuiaBolso
//
//  Created by Junior Fernandes on 18/02/21.
//

import Foundation

struct JokeModel: Codable {
    let categories: [String]
    let iconURL: String
    let url: String
    let value: String

    enum CodingKeys: String, CodingKey {
        case categories
        case iconURL = "icon_url"
        case url, value
    }
}
