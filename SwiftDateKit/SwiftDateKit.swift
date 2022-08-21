//
//  SwiftDateKit.swift
//  SwiftDateKit
//
//  Created by Kanishk Gupta on 18/08/22.
//

import Foundation

public final class SwiftDateKit {
    
    static public let instance = SwiftDateKit()
    
    private init() {
        
    }
    
    // DL Date functions
    public func dateToDLTime(_ date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm:ss a"
        let result = formatter.string(from: date)
        
        return result
    }
    
    func getWeekdaysArray() -> [String] {
        return [NSLocalizedString("\(Days.Sunday)", comment: "\(Days.Sunday)"),NSLocalizedString("\(Days.Monday)", comment: "\(Days.Monday)"),NSLocalizedString("\(Days.Tuesday)", comment: "\(Days.Tuesday)"),NSLocalizedString("\(Days.Wednesday)", comment: "\(Days.Wednesday)"),NSLocalizedString("\(Days.Thursday)", comment: "\(Days.Thursday)"),NSLocalizedString("\(Days.Friday)", comment: "\(Days.Friday)"),NSLocalizedString("\(Days.Saturday)", comment: "\(Days.Saturday)")]
    }
    
     public func convertArrayOfDaysOfWeekToIndexArray(_ daysOfWeek:[String]) -> [String]{
        let weekdaysArray = getWeekdaysArray()
        var returnIndexes: [String] = []
        for day in daysOfWeek{
            if let indexExists = weekdaysArray.indexOfObject(weekdaysArray, object: day){
                returnIndexes += ["\(indexExists + 1)"]
            }
        }
        
        return returnIndexes
    }
    
     public func convertArrayOfIndexesToDaysOfWeekArray(_ indexes:[String], shortName: Bool) -> [String]{
        
        let formatter = DateFormatter()
        
        var weekdaysArray = getWeekdaysArray()
        if shortName {
            weekdaysArray = formatter.shortStandaloneWeekdaySymbols!
        }
        var returnDays: [String] = []
        for index in indexes{
            if let asInt = Int(index) {
                returnDays += [weekdaysArray[asInt - 1]]
                
            }
        }
        return returnDays
    }
    
    public func convertArrayOfIndexesToDaysOfWeekArray(_ indexes:[Int], shortName: Bool) -> [String]{
       
       let formatter = DateFormatter()
       
       var weekdaysArray = getWeekdaysArray()
       if shortName {
           weekdaysArray = formatter.shortStandaloneWeekdaySymbols!
       }
       var returnDays: [String] = []
       for index in indexes {
           returnDays += [weekdaysArray[index - 1]]
       }
       return returnDays
   }
    
    public func timeString(date : Date) -> String {
        var time_interval: TimeInterval = date.timeIntervalSince(Date())
        if time_interval < 0 {
            time_interval = 0
        }
        return self.timeStringWith(time_interval: time_interval)
    }
    
     public func timeStringWith(time_interval: TimeInterval) -> String {
        let hours = Int(time_interval) / 3600
        let minutes = Int(time_interval) / 60 % 60
        let seconds = Int(time_interval) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
     public func makeTimeString(_ value: Int) -> String {
        let seconds = value
        
        let hrValue = seconds/3600
        let minValue = (seconds/60)%60
        
        let hourString = hrValue == 1 ? "hr" : "hrs"
        let minString = minValue == 1 ? "min" : "mins"
        
        var tempStr = ""
        if hrValue != 0 && minValue != 0 {
            tempStr = "\(hrValue) \(hourString) \(minValue) \(minString)"
            
        } else if hrValue == 0 && minValue != 0 {
            tempStr = "\(minValue) \(minString)"
            
        } else if hrValue != 0 && minValue == 0 {
            tempStr = "\(hrValue) \(hourString)"
            
        }
        
        return tempStr
    }
    
     
    
    public func stringFromTimeIntervalShort(_ time : TimeInterval) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = DateComponentsFormatter.UnitsStyle.abbreviated
        formatter.allowedUnits = [NSCalendar.Unit.day, NSCalendar.Unit.hour, NSCalendar.Unit.minute]
        formatter.zeroFormattingBehavior = [DateComponentsFormatter.ZeroFormattingBehavior.dropLeading,DateComponentsFormatter.ZeroFormattingBehavior.dropTrailing, DateComponentsFormatter.ZeroFormattingBehavior.dropMiddle]
        formatter.maximumUnitCount = 2
        return formatter.string(from: time)
    }
    
    public func countDownTimeToDate(date : Date) -> String {
        if self.dayMonthYearString(date: Date()) == self.dayMonthYearString(date: date) {
            return "Today"
        } else if self.isThisDateFuture(date : date) {
            let duration = date.timeIntervalSince(Date())
            var string = ""
            var value = 0
            if (duration) < 24*60*60 {
                value = Int(duration)/(60*60)
                string = "\(value) hour"
            } else if (duration) < 24*7*60*60 {
                value = Int(duration)/(24*60*60)
                string = "\(value) day"
            } else if (duration) < 24*60*60*30 {
                value = Int(duration)/(24*7*60*60)
                string = "\(value) week"
            }  else if (duration) < 24*60*60*30*12 {
                value = Int(duration)/(24*60*60*30)
                string = "\(value) month"
            }  else {
                value = Int(duration)/(24*60*60*30*12)
                string = "\(value) year"
            }
            
            if value == 0 {
                value = 1
            }
            
            return string.numbers == "1" ? "\(string) to start" : "\(string)s to start"
        }
        return "Ended"
    }
    
    public func getSmallDisplayString(date : Date) -> String? {
        let duration = Date().timeIntervalSince(date)
        
        var string = ""
        var value = 0
        if duration < 60 {
            return "Now"
        } else if duration < 60*60 {
            string = "\(Int(duration/60)) min"
        } else if duration < 86400 {
            string = "\(Int(duration/3600)) hour"
        } else if (duration) < 24*7*60*60 {
            value = Int(duration)/(24*60*60)
            string = "\(value) day"
        } else if (duration) < 24*60*60*30 {
            value = Int(duration)/(24*7*60*60)
            string = "\(value) week"
        }  else if (duration) < 24*60*60*30*12 {
            value = Int(duration)/(24*60*60*30)
            string = "\(value) month"
        }  else {
            value = Int(duration)/(24*60*60*30*12)
            string = "\(value) year"
        }
        
        return string.numbers == "1" ? "\(string) ago" : "\(string)s ago"
    }
    
    public func getVerySmallDisplayString(date : Date) -> String? {
        let duration = Date().timeIntervalSince(date)
        
        let currentDate = Date()
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let currentYear = calendar.component(.year, from: currentDate)
        if year == currentYear {
            dateFormatterPrint.dateFormat = "d MMM"
        } else {
            dateFormatterPrint.dateFormat = "MMM yyyy"
        }
//        let calendar = Calendar.current
        if duration > 86400 {
            var days = Int(duration/86400)
            if duration.truncatingRemainder(dividingBy: 86400) > 0 {
                days += 1
            }
            if days == 2 {
                return "Yesterday"
            } else {
                return dateFormatterPrint.string(from: date)
            }
        } else if calendar.isDateInToday(date) {
            return "Today"
        } else {
            return "Yesterday"
        }
    }
    
    public func getCurrentMonth(date : Date) -> String {
        return self.stringFromDate(date, format: "MMMM")
    }
    
    public func getDayOfWeekForDate(date : Date) -> String {
        return self.stringFromDate(date, format: "E")
    }
    
    public func getDateNumberForDate(date : Date) -> String {
        return self.stringFromDate(date, format: "d")
    }
    
    public func dayMonthString(date : Date) -> String {
        var suffix = ""
        switch Int(self.getDateNumberForDate(date : date))! {
        case 1, 21, 31: suffix = "st"
        case 2, 22: suffix = "nd"
        case 3, 23: suffix = "rd"
        default: suffix = "th"
        }
        return "\(self.getDateNumberForDate(date: date))\(suffix) \(self.getCurrentMonth(date: date))"
    }
    
    public func dayMonthYearString(date : Date) -> String {
        return self.stringFromDate(date, format: "d MMMM yyyy")
    }
    
    public func fullStringDate(date : Date) -> String {
        return self.stringFromDate(date, format: "EEEE\nd MMMM yyyy")
    }
    
    public func getkey(date : Date) -> String {
        return self.stringFromDate(date, format: self.getGraphDateFormat())
    }
    
    public func dateFromString(_ dateString : String) -> Date? {
        return self.dateFromString(dateString, format: self.getGraphDateFormat())
    }
    
    public func normalStringFromDate(date : Date) -> String {
        return self.stringFromDate(date, format: "M-d, H:m:s")
    }
    
     public func standdardStringFromDate(_ date:Date) -> String {
         return self.stringFromDate(date, format: "yyyy-MM-dd")
    }
    
    // General Date functions
     public func stringToLocalizedDate(_ dateString:String, dateFormat:String, tzName:String) -> Date {
        let aDate = self.dateFromString(dateString, format: dateFormat)
        
        
        return aDate == nil ? dateToLocalizedDate(Date(), tzName: tzName) : dateToLocalizedDate(aDate!, tzName: tzName)
    }
    
    
     public func dateFromMapKey(_ keyDate:String) -> Date? {
        return dateFromString(keyDate, format: "EEEE, MMMM dd, yyyy")
    }
    
     public func stringForMapKey(_ date:Date) -> String {
        return stringFromDate(date, format: "EEEE, MMMM d, yyyy")
    }
    
     public func convertStringDate(_ fromString:String,withFormat:String,toFormat:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat
        
        let date = dateFormatter.date(from: fromString)
        dateFormatter.dateFormat = toFormat
        
        return date == nil ? "" : dateFormatter.string(from: date!)
    }
    
    
     public func stringFromDate(_ date:Date, format:String) -> String {
        let newDateFormatter = DateFormatter()
        newDateFormatter.locale = Locale.current
        newDateFormatter.dateFormat = format
        
        return newDateFormatter.string(from: date)
    }
    
     public func dateFromString(_ date:String?, format:String) -> Date? {
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = format
        let timezone = TimeZone.autoupdatingCurrent
        newDateFormatter.timeZone = timezone
        
        var result:Date? = nil
        
        if let theDate = date {
            result = newDateFormatter.date(from: theDate)
        }
        
        return result
    }
    
    public  func dateToLocalizedDate(_ aDate:Date, tzName:String) -> Date {
        var result:Date?
        
        let timeZone:TimeZone? = TimeZone(identifier: tzName)
        if let tz = timeZone as TimeZone? {
            let seconds:TimeInterval = TimeInterval(tz.secondsFromGMT())
            result = Date(timeInterval: seconds, since: aDate)
        }
        
        return result == nil ? aDate : result!
    }
    
    public  func currentDLCTimeWithFormat(_ format:String) -> String{
        let today = Date()
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.autoupdatingCurrent
        
        dateFormatter.timeZone = timezone
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: today)
    }
    public  func dateToLocalizedDate(_ date:Date) -> Date {
        return self.dateToLocalizedDate(date, tzName: "\(TimeZone.autoupdatingCurrent)")
    }
    
    public func doubleToLocalizedDate(_ gmtUnixEpoc:Double) -> Date {
        return dateToLocalizedDate(Date(timeIntervalSince1970: gmtUnixEpoc / 1000))
    }
    
    public func getDefaultTimeUsingDate(_ date : Date, dateFormat:String) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.string(from: date)
    }
    
    public func getDefaultTimeUsingGMTDoubleValue(_ GMTTime : Double, dateFormat:String) -> String {
        var timestamp : Double = GMTTime
        timestamp = timestamp/1000
        let date : Date = Date(timeIntervalSince1970: timestamp)
        
        return self.getDefaultTimeUsingDate(date, dateFormat: dateFormat)
    }
    
    public func getGraphDateFormat() -> String {
        return "yyyy-MM-dd"
    }
    
    public func getStartOfDayOnDate(_ date:Date) -> Date {
        //default end date - TODAY
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var tempDate = dateFormatter.string(from: date)
        tempDate = tempDate + " 00.00 AM"
        dateFormatter.dateFormat = "yyyy-MM-dd HH.mm aa"
        return dateFormatter.date(from: tempDate)!
    }
    
    public  func getEndOfDayOnDate(_ date:Date) -> Date {
        //default end date - TODAY
        var components = DateComponents()
        components.hour = 23
        components.minute = 59
        components.second = 59
        let endOfDay = (Calendar.current as NSCalendar).date(byAdding: components, to: date, options: NSCalendar.Options(rawValue: 0))
        return endOfDay!
    }
    
    public  func getAllDatesBetween(_ beginDate: Date, endDate: Date, incrementUnit:NSCalendar.Unit, withWeekdayIndexFilter:[Int]?) -> [Date]{
        
        if(beginDate.compare(endDate) == ComparisonResult.orderedDescending){
            return []
        }
        
        let calendar = Calendar.current
        
        let returnDatesSet: NSMutableSet = NSMutableSet()
        if(incrementUnit == NSCalendar.Unit.weekOfYear){
            var dayComponent = (calendar as NSCalendar).components([.weekday, .year,.weekOfYear], from: beginDate)
            dayComponent.weekday = 1
            if let setToSundaydateExists = calendar.date(from: dayComponent){
                returnDatesSet.add(setToSundaydateExists)
            }
        }
        else{
            returnDatesSet.add(beginDate)
        }
        if let weekFilterExists = withWeekdayIndexFilter{
            let weekdayIndexBegin = (calendar as NSCalendar).component(NSCalendar.Unit.weekday, from: beginDate)
            if weekFilterExists.contains((weekdayIndexBegin - 1)) {
                returnDatesSet.add(beginDate)
            }
        }
        
        var dayComponents = DateComponents()
        let numOfIncrement = 0
        while(true){
            
            switch(incrementUnit){
            case NSCalendar.Unit.year:
                dayComponents.year! += numOfIncrement
            case NSCalendar.Unit.month:
                dayComponents.month! += numOfIncrement
            case NSCalendar.Unit.weekOfYear:
                dayComponents.weekOfYear! += numOfIncrement
            default:
                dayComponents.day! += numOfIncrement
            }
            
            if var dateExists = (calendar as NSCalendar).date(byAdding: dayComponents, to: beginDate, options: NSCalendar.Options(rawValue: 0)) {
                if(incrementUnit == NSCalendar.Unit.weekOfYear){
                    var dayComponent = (calendar as NSCalendar).components([.weekday,.year,.weekOfYear], from: dateExists)
                    dayComponent.weekday = 1
                    if let setToSundaydateExists = calendar.date(from: dayComponent){
                        dateExists = setToSundaydateExists
                    }
                }
                
                if(dateExists.compare(endDate) == ComparisonResult.orderedDescending){
                    break
                }
                
                if let weekFilterExists = withWeekdayIndexFilter{
                    let weekdayIndexBegin = (calendar as NSCalendar).component(.weekday, from: dateExists)
                    if weekFilterExists.contains((weekdayIndexBegin - 1)) {
                        //returnDates += [dateExists]
                        returnDatesSet.add(dateExists)
                    }
                }
                else{
                    returnDatesSet.add(dateExists)
                }
                
            }
        }
        let datesArray = returnDatesSet.allObjects as! [Date]
        return datesArray.sorted{(date1, date2) -> Bool in
            return date1.compare(date2) == ComparisonResult.orderedAscending || date1.compare(date2) == ComparisonResult.orderedSame
        }
    }
    
    public func isThisDateYesterday(_ date : Date) -> Bool {
        //print("Yesterday Date : \(NSDate.getStartOfDayOnDate(NSDate(timeIntervalSinceNow: -1*24*60*60))) compare Date : \(date)")
        return self.getStartOfDayOnDate(Date(timeIntervalSinceNow: -1*24*60*60)).compare(self.getStartOfDayOnDate(date)) == ComparisonResult.orderedSame //&& NSDate.getStartOfDayOnDate(NSDate()).compare(date) == NSComparisonResult.OrderedAscending
    }
    
    public func isThisDateToday(date : Date) -> Bool {
        let greaterThanStart = self.getStartOfDayOnDate(Date()).compare(date) == ComparisonResult.orderedAscending
        let lesserThanEnd = self.getEndOfDayOnDate(self.getStartOfDayOnDate(Date())).compare(date) == ComparisonResult.orderedDescending
        return self.getStartOfDayOnDate(Date()).compare(date) == ComparisonResult.orderedSame || (greaterThanStart && lesserThanEnd)
    }
    
    public func isThisDateTomorrow(_ date : Date) -> Bool {
        return self.getStartOfDayOnDate(Date(timeIntervalSinceNow: +1*24*60*60)).compare(self.getStartOfDayOnDate(date)) == ComparisonResult.orderedSame
    }
    
    public func isThisFuture(date : Date) -> Bool {
        return self.getStartOfDayOnDate(Date()).compare(date) == ComparisonResult.orderedSame || self.getStartOfDayOnDate(Date()).compare(date) == ComparisonResult.orderedAscending
    }
    
    public func isThisDateFuture(date : Date) -> Bool {
        return self.getStartOfDayOnDate(Date(timeIntervalSinceNow: 1*24*60*60)).compare(self.getStartOfDayOnDate(date)) == ComparisonResult.orderedSame || self.getStartOfDayOnDate(Date(timeIntervalSinceNow: +1*24*60*60)).compare(date) == ComparisonResult.orderedAscending
    }
    
    public func getBeginAndEndWeek(_ fromDate:Date) -> (begin:Date,end:Date)?{
        let calendar = Calendar.current
        var dateComponents = (calendar as NSCalendar).components([.weekday,.year,.month, .day], from: fromDate)
        dateComponents.day! -= dateComponents.weekday! - 1
        let begginningWeek = calendar.date(from: dateComponents)
        dateComponents.day! += 6
        let endingWeek = calendar.date(from: dateComponents)
        if let begin = begginningWeek{
            if let end = endingWeek{
                return (begin, end)
            }
        }
        return nil
    }
    
    public func getBeginAndEndMonth(_ fromDate:Date) -> (begin:Date,end:Date)?{
        let calendar = Calendar.current
        var monthDateComponents = (calendar as NSCalendar).components([.weekday,.year,.month, .day], from: fromDate)
        monthDateComponents.day = 1
        let begMonth = calendar.date(from: monthDateComponents)
        monthDateComponents.day = 31
        let endMonth = calendar.date(from: monthDateComponents)
        if let begin = begMonth{
            if let end = endMonth{
                return (begin, end)
            }
        }
        return nil
    }
    
    public func getBeginAndEndYear(_ fromDate:Date) -> (begin:Date,end:Date)?{
        let calendar = Calendar.current
        var yearDateComponents = (calendar as NSCalendar).components([.weekday,.year,.month, .day], from: fromDate)
        yearDateComponents.month = 1
        yearDateComponents.day = 1
        let begYear = calendar.date(from: yearDateComponents)
        yearDateComponents.month! = 12
        yearDateComponents.day = 31
        let endYear = calendar.date(from: yearDateComponents)
        if let begin = begYear{
            if let end = endYear{
                return (begin, end)
            }
        }
        return nil
    }
    
    public func getTodayAndYesterdayOfWeek(date : Date)-> (String, String) {
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var date = Date()
        let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var myComponents = (myCalendar as NSCalendar?)?.components(.weekday, from: date)
        let todayValue = myComponents?.weekday
        date = date.addingTimeInterval(-86400.0)
        myComponents = (myCalendar as NSCalendar?)?.components(.weekday, from: date)
        let yesterdayValue = myComponents?.weekday
        return (self.getDayStringForIntValue(todayValue!), self.getDayStringForIntValue(yesterdayValue!))
    }
    
     func getDayStringForIntValue(_ dayInt : Int) -> String {
        switch (dayInt) {
        case 1:
            return "\(Days.Sunday)"
        case 2:
            return "\(Days.Monday)"
        case 3:
            return  "\(Days.Tuesday)"
        case 4:
            return  "\(Days.Wednesday)"
        case 5:
            return  "\(Days.Thursday)"
        case 6:
            return  "\(Days.Friday)"
        default:
            return  "\(Days.Saturday)"
        }
    }
    
    /// Returns a Date with the specified days added to the one it is called with
    public func add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0, to date : Date) -> Date {
        var targetDay: Date
        targetDay = Calendar.current.date(byAdding: .year, value: years, to: date)!
        targetDay = Calendar.current.date(byAdding: .month, value: months, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .day, value: days, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .hour, value: hours, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .minute, value: minutes, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .second, value: seconds, to: targetDay)!
        return targetDay
    }
    
    /// Returns a Date with the specified days subtracted from the one it is called with
    func subtract(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0, to date : Date) -> Date {
        let inverseYears = -1 * years
        let inverseMonths = -1 * months
        let inverseDays = -1 * days
        let inverseHours = -1 * hours
        let inverseMinutes = -1 * minutes
        let inverseSeconds = -1 * seconds
        return add(years: inverseYears, months: inverseMonths, days: inverseDays, hours: inverseHours, minutes: inverseMinutes, seconds: inverseSeconds, to: date)
    }
}


enum Days {
    case Sunday
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
}

extension Array {
    
    func indexOfObject<T: Equatable>(_ array: Array<T>, object: T) -> Int? {
        
        for i in 0...array.count {
            if (array[i] == object) {
                return i
            }
        }
        
        return nil
    }
}

extension String {
    var numbers: String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
    }
}
