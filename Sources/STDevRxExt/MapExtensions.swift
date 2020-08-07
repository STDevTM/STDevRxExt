//
//  MapExtensions.swift
//  STDevRxExt
//
//  Created by Tigran Hambardzumyan on 3/28/18.
//

import RxCocoa
import RxSwift

// MARK: - Observable

public extension ObservableType {
    func map<T>(to value: T) -> Observable<T> {
        return map { _ in value }
    }

    func map<T>(at keyPath: KeyPath<Element, T>) -> Observable<T> {
        return map { $0[keyPath: keyPath] }
    }
}

// MARK: - SharedSequence

public extension SharedSequenceConvertibleType {
    func map<T>(to value: T) -> SharedSequence<SharingStrategy, T> {
        return map { _ in value }
    }

    func map<T>(at keyPath: KeyPath<Element, T>) -> SharedSequence<SharingStrategy, T> {
        return map { $0[keyPath: keyPath] }
    }
}

// MARK: - Single

public extension PrimitiveSequenceType where Trait == SingleTrait {
    func map<T>(to value: T) -> Single<T> {
        return map { _ in value }
    }

    func map<T>(at keyPath: KeyPath<Element, T>) -> Single<T> {
        return map { $0[keyPath: keyPath] }
    }
}

// MARK: - Maybe

public extension PrimitiveSequenceType where Trait == MaybeTrait {
    func map<T>(to value: T) -> Maybe<T> {
        return map { _ in value }
    }

    func map<T>(at keyPath: KeyPath<Element, T>) -> Maybe<T> {
        return map { $0[keyPath: keyPath] }
    }
}
