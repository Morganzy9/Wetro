//
//  WTEndpoint.swift
//  Wetro
//
//  Created by Ислам Пулатов on 12/18/23.
//

import Foundation

/// Represents unique API Endpoint
@frozen enum WTEndpoint: String, CaseIterable, Hashable {
    case token
    case refreshToken
}
