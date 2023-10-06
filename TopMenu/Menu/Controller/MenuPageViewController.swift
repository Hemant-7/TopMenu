//
//  MenuPageViewController.swift
//  TopMenu
//
//  Created by Hemant kumar on 04/06/23.
//

import UIKit

class MenuPageViewController: UIPageViewController {
    
    //MARK: - Properties
    var onPageChange: ((_ currentMenu: Menu) -> Void)?
    var menu: Menu = .tabOne
    
    lazy var viewControllerlist: [UIViewController] = {
        var arrayOfController: [UIViewController] = []
        
        let tabOneStoryboard = UIStoryboard(name: "TabOne", bundle: nil)
        let tabOneViewController = tabOneStoryboard.instantiateViewController(withIdentifier: "TabOneViewController") as! TabOneViewController
        arrayOfController.append(tabOneViewController)
        
        let tabTwoStoryboard = UIStoryboard(name: "TabTwo", bundle: nil)
        let tabTwoViewController = tabTwoStoryboard.instantiateViewController(withIdentifier: "TabTwoViewController") as! TabTwoViewController
        arrayOfController.append(tabTwoViewController)
        
        let tabThreeStoryboard = UIStoryboard(name: "TabThree", bundle: nil)
        let tabThreeViewController = tabThreeStoryboard.instantiateViewController(withIdentifier: "TabThreeViewController") as! TabThreeViewController
        arrayOfController.append(tabThreeViewController)
        return arrayOfController
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        loadViewController()
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not beed implemented")
    }
    
    //MARK: - Helpers
    func loadViewController() {
        switch menu {
        case .tabOne:
            if viewControllerlist.isEmpty == false, let vc = viewControllerlist.first {
                self.setViewControllers([vc], direction: .forward, animated: false)
            }
        case .tabTwo:
            if viewControllerlist.count > 1 {
                let vc = viewControllerlist[1]
                self.setViewControllers([vc], direction: .forward, animated: false)
            }
        case .tabThree:
            if viewControllerlist.count > 2 {
                let vc = viewControllerlist[2]
                self.setViewControllers([vc], direction: .forward, animated: false)
            }
        }
    }
}

extension MenuPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllerlist.lastIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        guard previousIndex >= 0 else { return nil }
        guard previousIndex < viewControllerlist.count else { return nil }
        return viewControllerlist[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllerlist.lastIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        guard nextIndex >= 0 else { return nil }
        guard nextIndex < viewControllerlist.count else { return nil }
        return viewControllerlist[nextIndex]
    }
}

extension MenuPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            
            guard let currentViewController = pageViewController.viewControllers?.first, let index = viewControllerlist.firstIndex(of: currentViewController) else { return }
            switch index {
            case 0:
                onPageChange?(.tabOne)
            case 1:
                onPageChange?(.tabTwo)
            case 2:
                onPageChange?(.tabThree)
            default:
                break
            }
        }
    }
}
