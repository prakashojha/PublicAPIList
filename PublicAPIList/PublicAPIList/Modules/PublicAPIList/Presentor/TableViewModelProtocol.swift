//
//  TableViewModelProtocol.swift
//  PublicAPIList
//
//  Created by Saumya Prakash on 14/04/22.
//

import Foundation

protocol TableViewModelProtocol: AnyObject{
    var reusableCellIdentifier: String {get}
    var isPaginating: Bool {get set}
    var sortAscending: Bool {get set}
    var heightForRow: Float { get }
    var numberOfSections: Int { get }
    var numberOfRowsInSection: Int { get }
    
    func cellForRow(at indexPath: Int) -> APIDetail?
    func remove(at indexPath: Int)
    func insert(item: APIDetail?, at indexPath: Int)
    
    func updateSearchResults(searchText: String)
    func sort()
}
