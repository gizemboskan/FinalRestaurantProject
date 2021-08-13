//
//  TutorialViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 7.08.2021.
//

import UIKit
import PaperOnboarding

class TutorialViewController: UIViewController {
    
    let vievModel: TutorialViewModel = TutorialViewModel()
    
    @IBOutlet var paperView: PaperOnboarding!
    @IBOutlet var skipButton: UIButton!
    
    //     fileprivate let items = [
    //         OnboardingItemInfo(informationImage: Asset.hotels.image,
    //                            title: "Hotels",
    //                            description: "All hotels and hostels are sorted by hospitality rating",
    //                            pageIcon: Asset.key.image,
    //                            color: UIColor(red: 0.40, green: 0.56, blue: 0.71, alpha: 1.00),
    //                            titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
    //
    //
    // OnboardingItemInfo(informationImage: Asset.banks.image,
    //                            title: "Banks",
    //                            description: "We carefully verify all banks before add them into the app",
    //                            pageIcon: Asset.wallet.image,
    //                            color: UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1.00),
    //                            titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
    //
    //         OnboardingItemInfo(informationImage: Asset.stores.image,
    //                            title: "Stores",
    //                            description: "All local stores are categorized for your convenience",
    //                            pageIcon: Asset.shoppingCart.image,
    //                            color: UIColor(red: 0.61, green: 0.56, blue: 0.74, alpha: 1.00),
    //                            titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
    //
    //         ]
    fileprivate let items = [
        OnboardingItemInfo(informationImage: UIImage(named: "stores" )! ,
                           title: "Kitchens",
                           description: "All local kitchens are categorized for your convenience",
                           pageIcon: UIImage(named: "stores" )!,
                           color: UIColor(red: 0.40, green: 0.56, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white,
                           descriptionColor: UIColor.white,
                           titleFont: TutorialViewController.titleFont,
                           descriptionFont: TutorialViewController.descriptionFont),
        
        OnboardingItemInfo(informationImage: UIImage(named: "page3" )! ,
                           title: "title",
                           description: "We carefully verify all kitchens before add them into the app to serve you a delicious recipe!",
                           pageIcon: UIImage(named: "page3" )!,
                           color: UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white,
                           descriptionColor: UIColor.white,
                           titleFont: TutorialViewController.titleFont ,
                           descriptionFont: TutorialViewController.descriptionFont ),
        
        OnboardingItemInfo(informationImage: UIImage(named: "page4" )! ,
                           title: "title",
                           description: "We carefully deliver your meal under safe conditions",
                           pageIcon: UIImage(named: "page4" )!,
                           color: UIColor(red: 0.61, green: 0.56, blue: 0.74, alpha: 1.00),
                           titleColor: UIColor.white,
                           descriptionColor: UIColor.white,
                           titleFont: TutorialViewController.titleFont ,
                           descriptionFont: TutorialViewController.descriptionFont)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skipButton.isHidden = true
        
        setupPaperOnboardingView()
        
        view.bringSubviewToFront(skipButton)
    }
    
    private func setupPaperOnboardingView() {
        
        paperView.delegate = self
        paperView.dataSource = self
    }
}


// MARK: Actions
extension TutorialViewController {
    
    @IBAction func skipButtonTapped(_: UIButton) {
        let window = UIApplication.shared.windows.first
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RAMAnimatedTabBarController")
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}

// MARK: PaperOnboardingDelegate
extension TutorialViewController: PaperOnboardingDelegate {
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        skipButton.isHidden = index == 2 ? false : true
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
        //item.titleCenterConstraint?.constant = 100
        //item.descriptionCenterConstraint?.constant = 100
        
        // configure item
        
        //item.titleLabel?.backgroundColor = .redColor()
        //item.descriptionLabel?.backgroundColor = .redColor()
        //item.imageView = ...
    }
}

// MARK: PaperOnboardingDataSource
extension TutorialViewController: PaperOnboardingDataSource {
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
        func onboardinPageItemRadius() -> CGFloat {
            return 2
        }
    
        func onboardingPageItemSelectedRadius() -> CGFloat {
            return 10
        }
        func onboardingPageItemColor(at index: Int) -> UIColor {
            return [UIColor.white, UIColor.red, UIColor.green][index]
        }
}


//MARK: Constants
private extension TutorialViewController {
    
    static let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
    static let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
}

