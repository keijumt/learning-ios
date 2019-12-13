//
//  SegmentedViewController.swift
//  Learning-iOS
//
//  Created by matsumoto-keiju on 2019/12/13.
//

import UIKit

class SegmentedViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    private let page = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    private lazy var pages: [UIViewController] = {
        return [
            ExamplePage1ViewController(nibName: "ExamplePage1ViewController", bundle: nil),
            ExamplePage2ViewController(nibName: "ExamplePage2ViewController", bundle: nil)
        ]
    }()
    
    private var currentTabIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        page.dataSource = self
        page.delegate = self
        
        page.setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        
        addChild(page)
        containerView.addSubview(page.view)
        
        page.view.translatesAutoresizingMaskIntoConstraints = false
        guard let superview = page.view.superview else { return }
        
        page.view.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        page.view.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        page.view.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        page.view.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        page.didMove(toParent: self)
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let nextIndex = sender.selectedSegmentIndex
        let direction: UIPageViewController.NavigationDirection = currentTabIndex < nextIndex ? .forward: .reverse
        page.setViewControllers([pages[nextIndex]], direction: direction, animated: true) { [weak self] finished in
            guard finished else {
                return
            }
            self?.currentTabIndex = nextIndex
        }
    }
}

extension SegmentedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextIndex = indexPath.row
        let nextViewController = pages[nextIndex]
        let direction: UIPageViewController.NavigationDirection = currentTabIndex < nextIndex ? .forward: .reverse
        page.setViewControllers([nextViewController], direction: direction, animated: true) { [weak self] finished in
            guard finished else {
                return
            }
            self?.currentTabIndex = nextIndex
        }
    }
}

extension SegmentedViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else { return nil }
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
}

extension SegmentedViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else {
            return
        }
        
        guard let currentViewController = pages.first(where: {pageViewController.viewControllers?.first == $0}) else { return }
        guard let index = pages.firstIndex(of: currentViewController) else { return }
        
        segmentedControl.selectedSegmentIndex = index
        currentTabIndex = index
    }
}
