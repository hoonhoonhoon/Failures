//
//  OnNext.swift
//  SwiftOptimiztionTests
//
//  Created by hoonhoon on 2018. 5. 29..
//  Copyright © 2018년 rollmind. All rights reserved.
//

public protocol OnNext {
	associatedtype Element
	func on(_ element: Element)
}

// Optmization for Speed인 경우 onNext를 경유하지 않고 바로 on 함수로 들어감
extension OnNext {
	func onNext(_ element: Element) {
		on(element)
	}
}
