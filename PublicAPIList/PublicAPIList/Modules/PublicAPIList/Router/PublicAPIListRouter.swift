//
//  PublicAPIListRouter.swift
//  PublicAPIList
//
//  Created by Saumya Prakash on 14/04/22.
//

import Foundation
import UIKit
import SafariServices

class PublicAPIListRouter: RouterProtocol{
   
    
    private let navigationComtroller: UINavigationController
    
    
    init(navigationController: UINavigationController){
        self.navigationComtroller = navigationController
    }
    
   
    func showLoadErrorAlert(withError: String){
        let alert = UIAlertController(title: "Load Error", message: withError, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil ))
        navigationComtroller.present(alert, animated: true, completion: nil)
    }
    
    func showActivityIndicator(){
        
    }
    
    func loadDetailPage(withUrl: String){
        guard let url = URL(string: withUrl) else { return }
        let config = SFSafariViewController.Configuration()
        let safariViewControler = SFSafariViewController(url: url, configuration: config)
        safariViewControler.modalPresentationStyle = .fullScreen
        navigationComtroller.present(safariViewControler, animated: true, completion: nil)
    }
    
    
    
}
