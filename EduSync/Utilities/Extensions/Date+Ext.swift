//
//  File.swift
//  
//
//  Created by Davron Abdukhakimov on 03/01/24.
//

import Foundation

let weekDayNumbers = [
    "Monday": 1,
    "Tuesday": 2,
    "Wednesday": 3,
    "Thursday": 4,
    "Friday": 5,
    "Saturday": 6,
]
var initialTime:Date{
    var components = DateComponents()
    
    components.hour = 0
    components.minute = 0
    
    let date = Calendar.current.date(from: components)
    return date ?? Date()
}
func getInterval(deadline:Date) ->String{
    let hours = Calendar.current.dateComponents([.hour], from: Date(), to: deadline).hour!
    let day = (hours / 24) == 0 ? nil : hours / 24
    let hour = (hours % 24) == 0 ? nil : hours % 24
    var timeLeft = ""
    if let day {
        timeLeft += "\(day)d "
    }
    if let hour {
        timeLeft += "\(hour)h "
    }
    return timeLeft + "remaining"
}
func displayTime(time:Date) -> String{
    let components = Calendar.current.dateComponents([.hour,.minute], from: time)
    let hour = components.hour! < 10 ? "0\(components.hour!)" : "\(components.hour!)"
    let minute = components.minute! < 10 ? "0\(components.minute!)" : "\(components.minute!)"
    return hour + ":" + minute
}
func getTimerComponents(timer:Date) -> String {
    let component = Calendar.current.dateComponents([.hour,.minute], from: timer)
    let hour = component.hour!
    let minute = component.minute!
    var time = ""
    if hour >= 1{
        time += "\(hour) hour"
    }
    if minute > 0{
        time += " \(minute) minute"
    }
    return time
}
func convertToSeconds(date:Date) -> Double {
    let component = Calendar.current.dateComponents( [.hour,.minute], from: date)
    let hour = component.hour!
    let minute = component.minute!
    return Double(hour * 3600 + minute * 60)
}
func getTimerString(seconds:Double) ->String {
    
    let hour = Int(seconds / 3600)
    let minute = (Int(seconds) - hour * 3600) / 60
    let second = Int(seconds) % 60
    
    let hourString = hour < 10 ? "0\(hour)" : String(hour)
    let minuteString = minute < 10 ? "0\(minute)" : String(minute)
    let secondString = second < 10 ? "0\(second)" : String(second)
    
    return hourString + " : " + minuteString + " : " + secondString
}
func getRemindDate(day:String,deadline:Date) -> Date{
    
    let dayInt = Int(day)
    let remindDate = Calendar.current.date(byAdding: .day, value: -dayInt!, to: deadline)
    return remindDate!
}
func getCurrentWeekDay() -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    let weekDay = dateFormatter.string(from: Date())
    return weekDay
}
