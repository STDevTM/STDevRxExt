//
//  PrimitiveSequenceFilterExtensionsTests.swift
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

class PrimitiveSequenceFilterExtensionsTests: XCTestCase {
    func testPrimitiveSequenceAllowTrue() {
        singleAllowTrueTest(sequence: Single.just(true), expectedEvents: [.success(true)])
        singleAllowTrueTest(sequence: Single.just(false), expectedEvents: [.completed])
        maybeAllowTrueTest(sequence: Maybe.just(true), expectedEvents: [.success(true)])
        maybeAllowTrueTest(sequence: Maybe.just(false), expectedEvents: [.completed])
    }

    func testPrimitiveSequenceAllowFalse() {
        singleAllowFalseTest(sequence: Single.just(false), expectedEvents: [.success(false)])
        singleAllowFalseTest(sequence: Single.just(true), expectedEvents: [.completed])
        maybeAllowFalseTest(sequence: Maybe.just(false), expectedEvents: [.success(false)])
        maybeAllowFalseTest(sequence: Maybe.just(true), expectedEvents: [.completed])
    }

    func testPrimitiveSequenceAllowTrueOptional() {
        singleAllowTrueOptionalTest(sequence: Single.just(true), expectedEvents: [.success(true)])
        singleAllowTrueOptionalTest(sequence: Single.just(nil), expectedEvents: [.completed])
        singleAllowTrueOptionalTest(sequence: Single.just(false), expectedEvents: [.completed])
        maybeAllowTrueOptionalTest(sequence: Maybe.just(true), expectedEvents: [.success(true)])
        maybeAllowTrueOptionalTest(sequence: Maybe.just(nil), expectedEvents: [.completed])
        maybeAllowTrueOptionalTest(sequence: Maybe.just(false), expectedEvents: [.completed])
    }

    func testPrimitiveSequenceAllowFalseOptional() {
        singleAllowFalseOptionalTest(sequence: Single.just(false), expectedEvents: [.success(false)])
        singleAllowFalseOptionalTest(sequence: Single.just(nil), expectedEvents: [.completed])
        singleAllowFalseOptionalTest(sequence: Single.just(true), expectedEvents: [.completed])
        maybeAllowFalseOptionalTest(sequence: Maybe.just(false), expectedEvents: [.success(false)])
        maybeAllowFalseOptionalTest(sequence: Maybe.just(nil), expectedEvents: [.completed])
        maybeAllowFalseOptionalTest(sequence: Maybe.just(true), expectedEvents: [.completed])
    }

    func testPrimitiveSequenceAllowTrueOrNil() {
        singleAllowTrueOrNilTest(sequence: Single.just(true), expectedEvents: [.success(true)])
        singleAllowTrueOrNilTest(sequence: Single.just(nil), expectedEvents: [.success(true)])
        singleAllowTrueOrNilTest(sequence: Single.just(false), expectedEvents: [.completed])
        maybeAllowTrueOrNilTest(sequence: Maybe.just(true), expectedEvents: [.success(true)])
        maybeAllowTrueOrNilTest(sequence: Maybe.just(nil), expectedEvents: [.success(true)])
        maybeAllowTrueOrNilTest(sequence: Maybe.just(false), expectedEvents: [.completed])
    }

    func testPrimitiveSequenceAllowFalseOrNil() {
        singleAllowFalseOrNilTest(sequence: Single.just(false), expectedEvents: [.success(false)])
        singleAllowFalseOrNilTest(sequence: Single.just(nil), expectedEvents: [.success(false)])
        singleAllowFalseOrNilTest(sequence: Single.just(true), expectedEvents: [.completed])
        maybeAllowFalseOrNilTest(sequence: Maybe.just(false), expectedEvents: [.success(false)])
        maybeAllowFalseOrNilTest(sequence: Maybe.just(nil), expectedEvents: [.success(false)])
        maybeAllowFalseOrNilTest(sequence: Maybe.just(true), expectedEvents: [.completed])
    }

    func testPrimitiveSequenceAllowNil() {
        singleAllowNil(sequence: Single.just(nil), expectedEvents: [.success(nil)])
        singleAllowNil(sequence: Single.just(1), expectedEvents: [.completed])
        maybeAllowNil(sequence: Maybe.just(nil), expectedEvents: [.success(nil)])
        maybeAllowNil(sequence: Maybe.just(1), expectedEvents: [.completed])
    }

    private func singleAllowTrueTest(sequence: Single<Bool>, expectedEvents: [MaybeEvent<Bool>]) {
        // Given
        var events: [MaybeEvent<Bool>] = []
        let observer: ((MaybeEvent<Bool>) -> Void) = { event in
            events.append(event)
        }

        // When
        _ = sequence
            .allowTrue()
            .subscribe(observer)

        // Then
        XCTAssertEqual(events, expectedEvents)
    }

    private func maybeAllowTrueTest(sequence: Maybe<Bool>, expectedEvents: [MaybeEvent<Bool>]) {
        // Given
        var events: [MaybeEvent<Bool>] = []
        let observer: ((MaybeEvent<Bool>) -> Void) = { event in
            events.append(event)
        }

        // When
        _ = sequence
            .allowTrue()
            .subscribe(observer)

        // Then
        XCTAssertEqual(events, expectedEvents)
    }

    private func singleAllowFalseTest(sequence: Single<Bool>, expectedEvents: [MaybeEvent<Bool>]) {
        // Given
        var events: [MaybeEvent<Bool>] = []
        let observer: ((MaybeEvent<Bool>) -> Void) = { event in
            events.append(event)
        }

        // When
        _ = sequence
            .allowFalse()
            .subscribe(observer)

        // Then
        XCTAssertEqual(events, expectedEvents)
    }

    private func maybeAllowFalseTest(sequence: Maybe<Bool>, expectedEvents: [MaybeEvent<Bool>]) {
        // Given
        var events: [MaybeEvent<Bool>] = []
        let observer: ((MaybeEvent<Bool>) -> Void) = { event in
            events.append(event)
        }

        // When
        _ = sequence
            .allowFalse()
            .subscribe(observer)

        // Then
        XCTAssertEqual(events, expectedEvents)
    }

    private func singleAllowTrueOptionalTest(sequence: Single<Bool?>, expectedEvents: [MaybeEvent<Bool>]) {
        // Given
        var events: [MaybeEvent<Bool>] = []
        let observer: ((MaybeEvent<Bool>) -> Void) = { event in
            events.append(event)
        }

        // When
        _ = sequence
            .allowTrue()
            .subscribe(observer)

        // Then
        XCTAssertEqual(events, expectedEvents)
    }

    private func maybeAllowTrueOptionalTest(sequence: Maybe<Bool?>, expectedEvents: [MaybeEvent<Bool>]) {
        // Given
        var events: [MaybeEvent<Bool>] = []
        let observer: ((MaybeEvent<Bool>) -> Void) = { event in
            events.append(event)
        }

        // When
        _ = sequence
            .allowTrue()
            .subscribe(observer)

        // Then
        XCTAssertEqual(events, expectedEvents)
    }

    private func singleAllowFalseOptionalTest(sequence: Single<Bool?>, expectedEvents: [MaybeEvent<Bool>]) {
        // Given
        var events: [MaybeEvent<Bool>] = []
        let observer: ((MaybeEvent<Bool>) -> Void) = { event in
            events.append(event)
        }

        // When
        _ = sequence
            .allowFalse()
            .subscribe(observer)

        // Then
        XCTAssertEqual(events, expectedEvents)
    }

    private func maybeAllowFalseOptionalTest(sequence: Maybe<Bool?>, expectedEvents: [MaybeEvent<Bool>]) {
        // Given
        var events: [MaybeEvent<Bool>] = []
        let observer: ((MaybeEvent<Bool>) -> Void) = { event in
            events.append(event)
        }

        // When
        _ = sequence
            .allowFalse()
            .subscribe(observer)

        // Then
        XCTAssertEqual(events, expectedEvents)
    }

    private func singleAllowTrueOrNilTest(sequence: Single<Bool?>, expectedEvents: [MaybeEvent<Bool>]) {
        // Given
        var events: [MaybeEvent<Bool>] = []
        let observer: ((MaybeEvent<Bool>) -> Void) = { event in
            events.append(event)
        }

        // When
        _ = sequence
            .allowTrueOrNil()
            .subscribe(observer)

        // Then
        XCTAssertEqual(events, expectedEvents)
    }

    private func maybeAllowTrueOrNilTest(sequence: Maybe<Bool?>, expectedEvents: [MaybeEvent<Bool>]) {
        // Given
        var events: [MaybeEvent<Bool>] = []
        let observer: ((MaybeEvent<Bool>) -> Void) = { event in
            events.append(event)
        }

        // When
        _ = sequence
            .allowTrueOrNil()
            .subscribe(observer)

        // Then
        XCTAssertEqual(events, expectedEvents)
    }

    private func singleAllowFalseOrNilTest(sequence: Single<Bool?>, expectedEvents: [MaybeEvent<Bool>]) {
        // Given
        var events: [MaybeEvent<Bool>] = []
        let observer: ((MaybeEvent<Bool>) -> Void) = { event in
            events.append(event)
        }

        // When
        _ = sequence
            .allowFalseOrNil()
            .subscribe(observer)

        // Then
        XCTAssertEqual(events, expectedEvents)
    }

    private func maybeAllowFalseOrNilTest(sequence: Maybe<Bool?>, expectedEvents: [MaybeEvent<Bool>]) {
        // Given
        var events: [MaybeEvent<Bool>] = []
        let observer: ((MaybeEvent<Bool>) -> Void) = { event in
            events.append(event)
        }

        // When
        _ = sequence
            .allowFalseOrNil()
            .subscribe(observer)

        // Then
        XCTAssertEqual(events, expectedEvents)
    }

    private func singleAllowNil(sequence: Single<Int?>, expectedEvents: [MaybeEvent<Int?>]) {
        // Given
        var events: [MaybeEvent<Int?>] = []
        let observer: ((MaybeEvent<Int?>) -> Void) = { event in
            events.append(event)
        }

        // When
        _ = sequence
            .allowNil()
            .subscribe(observer)

        // Then
        XCTAssertEqual(events, expectedEvents)
    }

    private func maybeAllowNil(sequence: Maybe<Int?>, expectedEvents: [MaybeEvent<Int?>]) {
        // Given
        var events: [MaybeEvent<Int?>] = []
        let observer: ((MaybeEvent<Int?>) -> Void) = { event in
            events.append(event)
        }

        // When
        _ = sequence
            .allowNil()
            .subscribe(observer)

        // Then
        XCTAssertEqual(events, expectedEvents)
    }
}
