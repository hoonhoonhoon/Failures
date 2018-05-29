//
//  SwiftOptimiztionTests.swift
//  SwiftOptimiztionTests
//
//  Created by hoonhoon on 2018. 5. 28..
//  Copyright © 2018년 rollmind. All rights reserved.
//

import XCTest
@testable import SwiftOptimiztion

struct Test {
	let a: [String]
}

extension Test: Comparable {
	static func < (lhs: Test, rhs: Test) -> Bool {
		guard Set(lhs.a).isSubset(of: rhs.a) else {
			return false
		}
		return lhs.a.count < rhs.a.count
	}
	static func == (lhs: Test, rhs: Test) -> Bool {
		return Set(lhs.a).isSubset(of: rhs.a)
	}
}

class SwiftOptimiztionTests: XCTestCase {

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func testExample() {
		let a = Test(a: ["A", "B"])
		let b = Test(a: ["B", "A"])
		XCTAssertTrue(a < b)
		XCTAssertEqual(a, b)
	}

}
