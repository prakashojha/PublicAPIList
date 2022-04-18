//
//  PublicAPIListCellView.swift
//  PublicAPIList
//
//  Created by Saumya Prakash on 14/04/22.
//

import Foundation
import UIKit

final class PublicAPIListCellView: UITableViewCell{

    var cellViewModel: APIDetail?{
        didSet{
            DispatchQueue.main.async {
                self.categortLabel.text  = "CATEGORY\n" + (self.cellViewModel?.category ?? "NA")
                self.apiLabel.text  = "API\n" + (self.cellViewModel?.api ?? "NA")
                self.linkLabel.text = self.cellViewModel?.link
                self.descriptionLabel.text = self.cellViewModel?.description
            }
            
        }
    }
    
    
    private func createLabel(text: String, font: CGFloat?, color: UIColor?, alignment: NSTextAlignment?)-> UILabel{
        let label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: font ?? 12)
        label.textColor = color ?? UIColor.black
        label.textAlignment = alignment ?? NSTextAlignment.center
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }
    
    
    private lazy var categortLabel: UILabel = {
        var label = createLabel(text: "Animal", font: 12, color: .black, alignment: .left)
        return label
    }()
    
    
    private lazy var apiLabel: UILabel = {
        let label = createLabel(text: "API:", font: 12, color: .black, alignment: .right)
        return label
    }()
    
    
    private lazy var linkLabel: UILabel = {
        let label = createLabel(text: "LINK:", font: 12, color: .black, alignment: .center)
        return label
    }()
    
    
    private lazy var descriptionLabel: UILabel = {
        let label = createLabel(text: "DESC:", font: 12, color: .black, alignment: .left)
        return label
    }()
    
    

    private lazy var topView: UIView = {
    
        let view = UIView(frame: self.frame)
        view.addSubview(categortLabel)
        view.addSubview(apiLabel)
        view.backgroundColor = UIColor(red: 8/255, green: 164/255, blue: 167/255, alpha: 1)
        
        categortLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categortLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            categortLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            categortLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            categortLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
        
        
        apiLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            apiLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            apiLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            apiLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            apiLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
        
        return view
        
    }()
    
    
    
    
    private lazy var descriptionView: UIView = {
        let view = UIView(frame: self.frame)
        view.addSubview(descriptionLabel)
        view.backgroundColor = UIColor(red: 8/255, green: 164/255, blue: 167/255, alpha: 1)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
        return view
    }()
    
    
    private lazy var linkView: UIView = {
        
        let view = UIView(frame: self.frame)
        view.addSubview(linkLabel)
        linkLabel.textColor = .blue
        view.backgroundColor = UIColor(red: 8/255, green: 164/255, blue: 167/255, alpha: 1) //.lightGray
        
        linkLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            linkLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            linkLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            linkLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            linkLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
        
        return view
    }()
    
    
    private lazy var parentView: UIView = {
        let view = UIView(frame: self.frame)
        view.backgroundColor = .darkGray
        
        view.addSubview(topView)
        view.addSubview(descriptionView)
        view.addSubview(linkView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            topView.topAnchor.constraint(equalTo: view.topAnchor, constant: 2),
            topView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        linkView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            linkView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            linkView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            linkView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -2),
            linkView.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            descriptionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0),
            descriptionView.bottomAnchor.constraint(greaterThanOrEqualTo: linkView.topAnchor, constant: 0)
        ])
        
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    func setUpViews(){
        contentView.addSubview(parentView)
        
    }
    
    
    func setUpConstraints(){
        parentViewConstraint()
    }
    
    
    func parentViewConstraint(){
        parentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            parentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            parentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            parentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            parentView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -2)

        ])
    }
}
