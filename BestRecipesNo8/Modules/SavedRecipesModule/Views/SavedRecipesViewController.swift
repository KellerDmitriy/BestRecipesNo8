//
//  SavedRecipesViewController.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 2.09.23.
//

import UIKit
import SnapKit

final class SavedRecipesViewController: UIViewController {
    
    var presenter: SavedRecipesPresenterProtocol!
 
    // MARK: - Views
    
    private lazy var savedRecipesTitle: UILabel = _savedRecipesTitle
    private lazy var tableView: UITableView = _tableView
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        applyConstraints()
        deleteAllBarButtonTapped()
        animateTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.loadData()
        tableView.reloadData()
        animateTableView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // MARK: - Subviews
    private func addSubviews() {
        view.addSubview(savedRecipesTitle)
        view.addSubview(tableView)
    }
    
    // MARK: - Constraints
    private func applyConstraints() {

        savedRecipesTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            make.leading.equalToSuperview().inset(22)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(savedRecipesTitle.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(0)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(0)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: UICollectionViewDataSource

extension SavedRecipesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.savedRecipes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SavedRecipeCell.cellID, for: indexPath) as! SavedRecipeCell
        
        let recipe = presenter.savedRecipes?[indexPath.row]
        cell.updateRecipeData(image: recipe?.imageData, rating: recipe?.rating, title: recipe?.title, time: recipe?.time, addButtonAction: removeRecipeClosure(at: recipe?.id ?? 0))
        return cell
    }
}

extension SavedRecipesViewController: SavedRecipesViewProtocol {
    func deleteAllBarButtonTapped() {
        let deleteAllItems = UIBarButtonItem(
            title: "Remove All",
            style: .plain,
            target: self,
            action: #selector(deleteAllItemsAction))
        navigationItem.rightBarButtonItem = deleteAllItems
        deleteAllItems.tintColor = .black
    }
    
    @objc func deleteAllItemsAction() {
        presenter.deleteAllBarButtonTapped()
        tableView.reloadData()
    }
    
    func animateTableView() {
        tableView.reloadData()
        if ((presenter.savedRecipes?.isEmpty) == nil){
            let cells = tableView.visibleCells
            let tableViewHeight = tableView.bounds.height
            var delay: Double = 0
            
            for cell in cells {
                cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
                
                UIView.animate(withDuration: 1.5,
                               delay: delay * 0.05,
                               usingSpringWithDamping: 0.8,
                               initialSpringVelocity: 0,
                               options: .curveEaseInOut,
                               animations: {
                    cell.transform = CGAffineTransform.identity
                },completion: nil)
                delay += 1
            }
        }
    }
    
    func openSavedRecipes() {
        presenter.loadData()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.animateTableView()
        }
    }
    
    func removeRecipeClosure(at index: Int) -> (() -> ()) {
        return{
           self.presenter.deleteRecipe(with: index)
            self.tableView.reloadData()
            self.animateTableView()
        }
    }
}

// MARK: - Extension for setup elements
private extension SavedRecipesViewController {
    
    var _savedRecipesTitle: UILabel {
        let label = UILabel()
        label.text = "Saved recipes"
        label.font = UIFont.poppinsSemiBold(size: 24)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }
    
    var _tableView: UITableView {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SavedRecipeCell.self, forCellReuseIdentifier: SavedRecipeCell.cellID)
        tableView.backgroundColor = .clear
        tableView.rowHeight = 210
        return tableView
    }
}


