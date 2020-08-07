//
//  ObservableFilterExtensionsTests.swift
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

class ObservableFilterExtensionsTests: XCTestCase {
    private let scheduler = TestScheduler(initialClock: 0)

    func testObservableAllowTrue() {
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
        let observer = scheduler.createObserver(Bool.self)

        // When
        _ = coldObservable
            .allowTrue()
            .subscribe(observer)

        scheduler.start()

        // Then
        XCTAssertEqual(observer.events, correctEvents)
    }

    func testObservableAllowFalse() {
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
        let observer = scheduler.createObserver(Bool.self)

        // When
        _ = coldObservable
            .allowFalse()
            .subscribe(observer)

        scheduler.start()

        // Then
        XCTAssertEqual(observer.events, correctEvents)
    }

    func testObservableAllowTrueOptional() {
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
        let observer = scheduler.createObserver(Bool.self)

        // When
        _ = coldObservable
            .allowTrue()
            .subscribe(observer)

        scheduler.start()

        // Then
        XCTAssertEqual(observer.events, correctEvents)
    }

    func testObservableAllowTrueOrNil() {
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
        let observer = scheduler.createObserver(Bool.self)

        // When
        _ = coldObservable
            .allowTrueOrNil()
            .subscribe(observer)

        scheduler.start()

        // Then
        XCTAssertEqual(observer.events, correctEvents)
    }

    func testObservableAllowFalseOptional() {
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
        let observer = scheduler.createObserver(Bool.self)

        // When
        _ = coldObservable
            .allowFalse()
            .subscribe(observer)

        scheduler.start()

        // Then
        XCTAssertEqual(observer.events, correctEvents)
    }

    func testObservableAllowFalseOrNil() {
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
        let observer = scheduler.createObserver(Bool.self)

        // When
        _ = coldObservable
            .allowFalseOrNil()
            .subscribe(observer)

        scheduler.start()

        // Then
        XCTAssertEqual(observer.events, correctEvents)
    }

    func testObservableAllowNil() {
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
        let observer = scheduler.createObserver(Bool?.self)

        // When
        _ = coldObservable
            .allowNil()
            .subscribe(observer)

        scheduler.start()

        // Then
        XCTAssertEqual(observer.events, correctEvents)
    }
}
