//
//  CustomerInfo.swift
//  Team7_MAPD714_Project-Milestone2
//
//  Created by Cole Anam on 14/11/23.
//

import Foundation

class CustomerInfo{
    
    var cid: Int
    var cfirstname: String
    var clastname: String
    var cemail: String
    var cpassword: String
    var cage: Int
    var caddress: String
    
    init(cid: Int, cfirstname: String, clastname: String, cemail: String, cpassword: String, cage: Int, caddress: String) {
        self.cid = cid
        self.cfirstname = cfirstname
        self.clastname = clastname
        self.cemail = cemail
        self.cpassword = cpassword
        self.cage = cage
        self.caddress = caddress
    }
}
