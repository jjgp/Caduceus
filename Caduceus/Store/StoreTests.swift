//
//  StoreTests.swift
//  CaduceusTests
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

@testable import Caduceus
import RxSwift
import XCTest

class StoreTests: XCTestCase {
    func testInitialState() {
        let sut = Store()
        let spy = ObserverSpy(sut)
        XCTAssertEqual(spy.values, [State(foobar: "barbaz")])
    }

    private class ObserverSpy<T: ObservableType> {
        private(set) var values: [T.Element] = []
        private let disposeBag = DisposeBag()

        init(_ observable: T) {
            observable.subscribe(onNext: { [weak self] state in
                self?.values.append(state)
            }).disposed(by: disposeBag)
        }
    }
}
