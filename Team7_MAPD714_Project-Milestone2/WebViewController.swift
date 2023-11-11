//
//  WebViewController.swift
//  Team7_MAPD714_Project-Milestone2
//
//  Team 7
//  Milestone 3
//  Team members' names and student numbers: Pui Yee Ng (301366105), Cole Anam (301009188)
//  Submission date: 11/13/2023
//  Description: Web View Screen

import UIKit
import WebKit

class WebViewController: UIViewController {
    // define a webview control object
   let wview = WKWebView()
    var url : URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add the object into view
        view.addSubview(wview)
        
        // load the url into web view control
        wview.load(URLRequest(url:url!))
    }
    
    // initializing web view to the screen
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        wview.frame = view.bounds
    }
}
