//
//  PublicAPIListProtocol.swift
//  PublicAPIList
//
//  Created by Saumya Prakash on 14/04/22.
//

import Foundation
import UIKit

///implemented by View
protocol ViewProtocol: AnyObject{
    var presentor: (PresentorProtocol & TableViewModelProtocol)? {get set}
    func onFinishLoadTableEntries()
    func onDataLoadError()
    
}

/// Implemented by Presenter
protocol PresentorProtocol: AnyObject{
    var interactor: InteractorProtocol? {get set}
    var view: ViewProtocol? {get set}
    var router: RouterProtocol? {get set}
    
    ///Call From View To Presenter
    func loadTableEntries()
    func loadDetailPage(withUrl: String)
    
    ///Callbacks from Interpretor to Presenter f
    func didLoadTableEntries<T>(data: [T])
    
    
}


///Impleneted by Interactor
protocol InteractorProtocol: AnyObject{
    var presentor: PresentorProtocol? {get set}
    ///Call from Presentor to Interactor
    func loadTableEntries()
    
}

///Impleneted by Router
protocol RouterProtocol: AnyObject{
    func loadDetailPage(withUrl: String)
    
    ///Call from Presentor to Router
    func showLoadErrorAlert(withError: String)
}
