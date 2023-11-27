//
//  BookingInfo.swift
//  Team7_MAPD714_Project-Milestone2
//
//  Team 7
//  Milestone 4
//  Team members' names and student numbers: Pui Yee Ng (301366105), Cole Anam (301009188)
//  Submission date: 11/13/2023
//  Description: Booking Info Schema

import Foundation

class BookingInfo{
    
    var bid: Int
    var cid: Int
    var bcruiseType: String
    var bcruiseStartDate: String
    var bcruiseEndDate: String
    var bvisitingPlaces: String
    var badultNum: Int
    var bkidNum: Int
    var bhasSenior: String
    var bnightNum: Int
    var bcruisePrice: Int
    var btotalPrice: Int
    
    init(bid: Int,cid: Int, bcruiseType: String, bcruiseStartDate: String, bcruiseEndDate: String, bvisitingPlaces: String, badultNum: Int, bkidNum: Int, bhasSenior: String, bnightNum: Int, bcruisePrice: Int, btotalPrice: Int) {
        self.bid = bid
        self.cid = cid
        self.bcruiseType = bcruiseType
        self.bcruiseStartDate = bcruiseStartDate
        self.bcruiseEndDate = bcruiseEndDate
        self.bvisitingPlaces = bvisitingPlaces
        self.badultNum = badultNum
        self.bkidNum = bkidNum
        self.bhasSenior = bhasSenior
        self.bnightNum = bnightNum
        self.bcruisePrice = bcruisePrice
        self.btotalPrice = btotalPrice
    }
}
