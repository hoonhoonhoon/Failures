//
//  ViewController.swift
//  SwiftOptimiztion
//
//  Created by hoonhoon on 2018. 5. 28..
//  Copyright © 2018년 rollmind. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension ObservableType {
	public func bool(_ value: Bool, errorValue: Bool? = nil) -> Observable<Bool> {
		var observable = map { _ in value }
		if let errorValue = errorValue {
			observable = observable.catchErrorJustReturn(errorValue)
		}
		return observable
	}
}

class ViewController: UIViewController {

	private let _showIndicator = BehaviorSubject<Bool>(value: true)
	var showIndicator: Driver<Bool>!
	let bag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()

		self.showIndicator = self._showIndicator.share(replay: 1).distinctUntilChanged().asDriver(onErrorJustReturn: false).debug("Show Indicator")
		self._showIndicator.onNext(true)
		self._showIndicator.subscribe().disposed(by: bag)
		self.subscribes()
		
	}

	func subscribes() {

		Observable.just(true).asDriver(onErrorJustReturn: false).drive(onNext: self._showIndicator.onNext).disposed(by: bag)

	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

