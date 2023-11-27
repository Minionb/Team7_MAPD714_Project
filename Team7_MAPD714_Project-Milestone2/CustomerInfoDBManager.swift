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
        
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dataPath)
        
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
        let createTableString = "CREATE TABLE IF NOT EXISTS CustomerInfo (cid INTEGER PRIMARY KEY, cfirstname TEXT, clastname TEXT, cemail TEXT, cpassword TEXT, cage INTEGER, caddress TEXT, ccity TEXT, ccountry TEXT, ctelephone TEXT)"
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
    
    func getCustomer(cemail: String, cpassword: String) -> CustomerInfo? {
        var getStatement: OpaquePointer?
        
        let getStatementString = "SELECT * FROM CustomerInfo WHERE cemail = ? AND cpassword = ?"
        if sqlite3_prepare_v2(db, getStatementString, -1, &getStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(getStatement, 1, (cemail as NSString).utf8String, -1, nil)
            sqlite3_bind_text(getStatement, 2, (cpassword as NSString).utf8String, -1, nil)
            
            if sqlite3_step(getStatement) == SQLITE_ROW {
                let cid = sqlite3_column_int(getStatement, 0)
                let cfirstname = String(describing: String(cString:
                sqlite3_column_text(getStatement, 1)))
                let clastname = String(describing: String(cString:
                sqlite3_column_text(getStatement, 2)))
                let cemail = String(describing: String(cString:
                sqlite3_column_text(getStatement, 3)))
                let cpassword = String(describing: String(cString:
                sqlite3_column_text(getStatement, 4)))
                let cage = sqlite3_column_int(getStatement, 5)
                let caddress = String(describing: String(cString:
                sqlite3_column_text(getStatement, 6)))
                let ccity = String(describing: String(cString:
                sqlite3_column_text(getStatement, 7)))
                let ccountry = String(describing: String(cString:
                sqlite3_column_text(getStatement, 8)))
                let ctelephone = String(describing: String(cString:
                sqlite3_column_text(getStatement, 9)))
                
                let customerInfo = CustomerInfo(cid: Int(cid), cfirstname: cfirstname, clastname: clastname, cemail: cemail, cpassword: cpassword, cage: Int(cage), caddress: caddress, ccity: ccity, ccountry: ccountry, ctelephone: ctelephone)
                sqlite3_finalize(getStatement)
                return customerInfo
            }
        }
        
        sqlite3_finalize(getStatement)
        return nil
    }
    
    func deleteAllCustomers() {
        let  deleteQuery = "DELETE FROM CustomerInfo"
        
        var deleteStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, deleteQuery, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) != SQLITE_DONE {
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("Error deleting customerInfo: \(errorMessage)")
            }
        }
        sqlite3_finalize(deleteStatement)
    }
    
    // function to insert a row into CustomerInfo table
    func insert(cid:Int, cfirstname:String, clastname:String, cemail:String, cpassword:String, cage:Int, caddress:String, ccity:String, ccountry:String, ctelephone:String)
    {
        let customers = read()
        for custs in customers
        {
            if custs.cid == cid
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO CustomerInfo (cid, cfirstname, clastname, cemail, cpassword, cage, caddress, ccity, ccountry, ctelephone) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
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
            sqlite3_bind_text(insertStatement, 8, (ccity as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 9, (ccountry as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 10, (ctelephone as NSString).utf8String, -1, nil)
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("A customer was added successfully!")
            } else {
                print("Couldn't add any row?")
            }
        } else {
            print("INSERT statement failed!!!")
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
                let ccity = String(describing: String(cString:
                sqlite3_column_text(queryStatement, 7)))
                let ccountry = String(describing: String(cString:
                sqlite3_column_text(queryStatement, 8)))
                let ctelephone = String(describing: String(cString:
                sqlite3_column_text(queryStatement, 9)))
                custs.append(CustomerInfo(cid: Int(cid), cfirstname: cfirstname, clastname: clastname, cemail: cemail, cpassword: cpassword, cage: Int(cage), caddress: caddress, ccity: ccity, ccountry: ccountry, ctelephone: ctelephone))
                print("CustomerInfo Details:")
                print("\(cid) | \(cfirstname) | \(clastname) | \(cemail) | \(cpassword) | \(cage) | \(caddress) | \(ccity) | \(ccountry) | \(ctelephone)")
            }
        } else {
            print("SELECT statement failed to proceed!!!")
        }
        sqlite3_finalize(queryStatement)
        return custs
    }
}
