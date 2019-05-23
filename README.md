# STDevRxExt

[![CI Status](http://img.shields.io/travis/stdevteam/STDevRxExt.svg?style=flat)](https://travis-ci.org/stdevteam/STDevRxExt)
[![Version](https://img.shields.io/cocoapods/v/STDevRxExt.svg?style=flat)](http://cocoapods.org/pods/STDevRxExt)
[![License](https://img.shields.io/cocoapods/l/STDevRxExt.svg?style=flat)](http://cocoapods.org/pods/STDevRxExt)
[![Platform](https://img.shields.io/cocoapods/p/STDevRxExt.svg?style=flat)](http://cocoapods.org/pods/STDevRxExt)

## Example

To run the [Example.playground](Example/Example.playground), clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 11.2+
* Swift 5.0+
* Xcode 10.0+

## Installation

STDevRxExt is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'STDevRxExt'
```

## List of All Extensions

* [Filter Extensions](#filter-extensions)
* [Map Extensions](#map-extensions)
* [Cast Extensions](#cast_extensions)
* [Other Extensions](#other_extensions)
* _more coming soon_

### Filter Extensions

Allow only `true` elements from `Observable<Bool>`:

```swift
let disposeBag = DisposeBag()

Observable.of(true, false, false, true, true)
    .allowTrue()
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)
```

Output will be:

```text
true
true
true
```

You can use `allowTrue` on `Bool?` as well. In this case `nil` elements will be ignored:

```swift
let disposeBag = DisposeBag()

Observable.of(true, false, nil, true, nil, true)
    .allowTrue()
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)
```

Output will be:

```text
true
true
true
```

If you prefer to allow `nil` elements as well then you can use `allowTrueOrNil` like this:

```swift
let disposeBag = DisposeBag()

Observable.of(true, false, nil, true, nil, true, false)
    .allowTrueOrNil()
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)
```

Output will be:

```text
true
true
true
true
true
```

### Map Extensions

You can map every element in sequence with provided value.

```swift
let disposeBag = DisposeBag()

Observable.of(1, 5, 7, 8)
    .map(to: "ping")
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)
```

Output will be:

```text
ping
ping
ping
ping
```

You can map every element in sequence by procided Key Path.

```swift
let disposeBag = DisposeBag()

   let observable = Observable.of(
            Book(title: "Twenty Thousand Leagues Under the Sea", author: Author("Jules", "Verne")),
            Book(title: "Hamlet", author: Author("William", "Shakespeare")),
            Book(title: "Hearts of Three", author: Author("Jack", "London"))
        )

    observable
        .map(at: \.title)
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)

    observable
        .map(at: \.author.firstName)
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
```

Output will be:

```text
Twenty Thousand Leagues Under the Sea
Hamlet
Hearts of Three

Jules
William
Jack
```

### Cast Extensions

You can do downcast elements in sequence using `cast(to:)`.

```swift
let disposeBag = DisposeBag()

Observable<CustomStringConvertible>.of("1", "5", "7", "8")
    .cast(to: String.self)
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)
```

Output will be:

```text
Optional("1")
Optional("5")
Optional("7")
Optional("8")
```

In order to do force downcast use `forceCast(to:)` liek this:

```swift
let disposeBag = DisposeBag()

Observable<CustomStringConvertible>.of("1", "5", "7", "8")
    .forceCast(to: String.self)
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)
```

Output will be:

```text
1
5
7
8
```

In case of downcast exception it will return `Observable.error(RxCastError.castFailed)`.

Allow extension functions can be used on `Driver` as well, except `forceCast(to:)`.

### Other Extensions

Sometimes we need to update some subject or observer on each `next` event of `Observable` or `Driver`. For example:

```swift
request
    .do(onNext: { [weak self] _ in
        self?.inProgress.onNext(true)
    })
    .flatMap {
        service.doRequest($0)
    }
    .do(onNext: { [weak self] _ in
        self?.inProgress.onNext(false)
    })
    .subscribe(onNext: { response in
        dump(response)
    })
    .disposed(by: disposeBag)
```

You can use `update(_:with:)` method for shorting code like this:

```swift
request
    .update(inProgress, with: true)
    .flatMap {
        service.doRequest($0)
    }
    .update(inProgress, with: false)
    .subscribe(onNext: { response in
        dump(response)
    })
    .disposed(by: disposeBag)
```

## Author

Tigran Hambardzumyan, tigran@stdevmail.com

## Support

Feel free to [open issuses](https://github.com/stdevteam/STDevRxExt/issues/new) with any suggestions, bug reports, feature requests, questions.

## Let us know!

We’d be really happy if you sent us links to your projects where you use our component. Just send an email to developer@stdevmail.com And do let us know if you have any questions or suggestion.

## License

STDevRxExt is available under the MIT license. See the LICENSE file for more info.
