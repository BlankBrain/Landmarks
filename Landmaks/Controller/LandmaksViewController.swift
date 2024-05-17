//
//  LandmaksViewController.swift
//  Landmaks
//
//  Created by Md. Mehedi Hasan on 17/5/24.
//

import UIKit
import Combine

class LandmaksViewController: UIViewController , UICollectionViewDelegate{
    
    //MARK: Components
    private lazy var baseView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    //MARK: CollectionView
    lazy var landmaksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(LandmaksCollectionViewCell.self, forCellWithReuseIdentifier: "LandmaksCollectionViewCell")
        return collectionView
    }()
    
    //MARK: Variables
    var viewModel = LandmaksViewModel()
    private typealias DataSource = UICollectionViewDiffableDataSource<LandmaksSection, AnyHashable>
    private var dataSource: DataSource?
    private let layout = LandmaksViewLayouts()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setupBindings()
    }
    //MARK: View Functions
    func setView(){
        view.backgroundColor = .systemBackground
        addSubViews()
        setupViewConstrains()
    }
    func addSubViews(){
        self.view.addSubview(baseView)
        baseView.addSubview(landmaksCollectionView)
    }
    private func setupBindings(){
        setupCollectionView()
        self.viewModel.$landMarks
            .receive(on: DispatchQueue.main)
            .sink { [weak self] updateData in
                self?.applyData()
            }.store(in: &cancellables)
    }
    //MARK: Constrains
    func setupViewConstrains() {
        baseView.translatesAutoresizingMaskIntoConstraints = false
        landmaksCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Constraints for baseView
            baseView.topAnchor.constraint(equalTo: view.topAnchor),
            baseView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Constraints for landmaksCollectionView
            landmaksCollectionView.topAnchor.constraint(equalTo: baseView.topAnchor),
            landmaksCollectionView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            landmaksCollectionView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
            landmaksCollectionView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        landmaksCollectionView.collectionViewLayout = makeLayout()
        landmaksCollectionView.delegate = self
        setupCollectionViewDataSource()
        applyData()
        landmaksCollectionView.showsVerticalScrollIndicator = false
    }
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let sectionType = self?.dataSource?.snapshot().sectionIdentifiers[sectionIndex] else {
                fatalError("Section type not found")
            }
            switch sectionType {
            case .LandmaksList:
                return self?.layout.landmaksListSectionLayout(showHeader: false)
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 8
        layout.configuration = config
        return layout
    }
    private func setupCollectionViewDataSource() {
        dataSource = DataSource(collectionView: landmaksCollectionView) { [weak self] collectionView, indexPath, item in
            guard let sectionType = self?.dataSource?.snapshot().sectionIdentifiers[indexPath.section] else {
                return UICollectionViewCell()
            }
            
            switch sectionType {
            case .LandmaksList:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LandmaksCollectionViewCell", for: indexPath) as? LandmaksCollectionViewCell else {
                    fatalError("Unable to dequeue LandmaksCollectionViewCell")
                }
                if let landmark = item as? LandmaksModel {
                    cell.setupCell(landmark: landmark)
                }
                return cell
            }
        }
    }
    
    private func applyData() {
        var snapshot = NSDiffableDataSourceSnapshot<LandmaksSection, AnyHashable>()
        snapshot.appendSections([.LandmaksList])
        snapshot.appendItems( self.viewModel.landMarks, toSection: .LandmaksList)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
