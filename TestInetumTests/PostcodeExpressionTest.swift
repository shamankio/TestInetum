//
//  PostcodeExpressionTest.swift
//  TestInetumTests
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import Testing
@testable import TestInetum

struct PostcodeExpressionTest {
    @Test func testIsWildcard() {
        #expect(PostcodeExpression("762*").isWildcard)
        #expect(
            !PostcodeExpression("76133").isWildcard,
            "postcode don't have wildcard"
        )
    }

    @Test func testPrefix() {
        #expect(PostcodeExpression("762*").prefix == "762")
        #expect(PostcodeExpression("76133").prefix == "76133")
    }

    @Test func testCanHandleExactToExact() {
        let expression = PostcodeExpression("76133")
        #expect(expression.canHandle(searchQuery: "76133"))
        #expect(!expression.canHandle(searchQuery: "76134"))
    }

    @Test func testCanHandleWildcardToExact() {
        // Area "762*" can handle exact postcode "76200"
        let expression = PostcodeExpression("762*")
        #expect(expression.canHandle(searchQuery: "76200"))
        #expect(expression.canHandle(searchQuery: "76299"))
        #expect(expression.canHandle(searchQuery: "76234"))
        #expect(!expression.canHandle(searchQuery: "76134"))
        #expect(!expression.canHandle(searchQuery: "77200"))
    }

    @Test func testCanHandleExactToWildcard() {
        // Area "76200" can handle wildcard search "762*"
        let expression = PostcodeExpression("76200")
        #expect(expression.canHandle(searchQuery: "762*"))
        #expect(expression.canHandle(searchQuery: "76*"))
        #expect(!expression.canHandle(searchQuery: "761*"))
        #expect(!expression.canHandle(searchQuery: "77*"))
    }

    @Test func testCanHandleWildcardToWildcard() {
        let narrowArea = PostcodeExpression("762*")
        #expect(narrowArea.canHandle(searchQuery: "76*"))
        #expect(!narrowArea.canHandle(searchQuery: "7620*"))
    }

    @Test func testCanHandleRealWorldScenarios() {
        // Test with provided sample data
        let artemArea = PostcodeExpression("76133")
        let berndArea = PostcodeExpression("7619*")
        let chrisArea = PostcodeExpression("762*")
        let alexArea = PostcodeExpression("86*")

        // Search for "762*" should find Chris (762*) and potentially others
        #expect(chrisArea.canHandle(searchQuery: "762*"))
        #expect(!berndArea.canHandle(searchQuery: "762*"))
        #expect(!artemArea.canHandle(searchQuery: "762*"))
        #expect(!alexArea.canHandle(searchQuery: "762*"))

        // Search for "76200" should find Chris (762*)
        #expect(chrisArea.canHandle(searchQuery: "76200"))
        #expect(!berndArea.canHandle(searchQuery: "76200"))
        #expect(!artemArea.canHandle(searchQuery: "76200"))
        #expect(!alexArea.canHandle(searchQuery: "76200"))

        // Search for "76190" should find both Bernd (7619*) and Chris (762*)
        #expect(berndArea.canHandle(searchQuery: "76190"))
        #expect(!chrisArea.canHandle(searchQuery: "76190"))
        #expect(!artemArea.canHandle(searchQuery: "76190"))
        #expect(!alexArea.canHandle(searchQuery: "76190"))
    }

    @Test func testCanHandleEdgeCases() {
        // Empty inputs
        #expect(!PostcodeExpression("762*").canHandle(searchQuery: ""))
        #expect(!PostcodeExpression("").canHandle(searchQuery: "762*"))

        // Invalid wildcard expressions in search
        #expect(!PostcodeExpression("762*").canHandle(searchQuery: "abc*"))

        // Invalid area expressions
        #expect(!PostcodeExpression("abc*").canHandle(searchQuery: "76200"))
    }
}
