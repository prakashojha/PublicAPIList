//
//  ViewController.swift
//  PublicAPIList
//
//  Created by Saumya Prakash on 14/04/22.
//

import UIKit

class PublicAPIListViewController: UIViewController {
    
    var presentor: PresentorProtocol?
    var apiList: [APIDetail] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemYellow //UIColor(red: 96/255, green: 124/255, blue: 60/255, alpha: 1)
        presentor?.fetchAllEntries()
        
    }
}


extension PublicAPIListViewController: ViewProtocol{
   
    
    func onFinishFetchAllEntries() {
        presentor?.loadTableEntries()
    }
    
    func onFinishLoadTableEntries(with apiList: [APIDetail]) {
        
        print(apiList)
    }
    
}

