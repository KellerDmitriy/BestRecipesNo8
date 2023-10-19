//
//  CreateViewController.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 10.09.2023.
//

import UIKit

class CreateViewController: UIViewController {
    
    var presenter: CreateRecipePresenterProtocol!
    
    // MARK: - Private Properties
    
    private lazy var savedRecipesTitle: UILabel = {
        let label = UILabel()
        label.text = "Create recipe"
        label.font = UIFont.poppinsSemiBold(size: 24)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 400)
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.9450979829, green: 0.9450979829, blue: 0.9450981021, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var addImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "highlighter"), for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = .white
        button.tintColor = .black
        button.addTarget(self, action: #selector(addImageButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleRecipe: CreateTextField = {
        let tf = CreateTextField()
        tf.placeholder = "Enter recipe title "
        tf.layer.cornerRadius = 10
        tf.layer.borderColor = UIColor.red.cgColor
        tf.layer.borderWidth = 1
        tf.tag = 0
        tf.autocorrectionType = .no
        tf.returnKeyType = .done
        tf.smartInsertDeleteType = .no
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var servesView = CreateView()
    
    private lazy var cookTimeView = CreateView()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: IngredientTableViewCell.cellID)
        tableView.register(AddIngredientTableViewCell.self, forCellReuseIdentifier: AddIngredientTableViewCell.cellID)
        tableView.register(IngredientHeaderView.self, forHeaderFooterViewReuseIdentifier: IngredientHeaderView.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var createRecipeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create recipe", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.poppinsSemiBold(size: 16)
        button.layer.cornerRadius = 10
        button.backgroundColor = .primaryColor
        //        button.isEnabled = false
        button.addTarget(self, action: #selector(createRecipeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Variable Properties
    
   
        
    private var activeTextField: UITextField? = nil
    private var rows = 1
    private var imageData = Data()
    private var titleNewRecipe = ""
    private var ingredients: [String: String] = [:]
    
    
    // MARK: - Life View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        registerForKeayboardNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.contentSize = setContentHeight()
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
    // MARK: - Setup UI
    
    private func setupSubviews() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(savedRecipesTitle)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleRecipe)
        stackView.addArrangedSubview(servesView)
        servesView.congigureView(with: .serves, and: .serves)
        stackView.addArrangedSubview(cookTimeView)
        cookTimeView.congigureView(with: .cookTime, and: .cookTime)
        
        scrollView.addSubview(tableView)
        
        view.addSubview(createRecipeButton)
        
        imageView.addSubview(addImageButton)
        
        servesView.button.addTarget(self, action: #selector(servesViewButtonTapped), for: .touchUpInside)
        cookTimeView.button.addTarget(self, action: #selector(cookTimeViewButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        
        // createRecipeButton
        NSLayoutConstraint.activate([
            createRecipeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -13),
            createRecipeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createRecipeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createRecipeButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        // scrollView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: createRecipeButton.topAnchor)
        ])

        // stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        // height of elements inside stack
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 200),
            titleRecipe.heightAnchor.constraint(equalToConstant: 43.6),
            servesView.heightAnchor.constraint(equalToConstant: 60),
            cookTimeView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // addImageButton
        NSLayoutConstraint.activate([
            addImageButton.widthAnchor.constraint(equalToConstant: 32),
            addImageButton.heightAnchor.constraint(equalToConstant: 32),
            addImageButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            addImageButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8)
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: createRecipeButton.topAnchor, constant: -20)
        ])
        
    }
    
    private func setContentHeight() -> CGSize {
        let stackContentHeight = stackView.frame.size.height
        let tableContentHeight = tableView.contentSize.height
        let contentHeight = stackContentHeight + tableContentHeight
        return CGSize(width: UIScreen.main.bounds.width, height: contentHeight)
    }
    
}

// MARK: - UITableViewDataSource

extension CreateViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let lastIndex = tableView.numberOfRows(inSection: 0) - 1
        
        switch indexPath.row {
        case lastIndex:
            guard let addCell = tableView.dequeueReusableCell(withIdentifier: AddIngredientTableViewCell.cellID, for: indexPath) as? AddIngredientTableViewCell else { return UITableViewCell() }
            return addCell
        default:
            guard let ingredientCell = tableView.dequeueReusableCell(withIdentifier: IngredientTableViewCell.cellID, for: indexPath) as? IngredientTableViewCell else { return UITableViewCell() }
            
            ingredientCell.configureCell(for: indexPath)
            ingredientCell.deleteIngredientButton.addTarget(self, action: #selector(deleteIngredientButtonTapped), for: .touchUpInside)
            ingredientCell.selectionStyle = .none
            
            ingredientCell.nameIngredient.delegate = self
            ingredientCell.quantityIngredient.delegate = self
            
            return ingredientCell
        }
    }
    
}

// MARK: - UITableViewDelegate

extension CreateViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        scrollView.contentSize = setContentHeight()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: IngredientHeaderView.reuseID) as? IngredientHeaderView
        else { return UIView() }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        rows += 1
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            scrollView.isScrollEnabled = true
        }
    }
    
}

// MARK: - TextFieldDelegate

extension CreateViewController: UITextFieldDelegate {
 
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text, !text.isEmpty else {
            textField.resignFirstResponder()
            
            switch textField.tag {
            case 0:
                showAlert(title: "Warning!", message: "Enter recipe name.")
            case 1:
                showAlert(title: "Warning!", message: "Enter ingredient name.")
            default:
                showAlert(title: "Warning!", message: "Enter ingredient quantity.")
            }
            return true
        }
        
        if textField == titleRecipe {
            titleNewRecipe = text
            textField.resignFirstResponder()
        }
    
        guard let cell = textField.superview?.superview as? IngredientTableViewCell else { return true }
            
        switch textField {
        case cell.nameIngredient:
            ingredients[text] = ""
            cell.quantityIngredient.becomeFirstResponder()
        default:
            if let ingredient = cell.nameIngredient.text {
                ingredients[ingredient] = text
            }
            textField.resignFirstResponder()
        }
        
        activeTextField = nil
        view.endEditing(true)
        return true
    }
    
}

// MARK: - OBJC Methods

extension CreateViewController {
    
    @objc func addImageButtonTapped() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
    }
    
    @objc func servesViewButtonTapped() {
        showAlert(title: "Serves", message: "Specify the number of persons") { text in
            self.servesView.countLabel.text = text
        }
    }
    
    @objc func cookTimeViewButtonTapped() {
        showAlert(title: "Cook time", message: "Specify the cooking time of the dish (minutes)") { text in
            self.cookTimeView.countLabel.text = "\(text) min"
        }
    }
    
    @objc func deleteIngredientButtonTapped(_ sender: UIButton) {
        
        guard let cell = sender.superview?.superview as? IngredientTableViewCell else { return }
        guard let table = cell.superview as? UITableView else { return }
        guard let indexPath = table.indexPath(for: cell) else { return }

        guard let ingredient = cell.nameIngredient.text else { return }

        rows -= 1
        tableView.deleteRows(at: [indexPath], with: .automatic)
        ingredients[ingredient] = nil
        
        scrollView.contentSize = setContentHeight()
        
    }
    
    @objc func createRecipeButtonTapped() {
       
        guard let serves = servesView.countLabel.text, let cookTime = cookTimeView.countLabel.text else { return }
        
        if !titleNewRecipe.isEmpty && !serves.isEmpty && !cookTime.isEmpty && !ingredients.isEmpty {
            
            let recipeForRealm = RecipeInfoRealm(title: titleNewRecipe,
                                                 serves: serves,
                                                 cookTime: cookTime,
                                                 imageData: imageData,
                                                 ingredients: ingredients)
            StorageManager.shared.save(recipe: recipeForRealm)
            showAlert(title: "Done!", message: "Saved your recipe.)")
            navigationController?.popViewController(animated: true)
        } else {
            showAlert(title: "Warning!", message: "Not all data entered.")
        }
                
    }
    
    @objc func nextBarButtonTapped() {
        guard let cell = activeTextField?.superview?.superview as? IngredientTableViewCell else { return }
        if cell.nameIngredient.isEditing {
            cell.quantityIngredient.becomeFirstResponder()
        }
    }
    
    @objc func doneBarButtonTapped() {
        guard let cell = activeTextField?.superview?.superview as? IngredientTableViewCell else { return }
        if cell.quantityIngredient.isEditing {
            view.endEditing(true)
        }
    }
    
}

// MARK: - Keyboard shows/hides

extension CreateViewController {
    
    private func registerForKeayboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {

        let userInfo = notification.userInfo
    
        if let keyboardFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey]) as? CGRect {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardFrame.height, right: 0.0)
            scrollView.contentInset = contentInsets
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension CreateViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        self.imageView.image = image
        if let imageData = image.pngData() {
            self.imageData = imageData
        }
        
        dismiss(animated: true)
    }

}

// MARK: - CreateViewProtocol

extension CreateViewController: CreateViewProtocol {
    
}
