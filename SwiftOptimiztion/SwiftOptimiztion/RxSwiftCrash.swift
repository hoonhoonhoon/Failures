//
//  RxSwiftCrash.swift
//  SwiftOptimiztion
//
//  Created by hoonhoon on 2018. 5. 29..
//  Copyright © 2018년 rollmind. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct RxSwiftCrash {


	private let _showIndicator = BehaviorSubject<Bool>(value: true)
	var showIndicator: Driver<Bool>!
	let bag = DisposeBag()

	init() {

		self.showIndicator = self._showIndicator.asDriver(onErrorJustReturn: false)
		self.subscribes()

	}

	func subscribes() {

		Observable.just(true).asDriver(onErrorJustReturn: false).drive(onNext: self._showIndicator.onNext).disposed(by: bag)

	}

}
