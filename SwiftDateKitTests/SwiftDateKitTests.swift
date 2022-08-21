//
//  SwiftDateKitTests.swift
//  SwiftDateKitTests
//
//  Created by Kanishk Gupta on 18/08/22.
//

import XCTest
@testable import SwiftDateKit

var sdk : SwiftDateKit!
var testdate : Date!
var testdate2 : Date!

class SwiftDateKitTests: XCTestCase {
    
    override func setUp() {
        sdk = SwiftDateKit.instance
        testdate = sdk.dateFromString("2022/08/31")
        testdate2 = sdk.dateFromString("2022/09/2")
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDLTime() throws {
        XCTAssertEqual( sdk.dateToDLTime(testdate), "12:00:00 AM")
    }

    func testDateComponents() throws {
        XCTAssertEqual( sdk.getDayOfWeekForDate(date: Date()), "Sun")
        XCTAssertEqual( sdk.getDayOfWeekForDate(date: testdate), "Wed")
        XCTAssertNotEqual( sdk.getDayOfWeekForDate(date: testdate), "Sat")
        
        XCTAssertEqual( sdk.getDateNumberForDate(date: Date()), "21")
        XCTAssertEqual( sdk.getDateNumberForDate(date: testdate), "31")
        
        XCTAssertEqual( sdk.getCurrentMonth(date: Date()), "August")
        XCTAssertEqual( sdk.getCurrentMonth(date: testdate), "August")
        
        
        var date = sdk.dateFromString("2021/12/31")
        var dates = sdk.getBeginAndEndWeek(date!)
        
        var bDate = sdk.dateFromString("2021/12/26")
        var eDate = sdk.dateFromString("2022/01/1")
        
        XCTAssertEqual(dates?.0, bDate)
        XCTAssertEqual(dates?.1, eDate)
        
        
        dates = sdk.getBeginAndEndMonth(Date())
        
        bDate = sdk.dateFromString("2022/08/01")
        eDate = sdk.dateFromString("2022/08/31")
        
        XCTAssertEqual(dates?.0, bDate)
        XCTAssertEqual(dates?.1, eDate)
        
        
        dates = sdk.getBeginAndEndYear(Date())
        
        bDate = sdk.dateFromString("2022/01/01")
        eDate = sdk.dateFromString("2022/12/31")
        
        XCTAssertEqual(dates?.0, bDate)
        XCTAssertEqual(dates?.1, eDate)
        
        
    }
    
    func testDateStrings() {
        XCTAssertEqual(sdk.dayMonthString(date: Date()), "21st August")
        XCTAssertEqual(sdk.dayMonthString(date: testdate), "31st August")
        XCTAssertEqual(sdk.dayMonthString(date: testdate2), "2nd September")
        
        XCTAssertEqual(sdk.dayMonthYearString(date: Date()), "21 August 2022")
        XCTAssertEqual(sdk.dayMonthYearString(date: testdate), "31 August 2022")
        XCTAssertEqual(sdk.dayMonthYearString(date: testdate2), "2 September 2022")
        
        XCTAssertEqual(sdk.getVerySmallDisplayString(date: Date()), "Today")
        
        testdate = sdk.subtract(days:1, to: Date())
        
        XCTAssertEqual(sdk.getVerySmallDisplayString(date: testdate), "Yesterday")
        
        testdate = sdk.subtract(days:5, to: Date())
        
        XCTAssertEqual(sdk.getVerySmallDisplayString(date: testdate), "16 Aug")
        
        testdate = sdk.subtract(years:2, months: 2, to: Date())
        
        XCTAssertEqual(sdk.getVerySmallDisplayString(date: testdate), "Jun 2020")
        
        testdate = sdk.subtract(days:1, to: Date())
        
        XCTAssertEqual(sdk.stringForMapKey(testdate), "Saturday, August 20, 2022")
        
        testdate = sdk.dateFromString("2022/08/31")
        
        XCTAssertEqual(sdk.dateFromMapKey("Wednesday, August 31, 2022"), testdate)
        
        testdate = sdk.add(days: 1, to: testdate2)
        
        XCTAssertNotEqual(testdate2, testdate)
        
        
        XCTAssertEqual(sdk.dayMonthString(date: testdate), "3rd September")
        
        testdate = sdk.subtract(days:1, to: Date())
        
        XCTAssertEqual(sdk.getSmallDisplayString(date: testdate), "1 day ago")
        
        testdate = sdk.subtract(hours:2, to: Date())
        
        XCTAssertEqual(sdk.getSmallDisplayString(date: testdate), "2 hours ago")
        
        testdate = sdk.subtract(minutes:10, to: Date())
        
        XCTAssertEqual(sdk.getSmallDisplayString(date: testdate), "10 mins ago")
        
        testdate = sdk.subtract(seconds:10, to: Date())
        
        XCTAssertEqual(sdk.getSmallDisplayString(date: testdate), "Now")
        
        testdate = sdk.subtract(months:2, days: 2, to: Date())
        
        XCTAssertEqual(sdk.getSmallDisplayString(date: testdate), "2 months ago")
        
        testdate = sdk.subtract(days:10, to: Date())
        
        XCTAssertEqual(sdk.getSmallDisplayString(date: testdate), "1 week ago")
        
        testdate = sdk.subtract(days:20, to: Date())
        
        XCTAssertEqual(sdk.getSmallDisplayString(date: testdate), "2 weeks ago")
    }
    
    func testTimeStrings() {
        XCTAssertEqual(sdk.timeStringWith(time_interval: TimeInterval(7*60*60)), "07:00:00")
        
        XCTAssertEqual(sdk.timeStringWith(time_interval: TimeInterval( 60*30)), "00:30:00")
        XCTAssertEqual(sdk.timeStringWith(time_interval: TimeInterval(14*60*60 + 60*30 + 55)), "14:30:55")
        
        XCTAssertEqual(sdk.timeStringWith(time_interval: TimeInterval(30*60*60 + 60*30 + 55)), "30:30:55")
        
        
        XCTAssertEqual(sdk.makeTimeString(14*60*60 + 60*30 + 55), "14 hrs 30 mins")
        XCTAssertEqual(sdk.makeTimeString(60*60 + 60*30 ), "1 hr 30 mins")
        XCTAssertEqual(sdk.makeTimeString(2*60*60 + 60 ), "2 hrs 1 min")
        XCTAssertEqual(sdk.makeTimeString(7*60*60), "7 hrs")
        XCTAssertEqual(sdk.makeTimeString(60*55 ), "55 mins")
        
        testdate = sdk.add(minutes: 30, to: testdate)
        
//        XCTAssertEqual(sdk.timeString(date: testdate), <#T##expression2: Equatable##Equatable#>)
    }
    
    func testDayStrings() {
        XCTAssertEqual(sdk.getDayStringForIntValue(3), "\(Days.Tuesday)")
        XCTAssertEqual(sdk.getDayStringForIntValue(8), "\(Days.Saturday)")
        XCTAssertEqual(sdk.getDayStringForIntValue(1), "\(Days.Sunday)")
        XCTAssertEqual(sdk.getDayStringForIntValue(2), "\(Days.Monday)")
        XCTAssertEqual(sdk.getDayStringForIntValue(4), "\(Days.Wednesday)")
        XCTAssertEqual(sdk.getDayStringForIntValue(5), "\(Days.Thursday)")
        XCTAssertEqual(sdk.getDayStringForIntValue(6), "\(Days.Friday)")
        
        XCTAssertEqual(sdk.convertArrayOfIndexesToDaysOfWeekArray(["2","4","3","1","6","7","5"], shortName: false), ["\(Days.Monday)", "\(Days.Wednesday)", "\(Days.Tuesday)", "\(Days.Sunday)", "\(Days.Friday)", "\(Days.Saturday)", "\(Days.Thursday)"])
        
        XCTAssertEqual(sdk.convertArrayOfIndexesToDaysOfWeekArray(["2","4","3","1","6","7","5"], shortName: true), ["Mon", "Wed", "Tue", "Sun", "Fri", "Sat", "Thu"])
        
        XCTAssertEqual(sdk.convertArrayOfIndexesToDaysOfWeekArray([2,4,3,1,6,7,5], shortName: true), ["Mon", "Wed", "Tue", "Sun", "Fri", "Sat", "Thu"])
        
        XCTAssertEqual(sdk.convertArrayOfDaysOfWeekToIndexArray(["\(Days.Monday)", "\(Days.Wednesday)", "\(Days.Tuesday)", "\(Days.Sunday)", "\(Days.Friday)", "\(Days.Saturday)", "\(Days.Thursday)"]), ["2", "4", "3", "1", "6", "7", "5"])
        
        XCTAssertEqual(sdk.getDayStringForIntValue(1), "\(Days.Sunday)")
        XCTAssertEqual(sdk.getDayStringForIntValue(2), "\(Days.Monday)")
        XCTAssertEqual(sdk.getDayStringForIntValue(3), "\(Days.Tuesday)")
        XCTAssertEqual(sdk.getDayStringForIntValue(4), "\(Days.Wednesday)")
        XCTAssertEqual(sdk.getDayStringForIntValue(5), "\(Days.Thursday)")
        XCTAssertEqual(sdk.getDayStringForIntValue(6), "\(Days.Friday)")
        XCTAssertEqual(sdk.getDayStringForIntValue(7), "\(Days.Saturday)")
        
    }
    
    func testDateRelativity() {
        testdate = sdk.add(days: 1, to: Date())
        
        XCTAssertTrue(sdk.isThisDateTomorrow(testdate))
        
        testdate = sdk.subtract(days: 2, to: testdate)
        
        XCTAssertTrue(sdk.isThisDateYesterday(testdate))
        XCTAssertTrue(sdk.isThisDateToday(date: Date()))
        
        XCTAssertTrue(sdk.isThisFuture(date: testdate2))
        
        XCTAssertTrue(sdk.isThisDateFuture(date: testdate2))
    }
    
    func testDatesBetween() {
        let dates = [sdk.dateFromString("2022/08/21"),sdk.dateFromString("2022/08/22")]
        
        XCTAssertEqual(sdk.getAllDatesBetween(sdk.dateFromString("2022/08/20")!, endDate: sdk.dateFromString("2022/08/23")!, incrementUnit: .day, withWeekdayIndexFilter: nil), dates)
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
