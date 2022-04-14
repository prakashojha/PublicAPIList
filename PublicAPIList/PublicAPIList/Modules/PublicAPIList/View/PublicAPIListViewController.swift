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
    var sortAscending: Bool = true
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(PublicAPIListCellView.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemYellow //UIColor(red: 96/255, green: 124/255, blue: 60/255, alpha: 1)
        presentor?.fetchAllEntries()
        self.view.addSubview(tableView)
        setupConstraints()
        setupNavigationAndBarButton()
        
    }
    
    
    func setupNavigationAndBarButton(){
        setUpNavigation()
        setUpEditAndSortBarButtons()
    }
    
    
    func setUpNavigation(){
        navigationItem.title = "Public API LIST"
        navigationItem.titleView?.backgroundColor = .cyan
    }
    
    
    func setUpEditAndSortBarButtons(){
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName :"arrow.up.arrow.down"),
                            style: .done,
                            target: self,
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
    
    
    func setupConstraints(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
}


extension PublicAPIListViewController: ViewProtocol{
   
    func onFinishFetchAllEntries() {
        presentor?.loadTableEntries()
    }
    
    func onFinishLoadTableEntries(with apiList: [APIDetail]) {
        self.apiList = apiList
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}


extension PublicAPIListViewController: UITableViewDataSource, UITableViewDelegate{
    
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
    
    
    
}
