//
//  OtherExtensions.swift
//  STDevRxExt
//
//  Created by Tigran Hambardzumyan on 5/15/18.
//

import Foundation
import RxSwift
import RxCocoa

public extension ObservableType {

    public func update<T: ObserverType>(_ observer: T, with value: T.E) -> Observable<Self.E> {
        return self.do(onNext: { [observer] _ in
            observer.onNext(value)
        })
    }

}

public extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {

    public func update<T: ObserverType>(_ observer: T, with value: T.E) -> SharedSequence<DriverSharingStrategy, Self.E> {
        return self.do(onNext: { [observer] _ in
            observer.onNext(value)
        })
    }

}
