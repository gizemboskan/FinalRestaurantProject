//
//  KitchenPageViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 10.08.2021.
//

import UIKit

class KitchenPageViewController: UIPageViewController {
    // MARK: - Properties
    
    fileprivate var items: [UIViewController] = []
    
    private var currentIndex: Int?
    var index = 0
    var counter = 0
    private var pictureSource: [String]?
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        decoratePageControl()
        
        //        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goDetail(_:))))
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
    }
    // MARK: - Helpers
    
    func populateItems(pictureSource: [String]) {
        self.items.removeAll()
        self.pictureSource = pictureSource
        for picture in pictureSource {
            let vc = UIViewController()
            let pictureView = UIImageView(frame: view.frame)
            vc.view.addSubview(pictureView)
            pictureView.image = UIImage(named: picture)
            items.append(vc)
        }
        
        if let firstViewController = items.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    @objc func changeImage(){
        goToNextPage()
    }
    
    func goToNextPage() {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let nextViewController = dataSource?.pageViewController( self, viewControllerAfter: currentViewController ) else { return }
        setViewControllers([nextViewController], direction: .forward, animated: false, completion: nil)
    }
    
    fileprivate func decoratePageControl() {
        let pc = UIPageControl.appearance(whenContainedInInstancesOf: [KitchenPageViewController.self])
        pc.currentPageIndicatorTintColor = .orange
        pc.pageIndicatorTintColor = .gray
    }
    
    //    @objc func goDetail(_ gesture: UITapGestureRecognizer) {
    //        if let vc = storyboard?.instantiateViewController(withIdentifier: "KitchenDetailViewController") as? KitchenDetailViewController,
    //           let currentIndex = self.currentIndex,
    //           let kitchenSource = self.kitchenSource {
    //            vc.kitchen = kitchenSource[currentIndex]
    //            navigationController?.pushViewController(vc, animated: true)
    //        }
    //    }
}

// MARK: - DataSource
extension KitchenPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func presentationCount(for _: UIPageViewController) -> Int {
        return items.count
    }
    
    func presentationIndex(for _: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
              let firstViewControllerIndex = items.firstIndex(of: firstViewController) else {
            return 0
        }
        
        return firstViewControllerIndex
    }
    
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return items.last
        }
        
        guard items.count > previousIndex else {
            return nil
        }
        
        return items[previousIndex]
    }
    
    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard items.count != nextIndex else {
            return items.first
        }
        
        guard items.count > nextIndex else {
            return nil
        }
        
        return items[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currentViewController = pageViewController.viewControllers?.first,
               let index = items.firstIndex(of: currentViewController) {
                currentIndex = index
            }
        }
    }
}
