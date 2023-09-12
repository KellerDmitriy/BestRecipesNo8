//
//  SearchTableView.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 08.09.2023.
//

import UIKit
import SnapKit

class SearchTableView: UIView {

    let searchTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SearchViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    private var recipesItems: [SearchRecipe] = []
    private var navigationController: UINavigationController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(models: [SearchRecipe], navigationController: UINavigationController?) {
        recipesItems = models
        self.navigationController = navigationController
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       recipesItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? SearchViewCell else { return UITableViewCell() }
        cell.configure(
            model: recipesItems[indexPath.item])
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: Setup

private extension SearchTableView {
    
    func setupUI() {
        self.addSubview(searchTableView)
        setDelegate()
        setConstraints()
    }
    
    
    func setDelegate() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    func setConstraints() {
        
        searchTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
}


