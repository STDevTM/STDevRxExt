//
//  OtherExtensionsTests.swift
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

class OtherExtensionsTests: XCTestCase {
    private let scheduler = TestScheduler(initialClock: 0)

    private var coldObservable: TestableObservable<Void>!
    private let expectedEvents = Recorded.events([
        .next(10, "string"),
        .next(20, "string"),
        .next(30, "string"),
    ])

    override func setUp() {
        super.setUp()

        coldObservable = scheduler.createColdObservable([
            .next(10, ()),
            .next(20, ()),
            .next(30, ()),
            .completed(40),
        ])
    }

    // MARK: - Observable

    func testObservableUpdate() {
        // Given
        let observerToUpdate = scheduler.createObserver(String.self)

        // When
        _ = coldObservable
            .update(observerToUpdate, with: "string")
            .subscribe()

        scheduler.start()

        // Then
        XCTAssertEqual(observerToUpdate.events, expectedEvents)
    }

    // MARK: - SharedSequence

    func testSharedSequenceUpdate() {
        // Given
        let observerToUpdateForDriver = scheduler.createObserver(String.self)
        let observerToUpdateForSignal = scheduler.createObserver(String.self)

        // When
        _ = coldObservable.asDriver(onErrorDriveWith: .empty())
            .update(observerToUpdateForDriver, with: "string")
            .drive()

        _ = coldObservable.asSignal(onErrorSignalWith: .empty())
            .update(observerToUpdateForSignal, with: "string")
            .emit()

        scheduler.start()

        // Then
        XCTAssertEqual(observerToUpdateForDriver.events, expectedEvents)
        XCTAssertEqual(observerToUpdateForSignal.events, expectedEvents)
    }

    // MARK: - PrimitiveSequence

    func testPrimitiveSequenceUpdate() {
        // Given
        let observerToUpdateForSingle = scheduler.createObserver(String.self)
        let observerToUpdateForMaybe = scheduler.createObserver(String.self)

        // When
        _ = Single.just(0)
            .update(observerToUpdateForSingle, with: "string")
            .subscribe()

        _ = Maybe.just(0)
            .update(observerToUpdateForMaybe, with: "string")
            .subscribe()

        scheduler.start()

        // Then
        XCTAssertEqual(observerToUpdateForSingle.events, [.next(0, "string")])
        XCTAssertEqual(observerToUpdateForMaybe.events, [.next(0, "string")])
    }
}
