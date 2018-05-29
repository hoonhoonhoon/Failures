//
//  SwiftOptimiztionTests.swift
//  SwiftOptimiztionTests
//
//  Created by hoonhoon on 2018. 5. 28..
//  Copyright © 2018년 rollmind. All rights reserved.
//

import XCTest
@testable import SwiftOptimiztion

public final class ReceiveEvent<Element>: OnNext {
	public func on(_ event: Element) {
		print(event)
	}
}

class CrashTest: XCTestCase {
	var receiver = ReceiveEvent<Bool>()
	var onNext: ((Bool) -> Void)?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {

		super.tearDown()
	}

	/// 
	func testCrash() {
		self.onNext = self.receiver.onNext
		let waiter = XCTWaiter()
		let expect = expectation(description: #function)
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
			self.onNext?(false)
			expect.fulfill()
		}
		waiter.wait(for: [expect], timeout: 0.3)
	}

}
