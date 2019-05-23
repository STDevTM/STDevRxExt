//
//  CastExtensions.swift
//  STDevRxExt
//
//  Created by Tigran Hambardzumyan on 3/28/18.
//

import Foundation
import RxSwift
import RxCocoa

public enum RxCastError: Error {
    case castFailed
}

public extension ObservableType {

    func cast<T>(to type: T.Type) -> Observable<T?> {
        return map { $0 as? T }
    }

    func forceCast<T>(to type: T.Type) -> Observable<T> {
        return flatMap { value in
            Observable.create { observer in
                if let casted = value as? T {
                    observer.onNext(casted)
                    observer.onCompleted()
                } else {
                    observer.onError(RxCastError.castFailed)
                }
                return Disposables.create()
            }
        }
    }

}

public extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {

    func cast<T>(to type: T.Type) -> Driver<T?> {
        return map { $0 as? T }
    }

}
