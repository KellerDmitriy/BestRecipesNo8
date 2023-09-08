//
//  HomeView.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 4.09.23.
//

import UIKit

class HomeView: UIViewController {
    
    private lazy var scrollView: UIScrollView = _scrollView
    private lazy var contentView: UIView = _contentView
    
    private lazy var collectionView: UICollectionView = _collectionView
    
    private lazy var sections = MockData.shared.pageData
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        applyConstraints()
        selectFirstCell()
    }
    
    // MARK: - Subviews
    private func addSubviews() {
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        contentView.addSubview(collectionView)
    }
    
    // MARK: - Constraints
    private func applyConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)
            make.height.equalTo(UIScreen.main.bounds.height - 200)
        }
    }
    
    private func selectFirstCell() {
        let indexPath = IndexPath(item: 1, section: 1)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
    }
}

// MARK: - UICollectionViewDataSource

extension HomeView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch sections[indexPath.section] {
        case .trendingNow(let recipe):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCategoryPreviewCell.cellID, for: indexPath) as? TrendingCategoryPreviewCell
            else {
                return UICollectionViewCell()
            }
            
            let currentRecipe = recipe[indexPath.row]
            cell.updateRecipeData(image: currentRecipe.image, title: currentRecipe.title, rating: currentRecipe.rating)
            
            return cell
        case .popularCategories(let category):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCategoryPreviewCell.cellID, for: indexPath) as? PopularCategoryPreviewCell
            else {
                return UICollectionViewCell()
            }
            
            let currentCategory = category[indexPath.row]
            cell.updateCategoryData(title: currentCategory.title)
            cell.isSelected ? cell.selectCell() : cell.deselectCell()
            
            return cell
        case .popularRecipe(let recipe):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularRecipesPreviewCell.cellID, for: indexPath) as? PopularRecipesPreviewCell
            else {
                return UICollectionViewCell()
            }
            
            let currentRecipe = recipe[indexPath.row]
            cell.updateRecipeData(image: currentRecipe.image, title: currentRecipe.title, time: currentRecipe.time)
            
            return cell
        case .recentRecipe(let recipe):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCategoryPreviewCell.cellID, for: indexPath) as? RecentCategoryPreviewCell
            else {
                return UICollectionViewCell()
            }
            
            let currentRecipe = recipe[indexPath.row]
            cell.updateRecipeData(image: currentRecipe.image, rating: 4.8, title: currentRecipe.title, count: 10, minutes: 25)
            
            return cell
        case .teamMembers(let member):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamMembersCell.cellID, for: indexPath) as? TeamMembersCell
            else {
                return UICollectionViewCell()
            }
            
            let currentMember = member[indexPath.row]
            cell.updateCellData(image: currentMember.image, title: currentMember.title)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: "header",
                                                                         for: indexPath) as! HeaderSupplementaryView
            let sectionIndex = indexPath.section
            header.configureHeader(category: sections[sectionIndex].title)
            
            if sectionIndex == 1 {
                header.isButtonHidden = true
            }
            
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PopularCategoryPreviewCell {
            cell.selectCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PopularCategoryPreviewCell {
            cell.deselectCell()
        }
    }
}

extension HomeView {
    
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
            case .recentRecipe:
                return self.createRecentSection()
            case .teamMembers:
                return self.createTeamSection()
            }
        }
    }
    
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
    
    private func createTrendingSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(0.77)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.8),
                                                                         heightDimension: .fractionalHeight(0.55)),
                                                       subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: 5,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = NSDirectionalEdgeInsets(top: -20, leading: 10, bottom: -40, trailing: 0)
        return section
    }
    
    private func createPopularCategorySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(0.25)))
        
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.21),
                                                                         heightDimension: .fractionalHeight(0.2)),
                                                       subitems: [item])
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 0,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: -100, trailing: 0)
        return section
    }
    
    private func createPopularRecipeSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(0.9)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.4),
                                                                         heightDimension: .fractionalHeight(0.4)),
                                                       subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: 13,
                                          supplementaryItems: [],
                                          contentInsets: false)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        return section
    }
    
    private func createRecentSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(0.9)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.33),
                                                                         heightDimension: .fractionalHeight(0.35)),
                                                       subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: 15,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0)
        return section
    }
    
    private func createTeamSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.4),
                                                                         heightDimension: .fractionalHeight(0.35)),
                                                       subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: 10,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 10, bottom: 0, trailing: 0)
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                heightDimension: .estimated(30)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top)
    }
    
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
    
    var _collectionView: UICollectionView {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TrendingCategoryPreviewCell.self, forCellWithReuseIdentifier: TrendingCategoryPreviewCell.cellID)
        collectionView.register(PopularCategoryPreviewCell.self, forCellWithReuseIdentifier: PopularCategoryPreviewCell.cellID)
        collectionView.register(PopularRecipesPreviewCell.self, forCellWithReuseIdentifier: PopularRecipesPreviewCell.cellID)
        collectionView.register(RecentCategoryPreviewCell.self, forCellWithReuseIdentifier: RecentCategoryPreviewCell.cellID)
        collectionView.register(TeamMembersCell.self, forCellWithReuseIdentifier: TeamMembersCell.cellID)
        
        collectionView.register(HeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        collectionView.collectionViewLayout = createLayout()
        return collectionView
    }
}
