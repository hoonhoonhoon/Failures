//
//  Next.swift
//  SwiftOptimiztionTests
//
//  Created by hoonhoon on 2018. 5. 29..
//  Copyright © 2018년 rollmind. All rights reserved.
//

import Foundation

/// OnNext를 RxSwiftCrashTest안에서 구현하는 경우 문제가 발생하지 않는다.
public protocol OnNext {
	associatedtype Element
	func on(_ element: Next<Element>)
}

// Optmization for Speed인 경우 onNext를 경유하지 않고 바로 on 함수로 들어감
extension OnNext {
	func onNext(_ element: Element) {
		on(.next(element))
	}

	func onCompleted() {
		on(.completed)
	}
}
