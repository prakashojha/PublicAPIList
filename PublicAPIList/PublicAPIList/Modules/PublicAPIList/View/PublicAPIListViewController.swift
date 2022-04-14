//
//  ViewController.swift
//  PublicAPIList
//
//  Created by Saumya Prakash on 14/04/22.
//

import UIKit

class PublicAPIListViewController: UIViewController {
    
    var isPaginating = false
    var presentor: PresentorProtocol?
    var apiList: [APIDetail] = []
    var searchApiList: [APIDetail] = []
    var sortAscending: Bool = true
    let searchController = UISearchController(searchResultsController: nil)
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(PublicAPIListCellView.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.showsVerticalScrollIndicator = false
        return tableView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemYellow //UIColor(red: 96/255, green: 124/255, blue: 60/255, alpha: 1)
        presentor?.loadTableEntries()
        self.view.addSubview(tableView)
        setupConstraints()
        setupNavigationAndBarButton()
    }
    
    
    func setupNavigationAndBarButton(){
        setUpNavigation()
        setUpEditAndSortBarButtons()
        setUpSearchBar()
    }
    
    
    func setUpNavigation(){
        navigationItem.title = "Public API LIST"
        navigationItem.titleView?.backgroundColor = .cyan
    }
    
    
    func setUpEditAndSortBarButtons(){
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName :"arrow.up.arrow.down"), style: .done, target: self,
                            action: #selector(onSortTApped)),
            editButtonItem
        ]
    }
    
    
    @objc func onSortTApped(){
        sortAscending == true ? apiList.sort{$0.category < $1.category} : apiList.sort{$0.category > $1.category}
        sortAscending = !sortAscending
        tableView.reloadData()
    }
    
    ///Set table for editing
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.isEditing = editing
        
    }
    
    
    func setUpSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search With Categories"
        self.tableView.tableHeaderView = searchController.searchBar
    }
    
    
    func setupConstraints(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    func CreateLoadingFooter()->UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.center = footerView.center
        
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
}


extension PublicAPIListViewController: ViewProtocol{
   
    func onFinishFetchAllEntries() {
        presentor?.loadTableEntries()
    }
    
    func onFinishLoadTableEntries(with apiList: [APIDetail]) {
        self.apiList = apiList
        self.searchApiList = self.apiList
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.isPaginating = false
            self.tableView.tableFooterView = nil
        }
    }
    
}



extension PublicAPIListViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
       ///Do Nothing
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PublicAPIListCellView
        cell?.cellViewModel = apiList[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(130)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            apiList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return .delete
        }
        
        return .none
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.apiList[sourceIndexPath.row]
        apiList.remove(at: sourceIndexPath.row)
        apiList.insert(movedObject, at: destinationIndexPath.row)
    }
    
    
    ///Pagination Fetch result in advance and add to the list
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableView{
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height){
                if !self.isPaginating {
                    self.isPaginating = true
                    self.tableView.tableFooterView = CreateLoadingFooter()
                    presentor?.loadTableEntries()
                    
                }
            }
            
        }
    }
    
}


extension PublicAPIListViewController : UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        apiList = searchApiList.filter { $0.category.hasPrefix(searchText) }
        tableView.reloadData()
    }
}
