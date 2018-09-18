//
//  StringToInt32Transformer.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 05.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation
import CodableExtensions

class StringToInt32Transformer: DecodingContainerTransformer {
    typealias Input = String
    typealias Output = Int32

    func transform(_ decoded: Input) throws -> Output {
        return Int32(decoded) ?? 0
    }

}
