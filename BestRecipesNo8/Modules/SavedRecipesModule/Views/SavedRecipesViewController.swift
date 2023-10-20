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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        openSavedRecipes()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.savedRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedRecipeCell.cellID, for: indexPath) as? SavedRecipeCell else { return UITableViewCell() }
        
        let recipe = presenter.savedRecipes[indexPath.row]
        cell.configureSavedCell(
            image: recipe.imageData,
            rating: recipe.rating,
            title: recipe.title,
            time: recipe.time,
            addButtonClosure: removeRecipeClosure(at: recipe.id)
        )
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let recipe = presenter.savedRecipes[indexPath.row]
//        presenter.router.routeToDetailScreen(recipe: recipe as! RecipeProtocol)
//    }
}

//MARK: SavedRecipesViewProtocol
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
           showAlertWithConfirmation(
               title: "Danger!!!",
               message: "Are you sure you want to delete all saved recipes?",
               confirmationTitle: "Delete?",
               completion: { [weak self] in
                   self?.presenter.deleteAllBarButtonTapped()
                   self?.animateTableView()
               }
           )
       }
    
    func animateTableView() {
            tableView.reloadData()

            let cells = tableView.visibleCells
            let tableViewHeight = tableView.bounds.size.height

            for (index, cell) in cells.enumerated() {
                cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)

                UIView.animate(
                    withDuration: 0.5,
                    delay: 0.08 * Double(index),
                    usingSpringWithDamping: 0.8,
                    initialSpringVelocity: 0,
                    options: .curveEaseOut,
                    animations: {
                        cell.transform = .identity
                    },
                    completion: nil
            )
        }
    }

    func openSavedRecipes() {
        presenter.loadData()
        DispatchQueue.main.async {
            self.animateTableView()
        }
    }
    
    func removeRecipeClosure(at index: Int) -> (() -> ()) {
        return {
           self.presenter.deleteRecipe(with: index)
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
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .singleLine
        tableView.register(SavedRecipeCell.self, forCellReuseIdentifier: SavedRecipeCell.cellID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }
}


