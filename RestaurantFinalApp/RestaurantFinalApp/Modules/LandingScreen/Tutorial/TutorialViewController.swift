//
//  TutorialViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 7.08.2021.
//

import UIKit
import PaperOnboarding
import Firebase

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
                           pageIcon: UIImage(named: "stores")!,
                           color: UIColor(red: 0.40, green: 0.56, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white,
                           descriptionColor: UIColor.white,
                           titleFont: TutorialViewController.titleFont,
                           descriptionFont: TutorialViewController.descriptionFont),
        
        OnboardingItemInfo(informationImage: UIImage(named: "page3" )! ,
                           title: "Recipes",
                           description: "We carefully verify all kitchens before add them into the app to serve you a delicious recipe!",
                           pageIcon: UIImage(named: "page3")!,
                           color: UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white,
                           descriptionColor: UIColor.white,
                           titleFont: TutorialViewController.titleFont ,
                           descriptionFont: TutorialViewController.descriptionFont ),
        
        OnboardingItemInfo(informationImage: UIImage(named: "page4")! ,
                           title: "Quality Service",
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
        
//        let recipe1 = RecipeModel(id: UUID().uuidString,
//                                  name: "Pesto Chicken",
//                                  imageURL: "https://www.aspicyperspective.com/wp-content/uploads/2014/04/pesto-chicken-5-256x256.jpg",
//                                  instruction: "1.Preheat oven to 400˚F (200˚C). \n2.Place chicken breast in a baking dish. Season chicken with salt and pepper, to taste. \n 3.Spread pesto on each chicken breast. \n4.Layer tomatoes on top of the chicken. \n5.Top with mozzarella cheese. \n 6.Bake for 40 minutes.",
//                                  ingredients: ["Pesto", "Chicken"]
//        )
//        
//        
//        let recipe2 = RecipeModel(id: UUID().uuidString,
//                                  name: "Butter Chicken",
//                                  imageURL: "https://www.aspicyperspective.com/wp-content/uploads/2014/04/pesto-chicken-5-256x256.jpg",
//                                  instruction: "1.In a medium bowl, mix all the marinade ingredients with some seasoning. Chop the chicken into bite-sized pieces and toss with the marinade. Cover and chill in the fridge for 1 hr or overnight.\n 2.In a large, heavy saucepan, heat the oil. Add the onion, garlic, green chilli, ginger and some seasoning. Fry on a medium heat for 10 mins or until soft. \n 3.Add the spices with the tomato purée, cook for a further 2 mins until fragrant, then add the stock and marinated chicken. Cook for 15 mins, then add any remaining marinade left in the bowl. Simmer for 5 mins, then sprinkle with the toasted almonds. Serve with rice, naan bread, chutney, coriander and lime wedges, if you like.",
//                                  ingredients: ["500g skinless boneless chicken thighs", """
//For the marinade: 1 lemon, juiced, 2 tsp ground cumin 2 tsp paprika, 1-2 tsp hot chilli powder, 200g natural yogurt
//                                                For the curry:
//                                                2 tbsp vegetable oil
//                                                1 large onion, chopped
//                                                3 garlic cloves, crushed
//                                                1 green chilli, deseeded and finely chopped (optional)
//                                                thumb-sized piece ginger, grated
//                                                1 tsp garam masala
//                                                2 tsp ground fenugreek
//                                                3 tbsp tomato purée
//                                                300ml chicken stock
//                                                50g flaked almonds, toasted
//"""])
//        
//        let recipe3 = RecipeModel(id: UUID().uuidString,
//                                  name: "Pesto Chicken",
//                                  imageURL: "https://www.aspicyperspective.com/wp-content/uploads/2014/04/pesto-chicken-5-256x256.jpg",
//                                  instruction: "1.Preheat oven to 400˚F (200˚C). \n2.Place chicken breast in a baking dish. Season chicken with salt and pepper, to taste. \n 3.Spread pesto on each chicken breast. \n4.Layer tomatoes on top of the chicken. \n5.Top with mozzarella cheese. \n 6.Bake for 40 minutes.",
//                                  ingredients: ["Pesto", "Chicken"])
//        
//        let recipe4 = RecipeModel(id: UUID().uuidString,
//                                  name: "Pesto Chicken",
//                                  imageURL: "https://www.aspicyperspective.com/wp-content/uploads/2014/04/pesto-chicken-5-256x256.jpg",
//                                  instruction: "1.Preheat oven to 400˚F (200˚C). \n2.Place chicken breast in a baking dish. Season chicken with salt and pepper, to taste. \n 3.Spread pesto on each chicken breast. \n4.Layer tomatoes on top of the chicken. \n5.Top with mozzarella cheese. \n 6.Bake for 40 minutes.",
//                                  ingredients: ["Pesto", "Chicken"])
//        
//        let recipe5 = RecipeModel(id: UUID().uuidString,
//                                  name: "Pesto Chicken",
//                                  imageURL: "https://www.aspicyperspective.com/wp-content/uploads/2014/04/pesto-chicken-5-256x256.jpg",
//                                  instruction: "1.Preheat oven to 400˚F (200˚C). \n2.Place chicken breast in a baking dish. Season chicken with salt and pepper, to taste. \n 3.Spread pesto on each chicken breast. \n4.Layer tomatoes on top of the chicken. \n5.Top with mozzarella cheese. \n 6.Bake for 40 minutes.",
//                                  ingredients: ["Pesto", "Chicken"])
//                
//        
//        let kitchen1 = KitchenModel(id: UUID().uuidString, name: "Burger Store", imageURL: "", location: "", recipes: [recipe1.id : recipe1.dictionary], descriptions: ["Burger", "Pasta", "Chickin"], avarageDeliveryTime: "30 - 40 Mins", rating: 4.4, ratingCount: 30)
//        
//        let kitchen2 = KitchenModel(id: UUID().uuidString, name: "Elche", imageURL: "", location: "", recipes: [recipe2.id:recipe2.dictionary], descriptions: ["Burger", "Pasta", "Chicken"], avarageDeliveryTime: "10 - 20 Mins", rating: 4.4, ratingCount: 30)
//        
//        let kitchen3 = KitchenModel(id: UUID().uuidString, name: "Casa Ràfols", imageURL: "", location: "", recipes: [recipe3.id:recipe3.dictionary], descriptions: ["Burger", "Pasta", "Chicken"], avarageDeliveryTime: "20 - 40 Mins", rating: 4.4, ratingCount: 30)
//        
//        let kitchen4 = KitchenModel(id: UUID().uuidString, name: "Orient Express", imageURL: "", location: "", recipes: [recipe4.id:recipe4.dictionary], descriptions: ["Burger", "Pasta", "Chicken"], avarageDeliveryTime: "30 - 40 Mins", rating: 4.4, ratingCount: 30)
//        
//        let kitchen5 = KitchenModel(id: UUID().uuidString, name: "Navarro", imageURL: "", location: "", recipes: [recipe5.id:recipe5.dictionary], descriptions: ["Burger", "Pasta", "Chicken"], avarageDeliveryTime: "10 - 25 Mins", rating: 4.4, ratingCount: 30)
//        
//        var kitchens: [String:Any] = [:]
//        kitchens[kitchen1.id] = kitchen1.dictionary
//        kitchens[kitchen2.id] = kitchen2.dictionary
//        kitchens[kitchen3.id] = kitchen3.dictionary
//        kitchens[kitchen4.id] = kitchen4.dictionary
//        kitchens[kitchen5.id] = kitchen5.dictionary
//        
//        // favoriye yada locationa göre sort olabilirler..
//        FirebaseEndpoints.kitchens.getDatabasePath.setValue(kitchens)
//        
//        
//        let user1 = UserModel(id: UUID().uuidString, name: "Oliver Sunrise", recipes: [recipe1.id:recipe1.dictionary, recipe2.id:recipe2.dictionary], location: "")
//        
//        var user: [String:Any] = [:]
//        user[user1.id] = user1.dictionary
//        FirebaseEndpoints.users.getDatabasePath.setValue(user)
        
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
        return 20
    }
    func onboardingPageItemColor(at index: Int) -> UIColor {
        return [UIColor.white, UIColor.white, UIColor.white][index]
    }
}


//MARK: Constants
private extension TutorialViewController {
    
    static let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
    static let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
}

