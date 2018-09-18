//
//  StringToInt64Transformer.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 05.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation
import CodableExtensions

class StringToInt64Transformer: DecodingContainerTransformer {
    typealias Input = String
    typealias Output = Int64

    func transform(_ decoded: Input) throws -> Output {
        return Int64(decoded) ?? 0
    }

}
