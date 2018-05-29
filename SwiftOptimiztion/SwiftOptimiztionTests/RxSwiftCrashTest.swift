//
//  SwiftOptimiztionTests.swift
//  SwiftOptimiztionTests
//
//  Created by hoonhoon on 2018. 5. 28..
//  Copyright © 2018년 rollmind. All rights reserved.
//

import XCTest
@testable import SwiftOptimiztion

public enum Next<Element> {
	case next(Element)
	case completed
}

public final class TestObserver<Element>: OnNext {

	public func on(_ event: Next<Element>) {
		print(event)
	}

}

final class Anonymous<Element> {
	typealias EventHandler = (Next<Element>) -> Void
	let eventHandler: (Next<Element>) -> Void
	init(_ handler: @escaping EventHandler) {
		self.eventHandler = handler
	}
	func onCore(_ next: Next<Element>) {
		self.eventHandler(next)
	}
}

final class Fire<Element> {
	var observer: Anonymous<Element>?
	func subscribe(onNext: ((Element) -> Void)? = nil, onCompleted: (() -> Void)? = nil) {
		self.observer = Anonymous { event in
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

class RxSwiftCrashTest: XCTestCase {
	var testObserver = TestObserver<Bool>()

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {

		super.tearDown()
	}

	/// 
	func testRxSwiftCrash() {
		let fire = Fire<Bool>()
		fire.subscribe(onNext: self.testObserver.onNext)
		fire.fire(.next(false))

		let waiter = XCTWaiter()
		let expect = expectation(description: #function)
		waiter.wait(for: [expect], timeout: 0.3)
	}

}
