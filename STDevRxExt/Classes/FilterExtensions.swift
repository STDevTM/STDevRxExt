//
//  FilterExtensions.swift
//  Pods-STDevRxExt_Example
//
//  Created by Tigran Hambardzumyan on 3/28/18.
//

import Foundation
import RxSwift
import RxCocoa

public extension ObservableType where E == Bool {

    public func allowTrue() -> Observable<Bool> {
        return filter { $0 }
    }

    public func allowFalse() -> Observable<Bool> {
        return filter { !$0 }
    }

}

public extension ObservableType where E == Bool? {

    public func allowTrue() -> Observable<Bool> {
        return map { $0 ?? false }
            .allowTrue()
    }

    public func allowTrueOrNil() -> Observable<Bool> {
        return map { $0 ?? true }
            .allowTrue()
    }

    public func allowFalse() -> Observable<Bool> {
        return map { $0 ?? true }
            .allowFalse()
    }

    public func allowFalseOrNil() -> Observable<Bool> {
        return map { $0 ?? false }
            .allowFalse()
    }

}

public extension ObservableType {

    public func filterIfNil(_ param: Optional<Any>) -> Observable<E> {
        return filter { _ in param != nil }
    }

    public func filterIfNotNil(_ param: Optional<Any>) -> Observable<E> {
        return filter { _ in param == nil }
    }

}

public extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy, E == Bool {

    public func allowTrue() -> Driver<Bool> {
        return filter { $0 }
    }

    public func allowFalse() -> Driver<Bool> {
        return filter { !$0 }
    }

}

public extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy, E == Bool? {

    public func allowTrue() -> Driver<Bool> {
        return filter { $0 ?? false }
            .map { $0! }
    }

    public func allowTrueOrNil() -> Driver<Bool> {
        return filter { $0 ?? true }
            .map { $0! }
    }

    public func allowFalse() -> Driver<Bool> {
        return filter { !($0 ?? true) }
            .map { $0! }
    }

    public func allowFalseOrNil() -> Driver<Bool> {
        return filter { !($0 ?? false) }
            .map { $0! }
    }

}

public extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {

    public func filterIfNil(_ param: Optional<Any>) -> Driver<E> {
        return filter { _ in param == nil }
    }

    public func filterIfNotNil(_ param: Optional<Any>) -> Driver<E> {
        return filter { _ in param != nil }
    }

}
