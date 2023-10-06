//
//  TopTabView.swift
//  TopMenu
//
//  Created by Hemant kumar on 04/06/23.
//

import Foundation
import UIKit

protocol TopTabViewDelegate: AnyObject {
    func topTabView(menuChanged: String?, index: Int)
}

class TopTabView: UIView {
    
    //MARK: - outlet's
    //Flow layout for collection view
    private lazy var flowlayout: UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        return flow
    }()
    
    //Collection view for the tiles
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    
    //MARK: - Properties
    enum WidthStryle {
        
        //Devide equaly according to width of view
        case equal
        
        //Devide accordingly size of content
        case contentSize
    }
    
    //Type of width distribution for content
    var widthStyle: WidthStryle = .contentSize
    
    //Delegate
    weak var delegate: TopTabViewDelegate?
    
    //Selected Menu item
    var selectedItem: String? {
        if arrayOfContent.count > selectedMenu {
            return arrayOfContent[selectedMenu]
        }
        return nil
    }
    
    //SelectedMenu Index
    var selectedMenu: Int = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //Title font used in tile
    private var titleFont = UIFont(name: "System-Medium", size: 14)
    
    //List of item in menu bar
    private var arrayOfContent: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInitialization()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInitialization()
    }
    
    override func prepareForInterfaceBuilder() {
        customInitialization()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK: - Helpers
    private func customInitialization() {
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        registerCell()
    }
    
    private func registerCell() {
        collectionView.register(UINib(nibName: "TopTabCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopTabCollectionViewCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    //Load Content In the menu View
    func load(items: [String]) {
        self.arrayOfContent = items
    }
    
    //Update The Selected Menu Index
    func updateSelectedMenu(item: String) {
        if let index = arrayOfContent.firstIndex(where: {$0.lowercased() == item.lowercased()}) {
            selectedMenu = index
        }
    }
}

extension TopTabView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayOfContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopTabCollectionViewCell", for: indexPath) as? TopTabCollectionViewCell {
            let item = arrayOfContent[indexPath.row]
            cell.configureTitle(title: item)
            cell.configureColor(isSelected: indexPath.item == selectedMenu)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if widthStyle == .equal {
            let textSize = collectionView.frame.size.width / CGFloat(arrayOfContent.count)
            return CGSize(width: textSize, height: collectionView.frame.height)
        } else {
            guard let titleFont = titleFont else { fatalError("Error") }
            let textSize = arrayOfContent[indexPath.item].size(of: titleFont)
            return CGSize(width: textSize.width + 40, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        selectedMenu = indexPath.item
        delegate?.topTabView(menuChanged: selectedItem, index: selectedMenu)
        
    }
}

extension TopTabView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension String {
    func size(of font: UIFont) -> CGSize {
        let attribute = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: attribute)
        return size
    }
}

