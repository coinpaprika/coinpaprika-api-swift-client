//
//  StringToDateTransformer.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 05.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation
import CodableExtensions

class StringToDateTransformer: DecodingContainerTransformer {
    typealias Input = String
    typealias Output = Date?

    func transform(_ decoded: Input) throws -> Output {
        guard let timeInterval = TimeInterval(decoded) else {
            return nil
        }

        return Date(timeIntervalSince1970: timeInterval)
    }

}
