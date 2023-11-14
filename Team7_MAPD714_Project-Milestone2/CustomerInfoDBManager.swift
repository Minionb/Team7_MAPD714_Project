//
//  CustomerInfoDBManager.swift
//  Team7_MAPD714_Project-Milestone2
//
//  Created by Cole Anam on 14/11/23.
//

import Foundation
import SQLite3

class CustomerInfoDBManager {
    
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
    
    func createTable() {
        var createTableString = "CREATE TABLE IF NOT EXISTS CustomerInfo (cid INTEGER PRIMARY KEY, cfirstname TEXT, clastname TEXT, cemail TEXT, cpassword TEXT, cage INTEGER, caddress TEXT)"
        var createTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("CustomerInfo table created successfully!")
            }
            else {
                print("CustomerInfo table failed!")
            }
        }
        else {
            print("Create statement failed!")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // function to insert a row into CustomerInfo table
    func insert(cid:Int, cfirstname:String, clastname:String, cemail:String, cpassword:String, cage:Int, caddress:String)
    {
        let customers = read()
        for custs in customers
        {
            if custs.cid == cid
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO CustomerInfo (cid, cfirstname, clastname, cemail, cpassword, cage, caddress) VALUES (?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
            SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(cid))
            sqlite3_bind_text(insertStatement, 2, (cfirstname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (clastname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (cemail as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (cpassword as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 6, Int32(cage))
            sqlite3_bind_text(insertStatement, 7, (caddress as NSString).utf8String, -1, nil)
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("A customer was added successfully!")
            } else {
                print("Couldn't add any row?")
            }
        } else {
            print("INSERT statement failed to succeed!!!")
        }
        sqlite3_finalize(insertStatement)
    }
    
    // read data from CustomerInfo table using select
    func read() -> [CustomerInfo] {
        let queryStatementString = "SELECT * FROM CustomerInfo;"
        var queryStatement: OpaquePointer? = nil
        var custs : [CustomerInfo] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
        SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let cid = sqlite3_column_int(queryStatement, 0)
                let cfirstname = String(describing: String(cString:
                sqlite3_column_text(queryStatement, 1)))
                let clastname = String(describing: String(cString:
                sqlite3_column_text(queryStatement, 2)))
                let cemail = String(describing: String(cString:
                sqlite3_column_text(queryStatement, 3)))
                let cpassword = String(describing: String(cString:
                sqlite3_column_text(queryStatement, 4)))
                let cage = sqlite3_column_int(queryStatement, 5)
                let caddress = String(describing: String(cString:
                sqlite3_column_text(queryStatement, 6)))
                custs.append(CustomerInfo(cid: Int(cid), cfirstname: cfirstname, clastname: clastname, cemail: cemail, cpassword: cpassword, cage: Int(cage), caddress: caddress))
                print("CustomerInfo Details:")
                print("\(cid) | \(cfirstname) | \(clastname) | \(cemail) | \(cpassword) | \(cage) | \(caddress)")
            }
        } else {
            print("SELECT statement failed to proceed!!!")
        }
        sqlite3_finalize(queryStatement)
        return custs
    }
}
