//
//  HomeView.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 4.09.23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var presenter: HomePresenterProtocol!
    
    // MARK: - Views
    private lazy var scrollView: UIScrollView = _scrollView
    private lazy var contentView: UIView = _contentView
    
    private lazy var titleLabel: UILabel = _titleLabel
    private lazy var recipeSearchField: UISearchTextField = _recipeSearchField
    private lazy var collectionView: UICollectionView = _collectionView
    
    private lazy var sections = SectionsData.shared.sectionsArray
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getRecipes()
        addSubviews()
        applyConstraints()
        selectFirstCell()
        registerCollectionViewsAndHeaders()
    }
    
    // MARK: - Method to set category "Breakfast" selected
    
    private func selectFirstCell() {
        let indexPath = IndexPath(item: 1, section: 1)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
    }
    
    // MARK: - Appoint layout to each section
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let section = self.sections[sectionIndex]
            
            switch section {
            case .trendingNow:
                return self.createTrendingSection()
            case .popularCategories:
                return self.createPopularCategorySection()
            case .popularRecipe:
                return self.createPopularRecipeSection()
            case .randomRecipe:
                return self.createRandomSection()
            case .teamMembers:
                return self.createTeamSection()
            }
        }
    }
    
    // MARK: - Creation layout of section
    
    private func createLayoutSection(group: NSCollectionLayoutGroup,
                                     behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                                     interGroupSpacing: CGFloat,
                                     supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
                                     contentInsets: Bool) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        section.supplementariesFollowContentInsets = contentInsets
        return section
    }
    
    // MARK: - Method to create item and group for sections
    
    private func createItemAndGroup(section: HomeSections) -> NSCollectionLayoutGroup {
        let data = getDimensions(section: section)
        
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(data.itemWidth),
                              heightDimension: .absolute(data.itemHeight)))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(data.groupWidth),
                              heightDimension: .fractionalHeight(data.groupHeight)),
            subitems: [item])
        return group
    }
    
    // MARK: - Create Sections for CollectionView
    
    private func createTrendingSection() -> NSCollectionLayoutSection {
        let group = createItemAndGroup(section: sections[0])
        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: 5,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 50, trailing: 0)
        return section
    }
    
    private func createPopularCategorySection() -> NSCollectionLayoutSection {
        let group = createItemAndGroup(section: sections[1])
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 0,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0)
        return section
    }
    
    private func createPopularRecipeSection() -> NSCollectionLayoutSection {
        let group = createItemAndGroup(section: sections[2])
        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: 13,
                                          supplementaryItems: [],
                                          contentInsets: false)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 0)
        return section
    }
    
    private func createRandomSection() -> NSCollectionLayoutSection {
        let group = createItemAndGroup(section: sections[3])
        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: 15,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0)
        return section
    }
    
    private func createTeamSection() -> NSCollectionLayoutSection {
        let group = createItemAndGroup(section: sections[4])
        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: 10,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 10, bottom: 0, trailing: 0)
        return section
    }
    
    // MARK: - Settings of header of each section
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(30)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top)
    }
    
    // MARK: - Subviews
    private func addSubviews() {
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        contentView.addSubview(collectionView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(recipeSearchField)
    }
    
    // MARK: - Constraints
    private func applyConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        recipeSearchField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(recipeSearchField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)
            make.height.equalTo(UIScreen.main.bounds.height - 350)
        }
    }
    
    func registerCollectionViewsAndHeaders() {
        collectionView.register(TrendingCategoryCell.self, forCellWithReuseIdentifier: TrendingCategoryCell.cellID)
        collectionView.register(PopularCategoryCell.self, forCellWithReuseIdentifier: PopularCategoryCell.cellID)
        collectionView.register(PopularRecipesCell.self, forCellWithReuseIdentifier: PopularRecipesCell.cellID)
        collectionView.register(RandomCategoryCell.self, forCellWithReuseIdentifier: RandomCategoryCell.cellID)
        collectionView.register(TeamMembersCell.self, forCellWithReuseIdentifier: TeamMembersCell.cellID)
        
        collectionView.register(HeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section >= 0 && section <= sections.count {
            let currentSection = sections[section]
            switch currentSection {
            case .trendingNow:
                return presenter.trendingNowRecipes.count
            case .popularCategories:
                return presenter.popularCategories.count
            case .randomRecipe:
                return presenter.randomRecipe.count
            case .popularRecipe:
                return presenter.popularCategoryRecipes.count
            case .teamMembers(_):
                return presenter.teamMembers.count
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch sections[indexPath.section] {
        case .trendingNow:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCategoryCell.cellID, for: indexPath) as? TrendingCategoryCell
            else {
                return UICollectionViewCell()
            }
            
            let currentRecipe = presenter.trendingNowRecipes[indexPath.item]
            cell.configureCell(at: currentRecipe)
            
            return cell
        case .popularCategories:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCategoryCell.cellID, for: indexPath) as? PopularCategoryCell
            else {
                return UICollectionViewCell()
            }
            
            let currentCategory = presenter.popularCategories[indexPath.item]
            cell.configureCell(
                title: currentCategory)
            cell.isSelected ? cell.selectCell(indexPath.item) : cell.deselectCell()
            cell.didSelectCategoryHandler = { [weak self] category in
                self?.getPopularRecipes(with: category)
            }
            
            return cell
        case .popularRecipe:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularRecipesCell.cellID, for: indexPath) as? PopularRecipesCell
            else {
                return UICollectionViewCell()
            }
            
            let currentRecipe = presenter.popularCategoryRecipes[indexPath.row]
            cell.configureCell(at: currentRecipe)
            
            return cell
        case .randomRecipe:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RandomCategoryCell.cellID, for: indexPath) as? RandomCategoryCell
            else {
                return UICollectionViewCell()
            }
            
            let currentRecipe = presenter.randomRecipe[indexPath.row]
            cell.configureCell(at: currentRecipe)
            
            return cell
        case .teamMembers(let member):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamMembersCell.cellID, for: indexPath) as? TeamMembersCell
            else {
                return UICollectionViewCell()
            }
            
            let currentMember = member[indexPath.row]
            cell.configureCell(image: currentMember.image, title: currentMember.title)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: "header",
                                                                     for: indexPath) as! HeaderSupplementaryView
        
        switch sections[indexPath.section] {
        case .trendingNow:
            header.configureHeader(category: "Trending now")
            header.seeAllButton.addTarget(self, action: #selector(seeAllTrendingButtonTap), for: .touchUpInside)
            return header
        case .popularCategories:
            header.configureHeader(category: "Popular category")
            header.isButtonHidden = true
            return header
        case .randomRecipe:
            header.configureHeader(category: "Random Recipe")
            header.seeAllButton.addTarget(self, action: #selector(seeAllRandomButtonTap), for: .touchUpInside)
            return header
        default:
            header.configureHeader(category: "Dream Teem")
            return header
        }
    }
    
    @objc func seeAllTrendingButtonTap() {
        presenter.seeAllButtonTapped(with: .trendingNow)
    }
    
    @objc func seeAllRandomButtonTap() {
        presenter.seeAllButtonTapped(with: .random)
    }
    
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let cell = collectionView.cellForItem(at: indexPath) as? PopularCategoryCell {
            cell.selectCell(indexPath.item)
            return true
        } else {
            //            let controller = RecipeBuilder.createRecipeModule()
            //            navigationController?.pushViewController(controller, animated: true)
            return false
        }
        
        //        var id = 0
        //        switch indexPath.section {
        //        case 0:
        //            id = presenter.trendingNowRecipes[indexPath.item].id
        //        case 1:
        //            id = presenter.popularCategoryRecipes[indexPath.item].id
        //        case 2:
        //            id = presenter.randomRecipe[indexPath.item].id
        //        default:
        //            break
        //        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PopularCategoryCell {
            cell.selectCell(indexPath.item)
            collectionView.reloadSections(IndexSet(integer: 2))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PopularCategoryCell {
            cell.deselectCell()
        }
    }
}

//MARK: HomeViewProtocol Methods
extension HomeViewController: HomeViewProtocol {
    func getDimensions(section: HomeSections) -> (itemWidth: CGFloat, itemHeight: CGFloat, groupWidth: CGFloat, groupHeight: CGFloat) {
        
        switch section {
        case .trendingNow: return (1, 0.9, 0.8, 0.55)
        case .popularCategories: return (0.9, 30, 0.21, 0.2)
        case .popularRecipe: return (1, 0.9, 0.4, 0.4)
        case .randomRecipe: return (1, 0.9, 0.33, 0.45)
        case .teamMembers: return (1, 1, 0.4, 0.45)
        }
    }
    
    func updatePopularCategory() {
        collectionView.reloadData()
    }
    
    func getPopularRecipes(with category: String) {
        presenter.getRecipesWithMealType(mealType: category)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func getRecipes() {
        presenter.networkManager.getTenPopularRecipes() { result in
            switch result {
            case .success(let results):
                let recipes = results
                self.presenter.trendingNowRecipes = recipes
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        presenter.networkManager.getRandomRecipes { result in
            switch result {
            case .success(let results):
                if let recipes = results.recipes {
                    self.presenter.randomRecipe = recipes
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func openHome() {}
}

private extension HomeViewController {
    
    var _scrollView: UIScrollView {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }
    
    var _contentView: UIView {
        let view = UIView()
        return view
    }
    
    var _titleLabel: UILabel {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 24)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.text = "Get amazing recipes \nfor cooking"
        return label
    }
    
    var _recipeSearchField: UISearchTextField {
        let searchField = UISearchTextField()
        searchField.placeholder = "Search recipes"
        return searchField
    }
    
    var _collectionView: UICollectionView {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.collectionViewLayout = createLayout()
        return collectionView
    }
}
