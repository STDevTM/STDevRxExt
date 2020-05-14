//
//  FilterExtensions.swift
//  Pods-STDevRxExt_Example
//
//  Created by Tigran Hambardzumyan on 3/28/18.
//

import RxCocoa
import RxSwift

// MARK: - Observable

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
    func filterIfNil(_ param: Any?) -> Observable<Element> {
        return filter { _ in param != nil }
    }

    func filterIfNotNil(_ param: Any?) -> Observable<Element> {
        return filter { _ in param == nil }
    }
}

public extension ObservableType where Element == Any? {
    func allowNil() -> Observable<Element> {
        return filter { $0 == nil }
    }
}

// MARK: - Driver

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
    func filterIfNil(_ param: Any?) -> Driver<Element> {
        return filter { _ in param == nil }
    }

    func filterIfNotNil(_ param: Any?) -> Driver<Element> {
        return filter { _ in param != nil }
    }
}

// MARK: - Single

public extension PrimitiveSequenceType where Trait == SingleTrait, Element == Bool {
    func allowTrue() -> Maybe<Bool> {
        return filter { $0 }
    }

    func allowFalse() -> Maybe<Bool> {
        return filter { !$0 }
    }
}

public extension PrimitiveSequenceType where Trait == SingleTrait, Element == Bool? {
    func allowTrue() -> Maybe<Bool> {
        return map { $0 ?? false }
            .allowTrue()
    }

    func allowTrueOrNil() -> Maybe<Bool> {
        return map { $0 ?? true }
            .allowTrue()
    }

    func allowFalse() -> Maybe<Bool> {
        return map { $0 ?? true }
            .allowFalse()
    }

    func allowFalseOrNil() -> Maybe<Bool> {
        return map { $0 ?? false }
            .allowFalse()
    }
}

public extension PrimitiveSequenceType where Trait == SingleTrait {
    func filterIfNil(_ param: Any?) -> Maybe<Element> {
        return filter { _ in param != nil }
    }

    func filterIfNotNil(_ param: Any?) -> Maybe<Element> {
        return filter { _ in param == nil }
    }
}

public extension PrimitiveSequenceType where Trait == SingleTrait, Element == Any? {
    func allowNil() -> Maybe<Element> {
        return filter { $0 == nil }
    }
}

// MARK: - Maybe

public extension PrimitiveSequenceType where Trait == MaybeTrait, Element == Bool {
    func allowTrue() -> Maybe<Bool> {
        return filter { $0 }
    }

    func allowFalse() -> Maybe<Bool> {
        return filter { !$0 }
    }
}

public extension PrimitiveSequenceType where Trait == MaybeTrait, Element == Bool? {
    func allowTrue() -> Maybe<Bool> {
        return map { $0 ?? false }
            .allowTrue()
    }

    func allowTrueOrNil() -> Maybe<Bool> {
        return map { $0 ?? true }
            .allowTrue()
    }

    func allowFalse() -> Maybe<Bool> {
        return map { $0 ?? true }
            .allowFalse()
    }

    func allowFalseOrNil() -> Maybe<Bool> {
        return map { $0 ?? false }
            .allowFalse()
    }
}

public extension PrimitiveSequenceType where Trait == MaybeTrait {
    func filterIfNil(_ param: Any?) -> Maybe<Element> {
        return filter { _ in param != nil }
    }

    func filterIfNotNil(_ param: Any?) -> Maybe<Element> {
        return filter { _ in param == nil }
    }
}

public extension PrimitiveSequenceType where Trait == MaybeTrait, Element == Any? {
    func allowNil() -> Maybe<Element> {
        return filter { $0 == nil }
    }
}
