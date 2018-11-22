//
//  PageViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 11/22/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    lazy var pages: [UIViewController] = {
        return [self.newVc(viewController: "Welcome"),
                self.newVc(viewController: "Permission")]
    }()
    
    var pageControl = UIPageControl()
    var nextButton = UIButton()
    var backButton = UIButton()
    
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        configurePageControl()
        
        self.dataSource = self
        self.delegate = self
        if let firstViewController = pages.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: false,
                               completion: nil)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func setUpView() {
        self.view.backgroundColor = UIColor.GameColors.backgroudColor
        
        nextButton = UIButton(frame: CGRect(x: 0,
                                            y: UIScreen.main.bounds.maxY - 130,
                                            width: UIScreen.main.bounds.maxX - 40,
                                            height: 50))
        
        self.nextButton.center.x = self.view.frame.size.width / 2
        self.nextButton.backgroundColor = UIColor.GameColors.lightBule
        self.nextButton.setTitle("Next", for: .normal)
        self.nextButton.layer.cornerRadius = 8
        self.nextButton.addTarget(self, action: #selector(nextButtonTap), for: .touchUpInside)
        self.view.addSubview(nextButton)
        
        backButton = UIButton(frame: CGRect(x: 0,
                                            y: UIScreen.main.bounds.maxY - 80,
                                            width: UIScreen.main.bounds.maxX - 40,
                                            height: 50))
        self.backButton.center.x = self.view.frame.size.width / 2
        self.backButton.setTitle("", for: .normal)
        self.backButton.setTitleColor(UIColor.GameColors.lightOrage, for: .normal)
        self.backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        self.view.addSubview(backButton)
    }
    
    
    @objc func nextButtonTap (sender: UIButton!) {
        let pageContentViewController = self.viewControllers![0]
        if let page = pages.index(of: pageContentViewController) {
            switch page {
            case 0:
                self.setViewControllers([self.pages[1]],
                                        direction: .forward,
                                        animated: true,
                                        completion: nil)
                checkPageView()
            case 1:
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationViewController") as! NavigationViewController
                self.present(vc, animated: true, completion: nil)
                checkPageView()
            default:
                break
            }
        }
    }
    
    @objc func backButtonTap (sender: UIButton!) {
        let pageContentViewController = self.viewControllers![0]
        if let page = pages.index(of: pageContentViewController) {
            switch page {
            case 1:
                self.setViewControllers([self.pages[0]],
                                        direction: .reverse,
                                        animated: true,
                                        completion: nil)
                checkPageView()
            default:
                break
            }
        }
    }
    
    
    
    func checkPageView() {
        let pageContentViewController = self.viewControllers![0]
        if let page = pages.index(of: pageContentViewController) {
            switch page {
            case 0:
                nextButton.setTitle("Next", for: .normal)
                backButton.setTitle("", for: .normal)
                pageControl.currentPage = 0
            case 1:
                nextButton.setTitle("Start Game", for: .normal)
                backButton.setTitle("Back", for: .normal)
                pageControl.currentPage = 1
            default:
                nextButton.setTitle("Next", for: .normal)
                backButton.setTitle("Back", for: .normal)
            }
        }
    }
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0,
                                                  y: UIScreen.main.bounds.maxY - 50,
                                                  width: UIScreen.main.bounds.width,
                                                  height: 50))
        
        self.pageControl.numberOfPages = pages.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.GameColors.lightBule
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.GameColors.lightBule
        self.pageControl.isUserInteractionEnabled = false
        self.view.addSubview(pageControl)
    }
}



extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        checkPageView()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard pages.count > previousIndex else {
            return nil
        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let pagesViewControllersCount = pages.count
        
        guard pagesViewControllersCount != nextIndex else {
            return nil
        }
        
        guard pagesViewControllersCount > nextIndex else {
            return nil
        }
        
        return pages[nextIndex]
    }
    
    
}
