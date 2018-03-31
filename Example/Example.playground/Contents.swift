//: # STDev Rx Extensions
/*:
 > # IMPORTANT: To use **Example.playground**:
 1. Open **STDevRxExt.xcworkspace**.
 1. Build the **STDevRxExt-Example** scheme (**Product** → **Build**).
 1. Open **Example.payground** playground in the **Project navigator**.
 1. Show the Debug Area (**View** → **Debug Area** → **Show Debug Area**).
 ----
 */

import UIKit
import STDevRxExt
import RxSwift
import RxCocoa

/*:
 ## Filter Extensions
*/

example("allowTrue") {

    let disposeBag = DisposeBag()

    Observable.of(true, false, false, true, true)
        .allowTrue()
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)

}

example("allowTrue Optional") {

    let disposeBag = DisposeBag()

    Observable.of(true, false, nil, true, nil, true)
        .allowTrue()
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)

}

example("allowFalse") {

    let disposeBag = DisposeBag()

    Observable.of(true, false, false, true, false)
        .allowFalse()
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)

}

example("allowFalse Optional") {

    let disposeBag = DisposeBag()

    Observable.of(true, false, nil, true, nil, true, false)
        .allowFalse()
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)

}

example("allowTrueOrNil") {
    let disposeBag = DisposeBag()

    Observable.of(true, false, nil, true, nil, true, false)
        .allowTrueOrNil()
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)

}

example("allowFalseOrNil") {
    let disposeBag = DisposeBag()

    Observable.of(true, false, nil, true, nil, true, false)
        .allowFalseOrNil()
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
    
}

example("filterIfNil") {

    let disposeBag = DisposeBag()

    var optional: String? = nil

    let subject = PublishSubject<String>()

    subject
        .filterIfNil(optional)
        .subscribe(onNext: { print("Subscription1 --> \($0)") })
        .disposed(by: disposeBag)

    optional = "enable"

    subject
        .filterIfNil(optional)
        .subscribe(onNext: { print("Subscription2 --> \($0)") })
        .disposed(by: disposeBag)

    subject.onNext("🐹")

    subject.onNext("🐭")
}

example("filterIfNotNil") {

    let disposeBag = DisposeBag()

    var optional: String? = nil

    let subject = PublishSubject<String>()

    subject
        .filterIfNotNil(optional)
        .subscribe(onNext: { print("Subscription1 --> \($0)") })
        .disposed(by: disposeBag)

    optional = "enable"

    subject
        .filterIfNotNil(optional)
        .subscribe(onNext: { print("Subscription2 --> \($0)") })
        .disposed(by: disposeBag)

    subject.onNext("🐹")

    subject.onNext("🐭")
}

/*:
 ## Map Extensions
 */

example("map(to:)") {

    let disposeBag = DisposeBag()

    Observable.of(1, 5, 7, 8)
        .map(to: "ping")
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)

}

example("map(at:)") {

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

}

/*:
 ## Cast Extensions
 */

example("cast(to:)") {
    let disposeBag = DisposeBag()

    Observable<CustomStringConvertible>.of("1", "5", "7", "8")
        .cast(to: String.self)
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)

}

example("forceCast(to:)") {
    let disposeBag = DisposeBag()

    Observable<CustomStringConvertible>.of("1", "5", "7", "8")
        .forceCast(to: String.self)
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)

}
