import Foundation

/**
 Encloses each code example in its own scope. Prints a `description` header and then executes the `action` closure.
 - parameter description: example description
 - parameter action: `Void` closure
 */
public func example(_ description: String, action: () -> Void) {
    printExampleHeader(description)
    action()
}

public func printExampleHeader(_ description: String) {
    print("\n--- \(description) example ---")
}

public class Book {
    public let title: String
    public let author: Author

    public init(title: String, author: Author) {
        self.title = title
        self.author = author
    }
}

public struct Author {
    public let firstName: String
    public let lastName: String

    public init(_ firstName: String, _ lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

#if NOT_IN_PLAYGROUND

    public func playgroundShouldContinueIndefinitely() { }

#else

    import PlaygroundSupport

    public func playgroundShouldContinueIndefinitely() {
        PlaygroundPage.current.needsIndefiniteExecution = true
    }

#endif
