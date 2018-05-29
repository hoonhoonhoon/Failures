//
//  SwiftOptimiztionTests.swift
//  SwiftOptimiztionTests
//
//  Created by hoonhoon on 2018. 5. 28..
//  Copyright © 2018년 rollmind. All rights reserved.
//

import XCTest
import RxSwift
@testable import SwiftOptimiztion

public enum Next<Element> {
	case next(Element)
	case completed
}

public protocol OnNext {
	associatedtype Element
	func on(_ element: Next<Element>)
}

public final class TestObserver<Element>: OnNext {

	public func on(_ event: Next<Element>) {
		print(event)
	}

}

public final class TestObserver2<Element>: ObserverType {

	public func on(_ event: Event<Element>) {
		print(event)
	}

}

extension OnNext {
	func onNext(_ element: Element) {
		on(.next(element))
	}

	func onCompleted() {
		on(.completed)
	}
}

final class Fire<Element> {
	let element: Element
	init(element: Element) {
		self.element = element
	}
	func subscribe(onNext: ((Element) -> Void)? = nil) {
		let element = self.element
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
			onNext?(element)
		}
	}
}

class RxSwiftCrashTest: XCTestCase {

	var publishSubject: PublishSubject<Bool>!
	var testObserver: TestObserver2<Bool>!
	var bag: DisposeBag!

	override func setUp() {
		super.setUp()
		bag = DisposeBag()
		publishSubject = PublishSubject<Bool>()
		testObserver = TestObserver2()
	}

	override func tearDown() {

		super.tearDown()
	}

	/// ObserverType의 onNext함수는 extension을 통해 구현하고 있습니다.
	/// ObserverType을 구현하는 타입은 on함수만 구현하면 onNext, onCompleted, onError함수의 Event가 on으로 편하게 넘어가도록 구현되어있습니다.
	/// 문제는 swift code generation optmization level을 optimization speed로 하는 경우
	/// 특정 observertype의 onNext함수를 인자로서만 사용할 때 발생하는데,
	/// extension이 아닌 직접 onNext를 구현한다면 해당 문제는 발생하지 않습니다.
	/// extension으로 접근하는 경우 소유권 체크를 못하는 부분이 있는거 같습니다.
	/// ObserverType을 상속하는 객체가 struct인 경우는 아무런 문제가 없습니다.
	func testRxSwiftCrash() {
//		Observable.just(true).subscribe(self.testObserver).dispose()
		Fire(element: false).subscribe(onNext: self.testObserver.onNext)

		let waiter = XCTWaiter()
		let expect = expectation(description: #function)
		waiter.wait(for: [expect], timeout: 0.3)
//		Observable.just(true).subscribe(onNext: self.publishSubject.onNext).dispose()
	}

}
