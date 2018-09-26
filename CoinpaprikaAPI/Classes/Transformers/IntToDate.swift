//
//  StringToDateTransformer.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 05.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation

internal class IntToDateTransformer: DecodingContainerTransformer {
    typealias Input = Int
    typealias Output = Date?

    func transform(_ decoded: Input) throws -> Output {
        return Date(timeIntervalSince1970: TimeInterval(decoded))
    }

}
