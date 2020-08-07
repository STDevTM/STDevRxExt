//
//  MapExtensionsTests.swift
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

class MapExtensionsTests: XCTestCase {
    private let scheduler = TestScheduler(initialClock: 0)
    private let models = [
        Model(property: "value1"),
        Model(property: "value2"),
        Model(property: "value3")
    ]

    // MARK: - Observable

    func testObservableMapTo() {
        // Given
        let expectedEvents = Recorded.events([
            .next(0, "value"),
            .next(0, "value"),
            .next(0, "value"),
            .completed(0)
        ])
        let observer = scheduler.createObserver(String.self)

        // When
        _ = Observable.from(models)
            .map(to: "value")
            .bind(to: observer)

        scheduler.start()

        // Then
        XCTAssertEqual(observer.events, expectedEvents)
    }

    func testObservableMapAt() {
        // Given
        let expectedEvents = Recorded.events([
            .next(0, "value1"),
            .next(0, "value2"),
            .next(0, "value3"),
            .completed(0)
        ])
        let observer = scheduler.createObserver(String.self)

        // When
        _ = Observable.from(models)
            .map(at: \.property)
            .bind(to: observer)

        scheduler.start()

        // Then
        XCTAssertEqual(observer.events, expectedEvents)
    }

    // MARK: - SharedSequnce

    func testSharedSequnceMapTo() {
        // Given
        let coldObservable = scheduler.createColdObservable([
            .next(10, Model(property: "value1")),
            .next(20, Model(property: "value2")),
            .next(30, Model(property: "value3")),
            .completed(40)
        ])
        let expectedEvents = Recorded.events([
            .next(10, "value"),
            .next(20, "value"),
            .next(30, "value"),
            .completed(40)
        ])
        let observerForDriver = scheduler.createObserver(String.self)
        let observerForSignal = scheduler.createObserver(String.self)

        // When
        _ = coldObservable.asDriver(onErrorDriveWith: .empty())
            .map(to: "value")
            .drive(observerForDriver)

        _ = coldObservable.asSignal(onErrorSignalWith: .empty())
            .map(to: "value")
            .emit(to: observerForSignal)

        scheduler.start()

        // Then
        XCTAssertEqual(observerForDriver.events, expectedEvents)
        XCTAssertEqual(observerForSignal.events, expectedEvents)
    }

    func testSharedSequnceMapAt() {
        // Given
        let coldObservable = scheduler.createColdObservable([
            .next(10, Model(property: "value1")),
            .next(20, Model(property: "value2")),
            .next(30, Model(property: "value3")),
            .completed(40)
        ])
        let expectedEvents = Recorded.events([
            .next(10, "value1"),
            .next(20, "value2"),
            .next(30, "value3"),
            .completed(40)
        ])
        let observerForDriver = scheduler.createObserver(String.self)
        let observerForSignal = scheduler.createObserver(String.self)

        // When
        _ = coldObservable.asDriver(onErrorDriveWith: .empty())
            .map(at: \.property)
            .drive(observerForDriver)

        _ = coldObservable.asSignal(onErrorSignalWith: .empty())
            .map(at: \.property)
            .emit(to: observerForSignal)

        scheduler.start()

        // Then
        XCTAssertEqual(observerForDriver.events, expectedEvents)
        XCTAssertEqual(observerForSignal.events, expectedEvents)
    }

    // MARK: - PrimitiveSequence

    func testSingleMapTo() {
        // Given
        let expectedEvents = [SingleEvent.success("string")]
        var events: [SingleEvent<String>] = []
        let observer: ((SingleEvent<String>) -> Void) = { event in
            events.append(event)
        }

        // When
        _ = Single.just(0)
            .map(to: "string")
            .subscribe(observer)

        // Then
        XCTAssertEqual(events, expectedEvents)
    }

    func testMaybeMapTo() {
        // Given
        let expectedEvents = [MaybeEvent.success("string")]
        var events: [MaybeEvent<String>] = []
        let observer: ((MaybeEvent<String>) -> Void) = { event in
            events.append(event)
        }

        // When
        _ = Maybe.just(0)
            .map(to: "string")
            .subscribe(observer)

        // Then
        XCTAssertEqual(events, expectedEvents)
    }

    func testSingleMapAt() {
        // Given
        let expectedEvents = [SingleEvent.success("string")]
        var events: [SingleEvent<String>] = []
        let observer: ((SingleEvent<String>) -> Void) = { event in
            events.append(event)
        }

        // When
        _ = Single.just(Model(property: "string"))
            .map(at: \.property)
            .subscribe(observer)

        // Then
        XCTAssertEqual(events, expectedEvents)
    }

    func testMaybeMapAt() {
        // Given
        let expectedEvents = [MaybeEvent.success("string")]
        var events: [MaybeEvent<String>] = []
        let observer: ((MaybeEvent<String>) -> Void) = { event in
            events.append(event)
        }

        // When
        _ = Maybe.just(Model(property: "string"))
            .map(at: \.property)
            .subscribe(observer)

        // Then
        XCTAssertEqual(events, expectedEvents)
    }

    // MARK: - Helper Struct

    struct Model {
        let property: String
    }
}
