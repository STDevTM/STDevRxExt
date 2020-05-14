//
//  OtherExtensions.swift
//  STDevRxExt
//
//  Created by Tigran Hambardzumyan on 5/15/18.
//

import RxCocoa
import RxSwift

// MARK: - Observable

public extension ObservableType {
    func update<T: ObserverType>(_ observer: T, with value: T.Element) -> Observable<Self.Element> {
        return self.do(onNext: { [observer] _ in
            observer.onNext(value)
        })
    }
}

// MARK: - Driver

public extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {
    func update<T: ObserverType>(_ observer: T, with value: T.Element) -> SharedSequence<DriverSharingStrategy, Self.Element> {
        return self.do(onNext: { [observer] _ in
            observer.onNext(value)
        })
    }
}

// MARK: - Single

public extension PrimitiveSequenceType where Trait == SingleTrait {
    func update<T: ObserverType>(_ observer: T, with value: T.Element) -> Single<Self.Element> {
        return self.do(onSuccess: { [observer] _ in
            observer.onNext(value)
        })
    }
}

// MARK: - Maybe

public extension PrimitiveSequenceType where Trait == MaybeTrait {
    func update<T: ObserverType>(_ observer: T, with value: T.Element) -> Maybe<Self.Element> {
        return self.do(onNext: { [observer] _ in
            observer.onNext(value)
        })
    }
}
