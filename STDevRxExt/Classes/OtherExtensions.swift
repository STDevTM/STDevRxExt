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

    func update<T: ObserverType>(_ observer: T, with value: T.Element) -> Observable<Self.Element> {
        return self.do(onNext: { [observer] _ in
            observer.onNext(value)
        })
    }

}

public extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {

    func update<T: ObserverType>(_ observer: T, with value: T.Element) -> SharedSequence<DriverSharingStrategy, Self.Element> {
        return self.do(onNext: { [observer] _ in
            observer.onNext(value)
        })
    }

}
