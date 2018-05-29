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

final class TestObserver<Element>: ObserverType {

	func on(_ event: Event<Element>) {
		print(event)
	}

}

class RxSwiftCrashTest: XCTestCase {

	var publishSubject: PublishSubject<Bool>!
	var testObserver: TestObserver<Bool>!
	var bag: DisposeBag!

	override func setUp() {
		super.setUp()
		bag = DisposeBag()
		publishSubject = PublishSubject<Bool>()
		testObserver = TestObserver()
	}

	override func tearDown() {

		super.tearDown()
	}

	/// ObserverType의 onNext함수는 extension을 통해 구현하고 있습니다.
	/// ObserverType을 구현하는 타입은 on함수만 구현하면 onNext, onCompleted, onError함수의 Event가 on으로 편하게 넘어가도록 구현되어있습니다.
	/// 문제는 swift code generation optmization level을 optimization speed로 하는 경우
	/// 특정 observertype의 onNext함수를 인자로서만 사용할 때 발생하는데,
	/// 현재까지는 onNext 함수(클로져)를 소유하는 객체의 소유권이 해지됨으로서 발생하는 이슈인거 같습니다.
	func testRxSwiftCrash() {
		Observable.just(true).subscribe(onNext: self.testObserver.onNext).dispose()
//		Observable.just(true).subscribe(onNext: self.publishSubject.onNext).dispose()
	}

}
