//
//  MenuViewController.swift
//  TopMenu
//
//  Created by Hemant kumar on 04/06/23.
//

import UIKit

class MenuViewController: UIViewController {
    
    //MARK: - Outlet's
    @IBOutlet weak var menuView: TopTabView!
    @IBOutlet weak var containerView: UIView!
    
    //MARK: - Properties
    var menu: Menu = .tabOne
    private lazy var viewController: MenuPageViewController = {
        let vc = MenuPageViewController()
        addChild(vc)
        self.add(asChildViewController: vc)
        return vc
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        configureMenu()
        changeObserver()
        
    }
    
    //MARK: - Helpers
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.didMove(toParent: self)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    func updateView() {
        add(asChildViewController: viewController)
    }
    
    private func configureMenu() {
        menuView.load(items: Menu.menuListArray.compactMap({$0.uppercased()}))
        menuView.updateSelectedMenu(item: menu.string)
        menuView.widthStyle = .equal
        menuView.delegate = self
    }
    
    private func changeObserver() {
        viewController.onPageChange = { [weak self](_ currentMenu: Menu?) in
            guard let currentMenu = currentMenu else { return }
            self?.menuView.updateSelectedMenu(item: currentMenu.string)
        }
    }
    
    private func updateMenuSelection() {
        viewController.menu = menu
        viewController.loadViewController()
    }
}

extension MenuViewController: TopTabViewDelegate {
    func topTabView(menuChanged: String?, index: Int) {
        guard let selectedMenu = Menu.getType(from: menuChanged ?? "") else { return }
        menu = selectedMenu
        updateMenuSelection()
    }
}
