//
//  CastExtensions.swift
//  STDevRxExt
//
//  Created by Tigran Hambardzumyan on 3/28/18.
//

import RxCocoa
import RxSwift

public enum RxCastError: Error {
    case castFailed
}

// MARK: - Observable

public extension ObservableType {
    func cast<T>(to type: T.Type) -> Observable<T?> {
        return map { $0 as? T }
    }

    func forceCast<T>(to type: T.Type) -> Observable<T> {
        return map { value in
            if let casted = value as? T {
                return casted
            } else {
                throw RxCastError.castFailed
            }
        }
    }
}

// MARK: - SharedSequence

public extension SharedSequenceConvertibleType {
    func cast<T>(to type: T.Type) -> SharedSequence<SharingStrategy, T?> {
        return map { $0 as? T }
    }
}

// MARK: - Single

public extension PrimitiveSequenceType where Trait == SingleTrait {
    func cast<T>(to type: T.Type) -> Single<T?> {
        return map { $0 as? T }
    }
}

// MARK: - Maybe

public extension PrimitiveSequenceType where Trait == MaybeTrait {
    func cast<T>(to type: T.Type) -> Maybe<T?> {
        return map { $0 as? T }
    }
}
