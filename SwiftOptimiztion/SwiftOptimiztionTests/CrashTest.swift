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

final class AnonymousEventSend<Element> {
	typealias EventHandler = (Next<Element>) -> Void
	let eventHandler: (Next<Element>) -> Void
	init(_ handler: @escaping EventHandler) {
		self.eventHandler = handler
	}
	func onCore(_ next: Next<Element>) {
		self.eventHandler(next)
	}
}

final class FireEvent<Element> {
	var observer: AnonymousEventSend<Element>?
	func subscribe(onNext: ((Element) -> Void)? = nil, onCompleted: (() -> Void)? = nil) {
		self.observer = AnonymousEventSend { event in
			switch event {
			case .next(let element):
				onNext?(element)
			case .completed:
				onCompleted?()
			}
		}
	}

	func fire(_ next: Next<Element>) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			self.observer?.onCore(next)
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
