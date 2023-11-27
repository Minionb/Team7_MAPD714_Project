//
//  RegisterViewController.swift
//  Team7_MAPD714_Project-Milestone2
//
//  Team 7
//  Milestone 2
//  Team members' names and student numbers: Pui Yee Ng (301366105), Cole Anam (301009188)
//  Submission date: 11/27/2023
//  Description: CustomerInfo Model

import Foundation

class CustomerInfo{
    
    var cid: Int
    var cfirstname: String
    var clastname: String
    var cemail: String
    var cpassword: String
    var cage: Int
    var caddress: String
    var ccity: String
    var ccountry: String
    var ctelephone: String
    
    init(cid: Int, cfirstname: String, clastname: String, cemail: String, cpassword: String, cage: Int, caddress: String, ccity: String, ccountry: String, ctelephone: String) {
        self.cid = cid
        self.cfirstname = cfirstname
        self.clastname = clastname
        self.cemail = cemail
        self.cpassword = cpassword
        self.cage = cage
        self.caddress = caddress
        self.ccity = ccity
        self.ccountry = ccountry
        self.ctelephone = ctelephone
    }
}


