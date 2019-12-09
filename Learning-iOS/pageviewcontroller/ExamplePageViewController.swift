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
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        page.dataSource = self
        
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
