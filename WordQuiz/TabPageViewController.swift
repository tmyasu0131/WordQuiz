//
//  TabPageViewController.swift
//  WordQuiz
//
//  Created by yasu on 2020/05/18.
//  Copyright © 2020 tmyasu. All rights reserved.
//

import UIKit

// TabPageViewController.swift

class TabPageViewController: UIPageViewController {
    
    var pageViewControllers: [UIViewController] = []
    var pageTabItems: [String] = []
    
    private var beforeIndex: Int = 0
    private var currentIndex: Int? {
        guard let viewController = viewControllers?.first else {
            return nil
        }
    return pageViewControllers.indexOf(viewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初期化処理など
        
        dataSource = self as? UIPageViewControllerDataSource
        delegate = self as? UIPageViewControllerDelegate
        
        setViewControllers(
            [pageViewControllers[0]],
            direction: .forward,
            animated: false,
            completion: nil)
        
        let tabView = TabView()
        tabView.translatesAutoresizingMaskIntoConstraints = false
        
        let height = NSLayoutConstraint(item: tabView,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .Height,
            multiplier: 1.0,
            constant: TabView.tabViewHeight)
        
        tabView.addConstraint(height)
        view.addSubview(tabView)
        
        let top = NSLayoutConstraint(item: tabView,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: topLayoutGuide,
            attribute: .Bottom,
            multiplier:1.0,
            constant: 0.0)
        
        let left = NSLayoutConstraint(item: tabView,
            attribute: .Leading,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Leading,
            multiplier: 1.0,
            constant: 0.0)
        
        let right = NSLayoutConstraint(item: view,
            attribute: .Trailing,
            relatedBy: .Equal,
            toItem: tabView,
            attribute: .Trailing,
            multiplier: 1.0,
            constant: 0.0)
        
        view.addConstraints([top, left, right])
        
        tabView.pageTabItems = pageTabItems
    }
}


// MARK: - UIPageViewControllerDataSource

extension InfinityTabPageViewController: UIPageViewControllerDataSource {
    
    private func nextViewController(viewController: UIViewController, isAfter: Bool) -> UIViewController? {
        guard var index = pageViewControllers.indexOf(viewController) else {
            return nil
        }
        
        if isAfter {
            index++
        } else {
            index--
        }
        
        if index < 0 {
            index = pageViewControllers.count - 1
        } else if index == pageViewControllers.count {
            index = 0
        }
        
        if index >= 0 && index < pageViewControllers.count {
            return pageViewControllers[index]
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController, isAfter: true)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController, isAfter: false)
    }
}
