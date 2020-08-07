//
//  CastExtensionsTests.swift
//  STDevRxExtTests
//
//  Created by Tigran Hambardzumyan on 8/06/20.
//  Copyright © 2020 STDev. All rights reserved.
//

import RxCocoa
import RxSwift
import RxTest
import STDevRxExt

import XCTest

class CastExtensionsTests: XCTestCase {
    private let scheduler = TestScheduler(initialClock: 0)
    private var coldObservable: TestableObservable<Base>!
    private let correctSoftCastEvents = Recorded.events([
        .next(10, FirstChild(value: 1)),
        .next(20, FirstChild(value: 2)),
        .next(30, nil),
        .next(40, FirstChild(value: 4)),
        .completed(50)
    ])
    private let correctForceCastEvents = Recorded.events([
        .next(10, FirstChild(value: 1)),
        .next(20, FirstChild(value: 2)),
        .error(30, RxCastError.castFailed)
    ])

    override func setUp() {
        super.setUp()

        coldObservable = scheduler.createColdObservable([
            .next(10, FirstChild(value: 1)),
            .next(20, FirstChild(value: 2)),
            .next(30, SecondChild(value: 3)),
            .next(40, FirstChild(value: 4)),
            .completed(50)
        ])
    }

    // MARK: - Observable

    func testObservableCast() {
        // Given
        let observer = scheduler.createObserver(FirstChild?.self)

        // When
        _ = coldObservable
            .cast(to: FirstChild.self)
            .subscribe(observer)

        scheduler.start()

        // Then
        XCTAssertEqual(observer.events, correctSoftCastEvents)
    }

    func testObservableForceCast() {
        // Given
        let observer = scheduler.createObserver(FirstChild.self)

        // When
        _ = coldObservable
            .forceCast(to: FirstChild.self)
            .subscribe(observer)

        scheduler.start()

        // Then
        XCTAssertEqual(observer.events, correctForceCastEvents)
    }

    // MARK: - SharedSequence

    func testDriverCast() {
        // Given
        let observer = scheduler.createObserver(FirstChild?.self)
        let driver = coldObservable.asDriver(onErrorDriveWith: .empty())

        // When
        _ = driver
            .cast(to: FirstChild.self)
            .drive(observer)

        scheduler.start()

        // Then
        XCTAssertEqual(observer.events, correctSoftCastEvents)
    }

    func testSignalCast() {
        // Given
        let observer = scheduler.createObserver(FirstChild?.self)
        let signal = coldObservable.asSignal(onErrorSignalWith: .empty())

        // When
        _ = signal
            .cast(to: FirstChild.self)
            .emit(to: observer)

        scheduler.start()

        // Then
        XCTAssertEqual(observer.events, correctSoftCastEvents)
    }

    // MARK: - PrimitiveSequence

    func testSingleCast() {
        // Given
        let observer = scheduler.createObserver(FirstChild?.self)
        let single = coldObservable.first()

        // When
        _ = single
            .cast(to: FirstChild.self)
            .asObservable()
            .subscribe(observer)

        scheduler.start()

        // Then
        XCTAssertEqual(observer.events, [
            .next(10, FirstChild(value: 1)),
            .completed(10)
        ])
    }

    func testMaybeCast() {
        // Given
        let observer = scheduler.createObserver(FirstChild?.self)
        let maybe = coldObservable.first().asMaybe()

        // When
        _ = maybe
            .cast(to: FirstChild.self)
            .asObservable()
            .subscribe(observer)

        scheduler.start()

        // Then
        XCTAssertEqual(observer.events, [
            .next(10, FirstChild(value: 1)),
            .completed(10)
        ])
    }

    // MARK: - Helper Classes

    class Base: Equatable {
        let value: Int

        init(value: Int) {
            self.value = value
        }

        static func == (lhs: Base, rhs: Base) -> Bool {
            lhs.value == rhs.value
        }
    }

    class FirstChild: Base {}
    class SecondChild: Base {}
}
