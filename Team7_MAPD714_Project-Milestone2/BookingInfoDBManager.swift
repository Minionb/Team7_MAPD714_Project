//
//  RegisterViewController.swift
//  Team7_MAPD714_Project-Milestone2
//
//  Team 7
//  Milestone 2
//  Team members' names and student numbers: Pui Yee Ng (301366105), Cole Anam (301009188)
//  Submission date: 11/27/2023
//  Description: Booking Info Database Manager

import Foundation
import SQLite3

class BookingInfoDBManager {
    init() {
        db = openDatabase()
        createTable()
    }
    
    let dataPath: String = "CustomerInfoDB"
    var db: OpaquePointer?
    
    func openDatabase() -> OpaquePointer? {
        
        var filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dataPath)
        
        var db: OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            debugPrint("Can't open database")
            return nil
        }
        else {
            print("database successfully created!")
            return db
        }
    }
    
    func dropTable() {
        var dropTableString = "DROP TABLE IF EXISTS BookingInfo;"
        
        var dropTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare(db, dropTableString, -1, &dropTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(dropTableStatement) == SQLITE_DONE {
                print("BookingInfo table dropped successfully!")
            }
            else {
                print("BookingInfo table dropped failed!")
            }
        }
        else {
            print("Drop statement failed!")
        }
        sqlite3_finalize(dropTableStatement)
    }
    
    func createTable() {
        var createTableString = "CREATE TABLE IF NOT EXISTS BookingInfo (bid INTEGER PRIMARY KEY AUTOINCREMENT, cid INTEGER, bcruiseType TEXT, bcruiseStartDate TEXT, bcruiseEndDate TEXT, bvisitingPlaces TEXT, badultNum INTEGER, bkidNum INTEGER, bhasSenior TEXT, bnightNum INTEGER, bcruisePrice INTEGER, btotalPrice INTEGER)"
        var createTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("BookingInfo table created successfully!")
            }
            else {
                print("BookingInfo table failed!")
            }
        }
        else {
            print("Create statement failed!")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // Insert booking data to table
    func insert(cid:Int, bcruiseType:String, bcruiseStartDate:String, bcruiseEndDate:String, bvisitingPlaces:String, badultNum:Int, bkidNum:Int, bhasSenior:String, bnightNum:Int, bcruisePrice:Int, btotalPrice:Int)
    {
            let insertStatementString = "INSERT INTO BookingInfo (cid, bcruiseType, bcruiseStartDate, bcruiseEndDate, bvisitingPlaces, badultNum, bkidNum, bhasSenior, bnightNum, bcruisePrice, btotalPrice) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
            var insertStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                sqlite3_bind_int(insertStatement, 1, Int32(cid))
                sqlite3_bind_text(insertStatement, 2, (bcruiseType as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, (bcruiseStartDate as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 4, (bcruiseEndDate as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 5, (bvisitingPlaces as NSString).utf8String, -1, nil)
                sqlite3_bind_int(insertStatement, 6, Int32(badultNum))
                sqlite3_bind_int(insertStatement, 7, Int32(bkidNum))
                sqlite3_bind_text(insertStatement, 8, (bhasSenior as NSString).utf8String, -1, nil)
                sqlite3_bind_int(insertStatement, 9, Int32(bnightNum))
                sqlite3_bind_int(insertStatement, 10, Int32(bcruisePrice))
                sqlite3_bind_int(insertStatement, 11, Int32(btotalPrice))
                
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("A booking added successfully!")
                } else {
                    print("Couldn't add any row?")
                }
            } else {
                print("INSERT statement failed to succeed!!!")
            }
            sqlite3_finalize(insertStatement)
        }
    
    // read data from BookingInfo table using Select
    func read() -> [BookingInfo] {
        let queryStatementString = "SELECT * FROM BookingInfo;"
        var queryStatement: OpaquePointer? = nil
        var bookings : [BookingInfo] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
            SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let bid = sqlite3_column_int(queryStatement, 0)
                let cid = sqlite3_column_int(queryStatement, 1)
                let bcruiseType = String(describing: String(cString:
                                                                sqlite3_column_text(queryStatement, 2)))
                let bcruiseStartDate = String(describing: String(cString:
                                                                    sqlite3_column_text(queryStatement, 3)))
                let bcruiseEndDate = String(describing: String(cString:
                                                                    sqlite3_column_text(queryStatement, 4)))
                let bvisitingPlaces = String(describing: String(cString:
                                                                    sqlite3_column_text(queryStatement, 5)))
                let badultNum = String(describing: String(cString:
                                                            sqlite3_column_text(queryStatement, 6)))
                let bkidNum = sqlite3_column_int(queryStatement, 7)
                let bhasSenior = String(describing: String(cString:
                                                            sqlite3_column_text(queryStatement, 8)))
                let bnightNum = String(describing: String(cString:
                                                            sqlite3_column_text(queryStatement, 9)))
                let bcruisePrice = sqlite3_column_int(queryStatement, 10)
                let btotalPrice = sqlite3_column_int(queryStatement, 11)
                
                
                bookings.append(BookingInfo(bid: Int(bid), cid: Int(cid), bcruiseType: bcruiseType, bcruiseStartDate: bcruiseStartDate, bcruiseEndDate: bcruiseEndDate, bvisitingPlaces: bvisitingPlaces, badultNum: Int(badultNum) ?? 0, bkidNum: Int(bkidNum), bhasSenior: bhasSenior, bnightNum: Int(bnightNum) ?? 0, bcruisePrice: Int(bcruisePrice), btotalPrice: Int(btotalPrice)))
                print("BookingInfo Details:")
                print("\(bid) | \(cid) | \(bcruiseType) | \(bcruiseStartDate) | \(bcruiseEndDate) | \(bvisitingPlaces) | \(badultNum) | \(bkidNum) | \(bhasSenior) |  \(bnightNum) |  \(bcruisePrice) |  \(btotalPrice)")
            }
        } else {
            print("SELECT statement failed to proceed!!!")
        }
        sqlite3_finalize(queryStatement)
        return bookings
    }
    
    // read data from BookingInfo table using Select by cid
    func selectBookingsByCustID(cid:Int) -> [BookingInfo]{
        let queryStatementString = "SELECT * FROM BookingInfo WHERE cid = ?;"
        var queryStatement: OpaquePointer? = nil
        var bookings : [BookingInfo] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
            SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(cid))
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let bid = sqlite3_column_int(queryStatement, 0)
                let cid = sqlite3_column_int(queryStatement, 1)
                let bcruiseType = String(describing: String(cString:
                                                                sqlite3_column_text(queryStatement, 2)))
                let bcruiseStartDate = String(describing: String(cString:
                                                                    sqlite3_column_text(queryStatement, 3)))
                let bcruiseEndDate = String(describing: String(cString:
                                                                    sqlite3_column_text(queryStatement, 4)))
                let bvisitingPlaces = String(describing: String(cString:
                                                                    sqlite3_column_text(queryStatement, 5)))
                let badultNum = String(describing: String(cString:
                                                            sqlite3_column_text(queryStatement, 6)))
                let bkidNum = sqlite3_column_int(queryStatement, 7)
                let bhasSenior = String(describing: String(cString:
                                                            sqlite3_column_text(queryStatement, 8)))
                let bnightNum = String(describing: String(cString:
                                                            sqlite3_column_text(queryStatement, 9)))
                let bcruisePrice = sqlite3_column_int(queryStatement, 10)
                let btotalPrice = sqlite3_column_int(queryStatement, 11)
                
                
                bookings.append(BookingInfo(bid: Int(bid), cid: Int(cid), bcruiseType: bcruiseType, bcruiseStartDate: bcruiseStartDate, bcruiseEndDate: bcruiseEndDate, bvisitingPlaces: bvisitingPlaces, badultNum: Int(badultNum) ?? 0, bkidNum: Int(bkidNum), bhasSenior: bhasSenior, bnightNum: Int(bnightNum) ?? 0, bcruisePrice: Int(bcruisePrice), btotalPrice: Int(btotalPrice)))
                print("BookingInfo Details:")
                print("\(bid) | \(cid) | \(bcruiseType) | \(bcruiseStartDate) | \(bcruiseEndDate) | \(bvisitingPlaces) | \(badultNum) | \(bkidNum) | \(bhasSenior) |  \(bnightNum) |  \(bcruisePrice) |  \(btotalPrice)")
            }
        } else {
            print("SELECT statement failed to proceed!!!")
        }
        sqlite3_finalize(queryStatement)
        return bookings
    }
    
    // read data from BookingInfo table using Select by cid
    func selectBookingsByBookingID(bid:Int) -> [BookingInfo]{
        let queryStatementString = "SELECT * FROM BookingInfo WHERE bid = ?;"
        var queryStatement: OpaquePointer? = nil
        var bookings : [BookingInfo] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
            SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(bid))
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let bid = sqlite3_column_int(queryStatement, 0)
                let cid = sqlite3_column_int(queryStatement, 1)
                let bcruiseType = String(describing: String(cString:
                                                                sqlite3_column_text(queryStatement, 2)))
                let bcruiseStartDate = String(describing: String(cString:
                                                                    sqlite3_column_text(queryStatement, 3)))
                let bcruiseEndDate = String(describing: String(cString:
                                                                    sqlite3_column_text(queryStatement, 4)))
                let bvisitingPlaces = String(describing: String(cString:
                                                                    sqlite3_column_text(queryStatement, 5)))
                let badultNum = String(describing: String(cString:
                                                            sqlite3_column_text(queryStatement, 6)))
                let bkidNum = sqlite3_column_int(queryStatement, 7)
                let bhasSenior = String(describing: String(cString:
                                                            sqlite3_column_text(queryStatement, 8)))
                let bnightNum = String(describing: String(cString:
                                                            sqlite3_column_text(queryStatement, 9)))
                let bcruisePrice = sqlite3_column_int(queryStatement, 10)
                let btotalPrice = sqlite3_column_int(queryStatement, 11)
                
                
                bookings.append(BookingInfo(bid: Int(bid), cid: Int(cid), bcruiseType: bcruiseType, bcruiseStartDate: bcruiseStartDate, bcruiseEndDate: bcruiseEndDate, bvisitingPlaces: bvisitingPlaces, badultNum: Int(badultNum) ?? 0, bkidNum: Int(bkidNum), bhasSenior: bhasSenior, bnightNum: Int(bnightNum) ?? 0, bcruisePrice: Int(bcruisePrice), btotalPrice: Int(btotalPrice)))
                print("BookingInfo Details:")
                print("\(bid) | \(cid) | \(bcruiseType) | \(bcruiseStartDate) | \(bcruiseEndDate) | \(bvisitingPlaces) | \(badultNum) | \(bkidNum) | \(bhasSenior) |  \(bnightNum) |  \(bcruisePrice) |  \(btotalPrice)")
            }
        } else {
            print("SELECT statement failed to proceed!!!")
        }
        sqlite3_finalize(queryStatement)
        return bookings
    }
    
    func deleteByID(bid:Int) {
        let deleteStatementString = "DELETE FROM BookingInfo WHERE bid = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(bid))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("A booking deleted successfully!")
            } else {
                print("Couldn't delete given booking")
            }
        } else {
            print("DELETE statement failed to succeed!")
        }
        sqlite3_finalize(deleteStatement)
    }

}

    

