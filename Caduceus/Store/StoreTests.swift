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
        let sut = makeSut()
        let spy = ObserverSpy(sut)
        XCTAssertEqual(spy.values, [State(0)])
    }

    func testActionsUpdateState() {
        let sut = makeSut()
        let spy = ObserverSpy(sut)
        sut.dispatch(.decrement(1))
        sut.dispatch(.increment(1))
        XCTAssertEqual(spy.values, [State(0), State(-1), State(0)])
    }
}

// MARK: - Test Helpers

extension StoreTests {
    private class ObserverSpy<T: ObservableType> {
        private(set) var values: [T.Element] = []
        private let disposeBag = DisposeBag()

        init(_ observable: T) {
            observable.subscribe(onNext: { [weak self] state in
                self?.values.append(state)
            }).disposed(by: disposeBag)
        }
    }

    private struct State: Equatable {
        let amount: Int
        init(_ amount: Int) {
            self.amount = amount
        }
    }

    private enum Action: Equatable {
        case initialize
        case decrement(Int)
        case increment(Int)
    }

    private func accumulator(state: State!, action: Action) -> State {
        switch action {
        case let .increment(amount):
            return State(state.amount + amount)
        case let .decrement(amount):
            return State(state.amount - amount)
        default:
            return State(0)
        }
    }

    private func makeSut() -> Store<State, Action> {
        return Store(
            accumulator: accumulator(state:action:),
            state: State(0),
            action: Action.initialize
        )
    }
}
