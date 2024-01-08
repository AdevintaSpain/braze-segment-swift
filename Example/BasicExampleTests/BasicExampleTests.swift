@testable import SegmentBraze
import XCTest

final class BasicExampleTests: XCTestCase {

    func testNewEntriesAreReturned() {
        let old: [String: Any] = [:]
        let new: [String: Any] = ["name": "something"]

        let ret = old.newOrDifferentEntries(from: new)

        let retDict = NSDictionary(dictionary: ret, copyItems: false)
        let newDict = NSDictionary(dictionary: new, copyItems: false)
        XCTAssertEqual(retDict, newDict)
    }

    func testDifferentEntriesAreReturned() {
        let old: [String: Any] = ["name": "old value"]
        let new: [String: Any] = ["name": "new value"]

        let ret = old.newOrDifferentEntries(from: new)

        let retDict = NSDictionary(dictionary: ret, copyItems: false)
        let newDict = NSDictionary(dictionary: new, copyItems: false)
        XCTAssertEqual(retDict, newDict)
    }

    func testExistingEntriesAreIgnored() {
        let old: [String: Any] = ["name": "value"]
        let new: [String: Any] = ["name": "value"]

        let ret = old.newOrDifferentEntries(from: new)

        XCTAssertTrue(ret.keys.isEmpty)
    }

    func testDifferentExistingEntriesAreIgnored() {
        let old: [String: Any] = [
            "name": "value",
            "another_name": "another value",
        ]
        let new: [String: Any] = ["name": "value"]

        let ret = old.newOrDifferentEntries(from: new)

        XCTAssertTrue(ret.keys.isEmpty)
    }

    func testObjectEqualEntriesAreChecked() {
        let old: [String: Any] = [
            "name": "value",
            "object_key": ["key": "another value",
                           "another_key": 2,
                          ]
        ]
        let new: [String: Any] = [
            "name": "value",
            "object_key": ["key": "another value",
                           "another_key": 2,
                          ]
        ]

        let ret = old.newOrDifferentEntries(from: new)

        XCTAssertTrue(ret.keys.isEmpty)
    }

    func testObjectEntriesAreIncluded() {
        let old: [String: Any] = [:]
        let new: [String: Any] = [
            "object_key": ["key": "another value",
                           "another_key": 2,
                          ]
        ]

        let ret = old.newOrDifferentEntries(from: new)

        let retDict = NSDictionary(dictionary: ret, copyItems: false)
        let newDict = NSDictionary(dictionary: new, copyItems: false)
        XCTAssertEqual(retDict, newDict)
    }

    func testDifferentObjectEntriesAreIncluded() {
        let old: [String: Any] = [
            "name": "something",
            "object_key": ["key": "another value",
                           "another_key": 1,
                          ]
        ]
        let new: [String: Any] = [
            "object_key": ["key": "another value",
                           "another_key": 2,
                          ]
        ]

        let ret = old.newOrDifferentEntries(from: new)

        let retDict = NSDictionary(dictionary: ret, copyItems: false)
        let newDict = NSDictionary(dictionary: new, copyItems: false)
        XCTAssertEqual(retDict, newDict)
    }
}
