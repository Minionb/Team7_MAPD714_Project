//
//  RegisterViewController.swift
//  Team7_MAPD714_Project-Milestone2
//
//  Team 7
//  Milestone 2
//  Team members' names and student numbers: Pui Yee Ng (301366105), Cole Anam (301009188)
//  Submission date: 11/27/2023
//  Description: Customer Info Database

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
    
    func dropTable() {
        var dropTableString = "DROP TABLE IF EXISTS CustomerInfo;"
        
        var dropTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare(db, dropTableString, -1, &dropTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(dropTableStatement) == SQLITE_DONE {
                print("CustomerInfo table dropped successfully!")
            }
            else {
                print("CustomerInfo table dropped failed!")
            }
        }
        else {
            print("Drop statement failed!")
        }
        sqlite3_finalize(dropTableStatement)
    }
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS CustomerInfo (cid INTEGER PRIMARY KEY AUTOINCREMENT, cfirstname TEXT, clastname TEXT, cemail TEXT, cpassword TEXT, cage INTEGER, caddress TEXT, ccity TEXT, ccountry TEXT, ctelephone TEXT)"
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
                
                
                if sqlite3_step(getStatement) != SQLITE_DONE {
                    let errorMessage = String(cString: sqlite3_errmsg(db))
                    print("Error getting customerinfo: \(errorMessage)")
                }
                
                sqlite3_finalize(getStatement)
                return customerInfo
            }
        }
        
        sqlite3_finalize(getStatement)
        return nil
    }
    
    func getCustomerByEmail(cemail: String) -> CustomerInfo? {
        var getStatement: OpaquePointer?
        
        let getStatementString = "SELECT * FROM CustomerInfo WHERE cemail = ?"
        
        if sqlite3_prepare_v2(db, getStatementString, -1, &getStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(getStatement, 1, (cemail as NSString).utf8String, -1, nil)
            
            if sqlite3_step(getStatement) == SQLITE_ROW {
                let cid = sqlite3_column_int(getStatement, 0)
                let cfirstname = String(describing: String(cString: sqlite3_column_text(getStatement, 1)))
                let clastname = String(describing: String(cString: sqlite3_column_text(getStatement, 2)))
                let cemail = String(describing: String(cString: sqlite3_column_text(getStatement, 3)))
                let cpassword = String(describing: String(cString: sqlite3_column_text(getStatement, 4)))
                let cage = sqlite3_column_int(getStatement, 5)
                let caddress = String(describing: String(cString: sqlite3_column_text(getStatement, 6)))
                let ccity = String(describing: String(cString: sqlite3_column_text(getStatement, 7)))
                let ccountry = String(describing: String(cString: sqlite3_column_text(getStatement, 8)))
                let ctelephone = String(describing: String(cString: sqlite3_column_text(getStatement, 9)))
                
                let customerInfo = CustomerInfo(cid: Int(cid), cfirstname: cfirstname, clastname: clastname, cemail: cemail, cpassword: cpassword, cage: Int(cage), caddress: caddress, ccity: ccity, ccountry: ccountry, ctelephone: ctelephone)
                
                if sqlite3_step(getStatement) != SQLITE_DONE {
                    let errorMessage = String(cString: sqlite3_errmsg(db))
                    print("Error getting customerinfo: \(errorMessage)")
                }
                
                sqlite3_finalize(getStatement)
                return customerInfo
            }
        }
        
        sqlite3_finalize(getStatement)
        return nil
    }
    
    func updateCustomer(customerInfo: CustomerInfo) {
        var updateStatement: OpaquePointer?
        
        let updateStatementString = "UPDATE CustomerInfo SET cpassword = ?, caddress = ?, ccity = ?, ccountry = ?, ctelephone = ?, cage = ? WHERE cemail = ?"
        
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, (customerInfo.cpassword as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (customerInfo.caddress as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 3, (customerInfo.ccity as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 4, (customerInfo.ccountry as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 5, (customerInfo.ctelephone as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 6, Int32(customerInfo.cage))
            sqlite3_bind_text(updateStatement, 7, (customerInfo.cemail as NSString).utf8String, -1, nil)

            if sqlite3_step(updateStatement) != SQLITE_DONE {
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("Error updating customerinfo: \(errorMessage)")
            }
        }
        sqlite3_finalize(updateStatement)
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
    func insert(cfirstname:String, clastname:String, cemail:String, cpassword:String, cage:Int, caddress:String, ccity:String, ccountry:String, ctelephone:String)
    {
        let customers = read()

        let insertStatementString = "INSERT INTO CustomerInfo (cfirstname, clastname, cemail, cpassword, cage, caddress, ccity, ccountry, ctelephone) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
            SQLITE_OK {
//            sqlite3_bind_int(insertStatement, 1, Int32(cid))
            sqlite3_bind_text(insertStatement, 1, (cfirstname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (clastname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (cemail as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (cpassword as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 5, Int32(cage))
            sqlite3_bind_text(insertStatement, 6, (caddress as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (ccity as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 8, (ccountry as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 9, (ctelephone as NSString).utf8String, -1, nil)
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
    
    func getCustomerByCID(cid:Int) -> CustomerInfo? {
        let queryStatementString = "SELECT * FROM CustomerInfo WHERE cid = ?;"
        var queryStatement: OpaquePointer? = nil
        var customerInfo : CustomerInfo?
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
        SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(cid))
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
                
                customerInfo = CustomerInfo(cid: Int(cid), cfirstname: cfirstname, clastname: clastname, cemail: cemail, cpassword: cpassword, cage: Int(cage), caddress: caddress, ccity: ccity, ccountry: ccountry, ctelephone: ctelephone)
                print("CustomerInfo Details:")
                print("\(cid) | \(cfirstname) | \(clastname) | \(cemail) | \(cpassword) | \(cage) | \(caddress) | \(ccity) | \(ccountry) | \(ctelephone)")
            }
        } else {
            print("SELECT statement failed to proceed!!!")
        }
        sqlite3_finalize(queryStatement)
        return customerInfo
    }
}
