//
//  SwiftOptimiztionTests.swift
//  SwiftOptimiztionTests
//
//  Created by hoonhoon on 2018. 5. 28..
//  Copyright © 2018년 rollmind. All rights reserved.
//

import XCTest
@testable import SwiftOptimiztion

class SwiftOptimiztionTests: XCTestCase {

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func testRxSwiftCrash() {

		let crash = RxSwiftCrash()

		let waiter = XCTWaiter()

		let expect = expectation(description: #function)

		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			expect.fulfill()
		}

		waiter.wait(for: [expect], timeout: 1)

	}

}
