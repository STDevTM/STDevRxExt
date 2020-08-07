//
//  SharedSequenceFilterExtensionsTests.swift
//  STDevRxExtTests
//
//  Created by Tigran Hambardzumyan on 8/7/20.
//  Copyright © 2020 STDev. All rights reserved.
//

import RxCocoa
import RxSwift
import RxTest
import STDevRxExt

import XCTest

class SharedSequenceFilterExtensionsTests: XCTestCase {
    private let scheduler = TestScheduler(initialClock: 0)

    func testSharedSequenceAllowTrue() {
        // Given
        let coldObservable = scheduler.createColdObservable([
            .next(10, true),
            .next(20, false),
            .next(30, false),
            .next(40, true),
            .completed(50)
        ])
        let correctEvents = Recorded.events([
            .next(10, true),
            .next(40, true),
            .completed(50)
        ])
        let driver = coldObservable.asDriver(onErrorDriveWith: .empty())
        let observerForDriver = scheduler.createObserver(Bool.self)
        let signal = coldObservable.asDriver(onErrorDriveWith: .empty())
        let observerForSignal = scheduler.createObserver(Bool.self)

        // When
        _ = driver
            .allowTrue()
            .drive(observerForDriver)

        _ = signal
            .allowTrue()
            .drive(observerForSignal)

        scheduler.start()

        // Then
        XCTAssertEqual(observerForDriver.events, correctEvents)
        XCTAssertEqual(observerForSignal.events, correctEvents)
    }

    func testSharedSequenceAllowFalse() {
        // Given
        let coldObservable = scheduler.createColdObservable([
            .next(10, true),
            .next(20, false),
            .next(30, false),
            .next(40, true),
            .completed(50)
        ])
        let correctEvents = Recorded.events([
            .next(20, false),
            .next(30, false),
            .completed(50)
        ])
        let driver = coldObservable.asDriver(onErrorDriveWith: .empty())
        let observerForDriver = scheduler.createObserver(Bool.self)
        let signal = coldObservable.asDriver(onErrorDriveWith: .empty())
        let observerForSignal = scheduler.createObserver(Bool.self)

        // When
        _ = driver
            .allowFalse()
            .drive(observerForDriver)

        _ = signal
            .allowFalse()
            .drive(observerForSignal)

        scheduler.start()

        // Then
        XCTAssertEqual(observerForDriver.events, correctEvents)
        XCTAssertEqual(observerForSignal.events, correctEvents)
    }

    func testSharedSequenceAllowTrueOptional() {
        // Given
        let coldObservable = scheduler.createColdObservable([
            .next(10, true),
            .next(20, nil),
            .next(30, false),
            .next(40, true),
            .completed(50)
        ])
        let correctEvents = Recorded.events([
            .next(10, true),
            .next(40, true),
            .completed(50)
        ])
        let driver = coldObservable.asDriver(onErrorDriveWith: .empty())
        let observerForDriver = scheduler.createObserver(Bool.self)
        let signal = coldObservable.asDriver(onErrorDriveWith: .empty())
        let observerForSignal = scheduler.createObserver(Bool.self)

        // When
        _ = driver
            .allowTrue()
            .drive(observerForDriver)

        _ = signal
            .allowTrue()
            .drive(observerForSignal)

        scheduler.start()

        // Then
        XCTAssertEqual(observerForDriver.events, correctEvents)
        XCTAssertEqual(observerForSignal.events, correctEvents)
    }

    func testSharedSequenceAllowTrueOrNil() {
        // Given
        let coldObservable = scheduler.createColdObservable([
            .next(10, true),
            .next(20, nil),
            .next(30, false),
            .next(40, true),
            .completed(50)
        ])
        let correctEvents = Recorded.events([
            .next(10, true),
            .next(20, true),
            .next(40, true),
            .completed(50)
        ])
        let driver = coldObservable.asDriver(onErrorDriveWith: .empty())
        let observerForDriver = scheduler.createObserver(Bool.self)
        let signal = coldObservable.asDriver(onErrorDriveWith: .empty())
        let observerForSignal = scheduler.createObserver(Bool.self)

        // When
        _ = driver
            .allowTrueOrNil()
            .drive(observerForDriver)

        _ = signal
            .allowTrueOrNil()
            .drive(observerForSignal)

        scheduler.start()

        // Then
        XCTAssertEqual(observerForDriver.events, correctEvents)
        XCTAssertEqual(observerForSignal.events, correctEvents)
    }

    func testSharedSequenceAllowFalseOptional() {
        // Given
        let coldObservable = scheduler.createColdObservable([
            .next(10, true),
            .next(20, false),
            .next(30, false),
            .next(40, nil),
            .completed(50)
        ])
        let correctEvents = Recorded.events([
            .next(20, false),
            .next(30, false),
            .completed(50)
        ])
        let driver = coldObservable.asDriver(onErrorDriveWith: .empty())
        let observerForDriver = scheduler.createObserver(Bool.self)
        let signal = coldObservable.asDriver(onErrorDriveWith: .empty())
        let observerForSignal = scheduler.createObserver(Bool.self)

        // When
        _ = driver
            .allowFalse()
            .drive(observerForDriver)
        _ = signal
            .allowFalse()
            .drive(observerForSignal)

        scheduler.start()

        // Then
        XCTAssertEqual(observerForDriver.events, correctEvents)
        XCTAssertEqual(observerForSignal.events, correctEvents)
    }

    func testSharedSequenceAllowFalseOrNil() {
        // Given
        let coldObservable = scheduler.createColdObservable([
            .next(10, true),
            .next(20, false),
            .next(30, false),
            .next(40, nil),
            .completed(50)
        ])
        let correctEvents = Recorded.events([
            .next(20, false),
            .next(30, false),
            .next(40, false),
            .completed(50)
        ])
        let driver = coldObservable.asDriver(onErrorDriveWith: .empty())
        let observerForDriver = scheduler.createObserver(Bool.self)
        let signal = coldObservable.asDriver(onErrorDriveWith: .empty())
        let observerForSignal = scheduler.createObserver(Bool.self)

        // When
        _ = driver
            .allowFalseOrNil()
            .drive(observerForDriver)
        _ = signal
            .allowFalseOrNil()
            .drive(observerForSignal)

        scheduler.start()

        // Then
        XCTAssertEqual(observerForDriver.events, correctEvents)
        XCTAssertEqual(observerForSignal.events, correctEvents)
    }

    func testSharedSequenceAllowNil() {
        // Given
        let coldObservable = scheduler.createColdObservable([
            .next(10, true),
            .next(20, nil),
            .next(30, false),
            .next(40, nil),
            .completed(50)
        ])
        let correctEvents = Recorded<Event<Bool?>>.events([
            .next(20, nil),
            .next(40, nil),
            .completed(50)
        ])
        let driver = coldObservable.asDriver(onErrorDriveWith: .empty())
        let observerForDriver = scheduler.createObserver(Bool?.self)
        let signal = coldObservable.asDriver(onErrorDriveWith: .empty())
        let observerForSignal = scheduler.createObserver(Bool?.self)

        // When
        _ = driver
            .allowNil()
            .drive(observerForDriver)
        _ = signal
            .allowNil()
            .drive(observerForSignal)

        scheduler.start()

        // Then
        XCTAssertEqual(observerForDriver.events, correctEvents)
        XCTAssertEqual(observerForSignal.events, correctEvents)
    }

}
