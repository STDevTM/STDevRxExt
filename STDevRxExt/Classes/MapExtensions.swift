//
//  MapExtensions.swift
//  STDevRxExt
//
//  Created by Tigran Hambardzumyan on 3/28/18.
//

import Foundation
import RxSwift
import RxCocoa

public extension ObservableType {

    public func map<T>(to value: T) -> Observable<T> {
        return map { _ in value }
    }

    public func map<T>(at keyPath: KeyPath<E, T>) -> Observable<T> {
        return self.map { $0[keyPath: keyPath] }
    }

}

public extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {

    public func map<T>(to value: T) -> Driver<T> {
        return map { _ in value }
    }

    public func map<T>(at keyPath: KeyPath<E, T>) -> Driver<T> {
        return map { $0[keyPath: keyPath] }
    }

}
