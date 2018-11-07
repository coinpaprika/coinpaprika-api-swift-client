//
//  StringToInt64Transformer.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 05.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation

class StringToInt64Transformer: CodingContainerTransformer {
    typealias Input = String
    typealias Output = Int64

    func transform(_ decoded: Input) throws -> Output {
        return Int64(decoded) ?? 0
    }

    func transform(_ encoded: Output) throws -> Input {
        return "\(encoded)"
    }
}
