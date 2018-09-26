//
//  StringToDecimalTransformer.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 05.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation

internal class StringToDecimalTransformer: DecodingContainerTransformer {
    typealias Input = String
    typealias Output = Decimal

    func transform(_ decoded: Input) throws -> Output {
        return Decimal(string: decoded) ?? 0
    }

}
