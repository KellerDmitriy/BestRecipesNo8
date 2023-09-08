//
//  SearchTableView.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 08.09.2023.
//

import UIKit

class SearchTableView: UIView {

    let searchTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SearchViewCell.self, forCellReuseIdentifier: "SearchViewCell")
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    private var recipesItems: [SearchRecipe] = []
    private var navigationController: UINavigationController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
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
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: SearchViewCell.cellID, for: indexPath) as? SearchViewCell else { return UITableViewCell() }
        cell.configureCell(recipe: recipesItems[indexPath.item])
        cell.selectionStyle = .none
        return cell
    }
    
}

//MARK: Setup

private extension SearchTableView {
    
    func setup() {
        addSubview(searchTableView)
        setDelegate()
        setConstraints()
    }
    
    func setDelegate() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    func setConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchTableView.topAnchor.constraint(equalTo: topAnchor),
            searchTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchTableView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}


