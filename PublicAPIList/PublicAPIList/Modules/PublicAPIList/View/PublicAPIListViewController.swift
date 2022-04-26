//
//  ViewController.swift
//  PublicAPIList
//
//  Created by Saumya Prakash on 14/04/22.
//

import UIKit

class PublicAPIListViewController: UIViewController {
    
   
    var presentor: (PresentorProtocol & TableViewModelProtocol)?
    let searchController = UISearchController(searchResultsController: nil)
    var activityIndicator: UIActivityIndicatorView!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(PublicAPIListCellView.self, forCellReuseIdentifier: presentor?.reusableCellIdentifier ?? "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        return tableView
        
    }()
    
    
    private  func addActivityIndicatorView()->UIActivityIndicatorView{
        let avtivityIndicator = UIActivityIndicatorView()
        avtivityIndicator.style = .large
        avtivityIndicator.color = .red
        return avtivityIndicator
    }
    
    
    private func stopActivityIndicatorView(){
        guard let activityIndicator = self.activityIndicator else { return }
        if activityIndicator.isAnimating{
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemYellow
        presentor?.loadTableEntries()
        self.view.addSubview(tableView)
        setupConstraints()
        setupNavigationAndBarButton()
    }
    
    

    ///Add activity indicator to table view showing load data in progress
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.activityIndicator = addActivityIndicatorView()
        self.tableView.backgroundView = activityIndicator
        activityIndicator.startAnimating()
    }
    
    
    
    ///Set up table constraints of tableView
    ///TableView aligns with leading, top, bottom and trailing constraints of the view
    func setupConstraints(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    
    
    ///Setup navigation bar and features like Edit, Sort , Rearrange and Search
    func setupNavigationAndBarButton(){
        setUpNavigation()
        setUpEditAndSortBarButtons()
        setUpSearchBar()
    }
    
    
    ///Shows the title of the page
    func setUpNavigation(){
        navigationItem.title = "Public API LIST"
        navigationItem.titleView?.backgroundColor = .cyan
    }
    
    
    ///Edit and sort button added to the navigation bar
    func setUpEditAndSortBarButtons(){
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName :"arrow.up.arrow.down"), style: .done, target: self,
                            action: #selector(onSortTApped)),
            editButtonItem
        ]
    }
    
    
    ///Sort items either in ascending or desceding order when sort item is tapped
    @objc func onSortTApped(){
        presentor?.sort()
    }
    
    
    ///Toggle table property for editing and non editing.
    ///Used for deleting or Reordering rows of the table
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.isEditing = editing
        
    }
    
    ///Sarch controller for searching items within the table using "category" as search criteria
    func setUpSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search With Categories"
        self.tableView.tableHeaderView = searchController.searchBar
    }
    
    
    
    ///A View with activity indicator used for pagination
    ///Used to show loading opf new items in progress when user scrolls and reaches at the end of the list
    ///Added to the footer view
    func CreateLoadingFooter()->UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        self.activityIndicator = addActivityIndicatorView()
        activityIndicator.center = footerView.center
       
        footerView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        return footerView
    }
    
}

//MARK:- Extensions Implementations

extension PublicAPIListViewController: ViewProtocol{
    
    ///Housekeeping activity when no data is received from presentor
    func onDataLoadError() {
        DispatchQueue.main.async {
            self.stopActivityIndicatorView()
        }
    }
    
    ///Once data is received from presentor, stop and remove activity indicator, stop pagination and reload the table
    func onFinishLoadTableEntries() {
        DispatchQueue.main.async {
            self.stopActivityIndicatorView()
            self.tableView.reloadData()
            self.presentor?.isPaginating = false
            self.tableView.tableFooterView = nil
        }
    }
}



extension PublicAPIListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presentor?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentor?.numberOfRowsInSection ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: presentor?.reusableCellIdentifier ?? "Cell", for: indexPath) as? PublicAPIListCellView
        cell?.cellViewModel =  presentor?.cellForRow(at: indexPath.row)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(presentor?.heightForRow ?? 0)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(presentor?.heightForRow ?? 0)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presentor?.remove(at: indexPath.row)
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
        let movedObject = presentor?.cellForRow(at: sourceIndexPath.row)
        presentor?.remove(at: sourceIndexPath.row)
        presentor?.insert(item: movedObject, at: destinationIndexPath.row)
        
    }
    
    
    ///Pagination :Fetch result in advance and add to the list
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableView{
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height){
                guard let isPaginating = presentor?.isPaginating else { return }
                if !isPaginating {
                    presentor?.isPaginating = true
                    self.tableView.tableFooterView =  CreateLoadingFooter()
                    presentor?.loadTableEntries()
                }
            }
            
        }
    }
    
    ///Load web page when row selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let link = presentor?.cellForRow(at: indexPath.row)?.link else { return }
        presentor?.loadDetailPage(withUrl:  link)
    }
    
}

///Search entered text against categories and reload the table
extension PublicAPIListViewController : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presentor?.updateSearchResults(searchText: searchText)
        
    }
}
