//
//  Build.swift
//  declarative-ui
//
//  Created by Russell Warwick on 31/03/2023.
//

import Foundation

@discardableResult
func build<Type>(_ type: Type, transform: (inout Type) throws -> Void) rethrows -> Type {
    var mutableType = type
    try transform(&mutableType)
    return mutableType
}
