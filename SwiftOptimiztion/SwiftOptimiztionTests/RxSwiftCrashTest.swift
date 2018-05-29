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

class RxSwiftCrashTest: XCTestCase {

	var subject: PublishSubject<Bool>!
	var bag: DisposeBag!

	override func setUp() {
		super.setUp()
		bag = DisposeBag()
		subject = PublishSubject<Bool>()
	}

	override func tearDown() {

		super.tearDown()
	}

	// onNext가 가능한 Rx trait를 다른 옵저버블에 바인딩 하지 않고 직접 해당 trait의 onNext함수를 인수로 전달할 경우 해당 함수를 소유하는 trait이 메모리에서 해지되거나 메모리 좌표에 문제가 발생하는 듯
	func testRxSwiftCrash() {
		Observable.just(true).subscribe(onNext: self.subject.onNext).dispose()
	}

}
