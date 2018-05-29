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

	override func viewDidLoad() {
		super.viewDidLoad()

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

