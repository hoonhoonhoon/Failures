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

// MARK: - ReceiveEvent에 직접 onNext를 구현하면 문제가 사라진다.
// MARK: - 아무래도 ReceiveEvent객체가 사라지는것이 아닌 ReceiveEvent.OnNext.onNext에서 ReceiveEvent.on 함수에 제대로 접근을 하지 못하는 것이 문제라는 생각이 든다.
//extension ReceiveEvent {
//	func onNext(_ element: Element) {
//		self.on(element)
//	}
//}

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
