//
//  PublicAPIListProtocol.swift
//  PublicAPIList
//
//  Created by Saumya Prakash on 14/04/22.
//

import Foundation
import UIKit

///These protocols are implemented by View
protocol ViewProtocol: AnyObject{
    
    func onFinishLoadTableEntries(with List: [APIDetail])
    func onFinishFetchAllEntries()
    
}

/// Implemented by Presenter
protocol PresentorProtocol: AnyObject{
    var interactor: InteractorProtocol? {get set}
    var view: ViewProtocol? {get set}
    var router: RouterProtocol? {get set}
    
    ///Call From View To Presenter
    func fetchAllEntries()
    func loadTableEntries()
    func loadDetailPage(withUrl: String)
    
    ///Callbacks rom Interpretor to Presenter f
    func didLoadTableEntries(apiData: [APIDetail])
    func didFetchAllEntries(status: Bool)
    
}


///Impleneted by Interactor
protocol InteractorProtocol: AnyObject{
    var presentor: PresentorProtocol? {get set}
    //Call made by Presentor
    func fetchAllEntries()
    func loadTableEntries()
    
}

///Impleneted by router
protocol RouterProtocol: AnyObject{
    func createModeul()->UIViewController
    func loadDetailPage(withUrl: String)
}
