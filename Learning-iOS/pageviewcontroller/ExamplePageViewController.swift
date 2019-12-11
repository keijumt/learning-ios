//
//  ExamplePageViewController.swift
//  Learning-iOS
//
//  Created by matsumoto-keiju on 2019/12/09.
//

import UIKit

class ExamplePageViewController: UIViewController {
    
    private let page = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    private lazy var pages: [UIViewController] = {
        return [
            ExamplePage1ViewController(nibName: "ExamplePage1ViewController", bundle: nil),
            ExamplePage2ViewController(nibName: "ExamplePage2ViewController", bundle: nil)
        ]
    }()
    
    private var currentTabIndex = 0
    
    @IBOutlet weak var tabBarCollectionView: UICollectionView! {
        didSet {
            tabBarCollectionView.showsHorizontalScrollIndicator = false
            tabBarCollectionView.showsVerticalScrollIndicator = false
        }
    }
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarCollectionView.register(UINib(nibName: "ExamplePageTabCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TabBarCell")
        tabBarCollectionView.dataSource = self
        tabBarCollectionView.delegate = self
        
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
        
        tabBarCollectionView.reloadData()
        updateLayout()
    }
    
    private func updateLayout() {
        let flowLayout = tabBarCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemSize = CGSize(width: tabBarCollectionView.bounds.width / CGFloat(pages.count), height: tabBarCollectionView.bounds.height)
        flowLayout.itemSize = itemSize
        flowLayout.sectionInset = .zero
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        tabBarCollectionView.collectionViewLayout = flowLayout
    }
}

extension ExamplePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tabBarCollectionView.dequeueReusableCell(withReuseIdentifier: "TabBarCell", for: indexPath)
        if indexPath.row == currentTabIndex {
            cell.backgroundColor = .red
        } else {
            cell.backgroundColor = .systemBackground
        }
        return cell
    }
}

extension ExamplePageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextIndex = indexPath.row
        let nextViewController = pages[nextIndex]
        let direction: UIPageViewController.NavigationDirection = currentTabIndex < nextIndex ? .forward: .reverse
        page.setViewControllers([nextViewController], direction: direction, animated: true) { [weak self] finished in
            guard finished else {
                return
            }
            self?.currentTabIndex = nextIndex
            self?.tabBarCollectionView.reloadData()
        }
    }
}

extension ExamplePageViewController: UIPageViewControllerDataSource {
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

extension ExamplePageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        print(completed)
        guard completed else {
            return
        }
        
        guard let currentViewController = pages.first(where: {pageViewController.viewControllers?.first == $0}) else { return }
        guard let index = pages.firstIndex(of: currentViewController) else { return }
        currentTabIndex = index
        tabBarCollectionView.reloadData()
    }
}
