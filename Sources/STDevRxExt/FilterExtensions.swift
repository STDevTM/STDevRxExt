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
    func allowNil<T>() -> Observable<Element> where Element == T? {
        return filter { $0 == nil }
    }
}

// MARK: - SharedSequence

public extension SharedSequenceConvertibleType where Element == Bool {
    func allowTrue() -> SharedSequence<SharingStrategy, Element> {
        return filter { $0 }
    }

    func allowFalse() -> SharedSequence<SharingStrategy, Element> {
        return filter { !$0 }
    }
}

public extension SharedSequenceConvertibleType where Element == Bool? {
    func allowTrue() -> SharedSequence<SharingStrategy, Bool> {
        return map { $0 ?? false }
            .allowTrue()
    }

    func allowTrueOrNil() -> SharedSequence<SharingStrategy, Bool> {
        return map { $0 ?? true }
            .allowTrue()
    }

    func allowFalse() -> SharedSequence<SharingStrategy, Bool> {
        return map { $0 ?? true }
            .allowFalse()
    }

    func allowFalseOrNil() -> SharedSequence<SharingStrategy, Bool> {
        return map { $0 ?? false }
            .allowFalse()
    }
}

public extension SharedSequenceConvertibleType {
    func allowNil<T>() -> SharedSequence<SharingStrategy, Element> where Element == T? {
        return filter { $0 == nil }
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
    func allowNil<T>() -> Maybe<Element> where Element == T? {
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
    func allowNil<T>() -> Maybe<Element> where Element == T? {
        return filter { $0 == nil }
    }
}
