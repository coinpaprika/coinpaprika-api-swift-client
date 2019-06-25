//
//  StatusResponse.swift
//  CoinpaprikaAPI
//
//  Created by Dominique Stranz on 31/01/2019.
//

import Foundation
#if canImport(Networking)
import Networking
#endif

public struct StatusResponse: CodableModel {
    enum Status: String, Codable {
        case success
    }
    
    let status: Status
}
