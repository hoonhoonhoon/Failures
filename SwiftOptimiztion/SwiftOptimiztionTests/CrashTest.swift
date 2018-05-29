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

	public func on(_ event: Next<Element>) {
		print(event)
	}

}

final class FireEvent<Element> {
	var onNext: ((Element) -> Void)?
	func subscribe(onNext: ((Element) -> Void)? = nil, onCompleted: (() -> Void)? = nil) {
		self.onNext = onNext
	}

	func fire(_ next: Next<Element>) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			switch next {
			case .next(let element):
				self.onNext?(element)
//			case .completed:
//				break
			}
		}
	}
}

class CrashTest: XCTestCase {
	var testObserver = ReceiveEvent<Bool>()

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {

		super.tearDown()
	}

	/// 
	func testCrash() {
		let fire = FireEvent<Bool>()
		fire.subscribe(onNext: self.testObserver.onNext)
		fire.fire(.next(false))

		let waiter = XCTWaiter()
		let expect = expectation(description: #function)
		waiter.wait(for: [expect], timeout: 0.3)
	}

}
