//
//  FilterExtensions.swift
//  Pods-STDevRxExt_Example
//
//  Created by Tigran Hambardzumyan on 3/28/18.
//

import Foundation
import RxSwift
import RxCocoa

public extension ObservableType where Element == Bool {

    func allowTrue() -> Observable<Bool> {
        return filter { $0 }
    }

    func allowFalse() -> Observable<Bool> {
        return filter { !$0 }
    }

}

public extension ObservableType where Element == Bool? {

    func allowTrue() -> Observable<Bool> {
        return map { $0 ?? false }
            .allowTrue()
    }

    func allowTrueOrNil() -> Observable<Bool> {
        return map { $0 ?? true }
            .allowTrue()
    }

    func allowFalse() -> Observable<Bool> {
        return map { $0 ?? true }
            .allowFalse()
    }

    func allowFalseOrNil() -> Observable<Bool> {
        return map { $0 ?? false }
            .allowFalse()
    }

}

public extension ObservableType {

    func filterIfNil(_ param: Optional<Any>) -> Observable<Element> {
        return filter { _ in param != nil }
    }

    func filterIfNotNil(_ param: Optional<Any>) -> Observable<Element> {
        return filter { _ in param == nil }
    }

}

public extension ObservableType where Element == Optional<Any> {

    func allowNil() -> Observable<Element> {
        return filter { $0 == nil }
    }

}

public extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy, Element == Bool {

    func allowTrue() -> Driver<Bool> {
        return filter { $0 }
    }

    func allowFalse() -> Driver<Bool> {
        return filter { !$0 }
    }

}

public extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy, Element == Bool? {

    func allowTrue() -> Driver<Bool> {
        return map { $0 ?? false }
            .allowTrue()
    }

    func allowTrueOrNil() -> Driver<Bool> {
        return map { $0 ?? true }
            .allowTrue()
    }

    func allowFalse() -> Driver<Bool> {
        return map { $0 ?? true }
            .allowFalse()
    }

    func allowFalseOrNil() -> Driver<Bool> {
        return map { $0 ?? false }
            .allowFalse()
    }

}

public extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {

    func filterIfNil(_ param: Optional<Any>) -> Driver<Element> {
        return filter { _ in param == nil }
    }

    func filterIfNotNil(_ param: Optional<Any>) -> Driver<Element> {
        return filter { _ in param != nil }
    }

}
