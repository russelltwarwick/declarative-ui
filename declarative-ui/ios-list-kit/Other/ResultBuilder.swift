//
//  GenericArrayBuilder.swift
//  ios-list-kit
//
//  Created by Russell Warwick on 13/06/2022.
//

import Foundation

@resultBuilder
struct ResultBuilder<I> {

    typealias Expression = I
    typealias Component = [I]

    static func buildExpression(_ expression: Expression) -> Component {
        [expression]
    }

    static func buildExpression(_ expression: Component) -> Component {
        expression
    }

    static func buildExpression(_ expression: Expression?) -> Component {
        guard let expression = expression else { return [] }
        return [expression]
    }

    static func buildBlock(_ children: Component...) -> Component {
        children.flatMap { $0 }
    }

    static func buildBlock(_ component: Component) -> Component {
        component
    }

    static func buildOptional(_ children: Component?) -> Component {
        children ?? []
    }

    static func buildEither(first child: Component) -> Component {
        child
    }

    static func buildEither(second child: Component) -> Component {
        child
    }

    static func buildArray(_ components: [Component]) -> Component {
        components.flatMap { $0 }
    }
}
