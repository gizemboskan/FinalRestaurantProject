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
        
    //    createMockData()
        
    }
    
    private func setupPaperOnboardingView() {
        
        paperView.delegate = self
        paperView.dataSource = self
    }
    
    private func createMockData() {
        let recipe1 = RecipeModel(id: UUID().uuidString,
                                  name: "Pesto Chicken",
                                  
                                  imageURL: "https://cafedelites.com/wp-content/uploads/2016/07/chicken-pesto-recipe-9.jpg",
                                  instruction: "1.Preheat oven to 400˚F (200˚C). \n2.Place chicken breast in a baking dish. Season chicken with salt and pepper, to taste. \n3.Spread pesto on each chicken breast. \n4.Layer tomatoes on top of the chicken. \n5.Top with mozzarella cheese. \n6.Bake for 40 minutes.",
                                  ingredients: ["3 chicken breasts", "salt to,taste", "pepper to taste","4 tablespoons basil pesto", "1 roma tomato sliced", "1 cup mozzarella cheese (120 g)"]
        )
        
        let recipe2 = RecipeModel(id: UUID().uuidString,
                                  name: "Butter Chicken",
                                  imageURL: "https://cafedelites.com/wp-content/uploads/2019/01/Butter-Chicken-IMAGE-27.jpg",
                                  instruction: "1.In a medium bowl, mix all the marinade ingredients with some seasoning. Chop the chicken into bite-sized pieces and toss with the marinade. Cover and chill in the fridge for 1 hr or overnight.\n2.In a large, heavy saucepan, heat the oil. Add the onion, garlic, green chilli, ginger and some seasoning. Fry on a medium heat for 10 mins or until soft.\n3.Add the spices with the tomato purée, cook for a further 2 mins until fragrant, then add the stock and marinated chicken. Cook for 15 mins, then add any remaining marinade left in the bowl. Simmer for 5 mins, then sprinkle with the toasted almonds. Serve with rice, naan bread, chutney, coriander and lime wedges, if you like.",
                                  ingredients: ["500g skinless boneless chicken thighs", "For the marinade: 1 lemon, juiced, 2 tsp ground cumin 2 tsp paprika, 1-2 tsp hot chilli powder, 200g natural yogurt", " For the curry: 2 tbsp vegetable oil, 1 large onion chopped,3 garlic cloves crushed,1 green chilli, thumb-sized piece ginger grated, 1 tsp garam masala, 2 tsp ground fenugreek,3 tbsp tomato purée,300ml chicken stock,  50g flaked almonds toasted "])
        
        let recipe3 = RecipeModel(id: UUID().uuidString,
                                  name: "Chicken Cacciatore",
                                  imageURL: "https://cafedelites.com/wp-content/uploads/2018/04/Chicken-Cacciatore-IMAGE-12.jpg",
                                  instruction: """
        Season the chicken breasts on both sides with salt and pepper.
                                  Heat 1 tablespoon of the oil in a large nonstick skillet over medium high heat.
                                  Place 4 pieces of the chicken in the skillet and sear until until golden-brown, about 1-3 minutes on each side. Transfer the chicken to a plate and repeat searing with the remaining chicken pieces. Set aside.
                                  Heat 1 tablespoon of oil in the empty skillet.
                                  Add the mushrooms and stir occasionally until most of the moisture has evaporated from the pan, about 8 minutes.
                                  Transfer the mushrooms to a plate and set aside.
                                  Heat the remaining 1 tablespoon of oil in the pan.
                                  Add the onions and bell peppers and season with salt and pepper. Stir occasionally until the onions and peppers have softened, about 2 minutes.
                                  Add in the garlic and rosemary and stir until the garlic is fragrant.
                                  Add in the tomatoes, red wine, and broth and stir until the sauce has thickened slightly.
                                  Add the mushrooms and chicken back into the sauce and bring to a low simmer.
                                  Cover and let cook until the chicken registers 165°F (74°C), about 5-8 minutes.
                                  Serve topped with basil.
        """,
                                  ingredients: ["4 boneless, skinless chicken breasts, cut in half, widthwise", "salt, to taste", "pepper, to taste","3 tablespoons oil, divided", "1 lb portobello mushroom (455 g), diced", "1 large white onion, diced", "1 large red bell pepper, diced", "4 cloves garlic, minced","2 teaspoons fresh rosemary, minced", "14.5 oz diced tomato (410 g), 1 can", "½ cup red wine (120 mL)", "¾ cup low sodium chicken broth (180 mL), or vegetable broth", "fresh basil, chopped, to serve"])
        
        let recipe4 = RecipeModel(id: UUID().uuidString,
                                  name: "Pecan Pie",
                                  imageURL: "https://cafedelites.com/wp-content/uploads/2018/11/Chocolate-Pecan-Pie-IMAGE-29-1536x1024.jpg",
                                  instruction: """
                                    Make the crust: Sift the flour and salt together into a large bowl.
                                  Using only your fingertips, pinch the cubes of butter into the flour, breaking up the butter as you go, until no large lumps remain. Shake the bowl to coax the large chunks of butter to the surface.
                                  Mix the egg yolks and ice water together in a small bowl with a fork until evenly combined.
                                  Add the liquid to the flour mixture, reserving ¼ or so in case you don’t need all of it--you don’t want the pastry to be too wet. Quickly mix everything together with a fork until the dough just starts to come together. Add more liquid to the driest parts of the dough if needed. The dough is ready when it holds together in a ball when squeezed in your palm.
                                  Transfer the dough to a clean surface and bring together in a disc. Wrap the dough disc in plastic wrap and chill in the refrigerator for at least 30 minutes, or up to 4 days.
                                  Preheat the oven to 350°F (180°C).
                                  Lightly flour a clean surface and unwrap the disc of chilled dough. Flour the top of the dough. Start to roll out the dough, turning every few rolls.. If any cracks form, smush them back together. Roll out the dough to a circle about ⅛-inch (3 mm) thick and place into a 9-inch (22 cm) pie dish. Trim any excess dough around the sides, then crimp the edges in a decorative pattern.
                                  Place a piece of parchment in the center of the pie crust and add the pie weights or dried beans. 9. Bake for 15 minutes, until lightly golden brown.
                                  Make the filling: In a large bowl, whisk together 1½ cups (185 G) pecans, corn syrup, eggs, sugar, vanilla, melted butter, and salt.
                                  Carefully lift the parchment with the pie weights from the par-baked pie crust, then pour in the filling. Arrange the remaining ½ cup (62 G) pecans in concentric circles on top.
                                  Return the pie to the oven for 20 minutes, then cover with a piece of foil and continue baking for 40 minutes, until the filling is completely set. Let the pie cool completely.
                                  Slice and serve the pie chilled or at room temperature.
                                  """,
                                  ingredients: ["2 and 1/2 cups (250g) shelled pecans (pecan halves)", "3 large eggs.","1 cup (240ml) dark corn syrup", "1/2 cup (100g) packed light or dark brown sugar.", "1 and 1/2 teaspoons pure vanilla extract.", "1/4 cup (60g) unsalted butter, melted and slightly cooled.", "1/2 teaspoon salt.", " 1/2 teaspoon ground cinnamon."])
        
        
        
        let recipe5 = RecipeModel(id: UUID().uuidString,
                                  name: "Lasagna Flatbread",
                                  imageURL: "https://cafedelites.com/wp-content/uploads/2018/01/Mamas-Best-Lasagna-IMAGE-96-1365x2048.jpg",
                                  instruction: "1.Preheat oven to 375 degrees F (190 degrees C).\n2.Combine ricotta cheese, 1/2 of the mozzarella cheese, Parmesan cheese, egg, and Italian seasoning in a bowl.\n3.Cook sausage in a skillet over medium heat until no longer pink, 5 to 10 minutes; drain. Stir in marinara sauce. \n4.Spread 1/6 of the cheese mixture evenly on each flatbread; cover with sausage mixture. Top with remaining mozzarella cheese.\n5.Bake in the preheated oven until cheese is melted and bubbly, 10 to 15 minutes.",
                                  ingredients: ["15 ounce ricotta cheese", "8 ounce  shredded mozzarella cheese, divided", "3 ounce Parmesan cheese", "1 egg", "2 teaspoons Italian seasoning", "1 pound sausage", "26 ounce marinara sauce", "6 flatbreads"])
        
        let recipe6 = RecipeModel(id: UUID().uuidString,
                                  name: "Shrimp Fra Diavolo",
                                  imageURL: "https://cafedelites.com/wp-content/uploads/2015/01/Creamy-Shrimp-Mushroom-Linguine-IMAGE-4.jpg",
                                  instruction: "1.Peel and cook shrimp if necessary, and place in a bowl of cold water.\n2.Place tomatoes, crushed garlic, red pepper flakes, and wine in a 3 quart sauce pan. Simmer over low heat for 30 minutes, stirring occasionally.\n3.While sauce is simmering, cook linguini according to package directions. When pasta is almost done, drain shrimp and place in the bottom of a large colander. Drain the pasta over the shrimp. Transfer pasta with shrimp to a large serving bowl, and toss together with some sauce. Serve remaining sauce on the side." ,
                                  ingredients: ["16 ounce linguini pasta", "1 pound cooked and peeled shrimp", "8 cloves crushed garlic", "14.5 ounce cans diced tomatoes", "28 ounce) can crushed tomatoes with garlic", "2 teaspoons crushed red pepper flakes", "2 fluid ounces red wine"])
        
        let recipe7 = RecipeModel(id: UUID().uuidString,
                                  name: "Blueberry Pie",
                                  imageURL: "https://thebusybaker.ca/wp-content/uploads/2020/07/classic-blueberry-pie-fb-ig-8-scaled.jpg",
                                  instruction: "1.Preheat oven to 375 degrees F (190 degrees C).\n2.Mix sugar, cornstarch, salt, and cinnamon, and sprinkle over blueberries.\n3.Line pie dish with one pie crust. Pour berry mixture into the crust, and dot with butter. Cut remaining pastry into 1/2 - 3/4 inch wide strips, and make lattice top. Crimp and flute edges. \n4.Bake pie on lower shelf of oven for about 50 minutes, or until crust is golden brown.",
                                  ingredients: ["¾ cup white sugar", "3 tablespoons cornstarch", "¼ teaspoon salt", "½ teaspoon ground cinnamon", "4 cups fresh blueberries", "1 recipe pastry for a 9 inch double crust pie", "1 tablespoon butter"])
        
        
        
        let recipe8 = RecipeModel(id: UUID().uuidString,
                                  name: "Triple Berry Crisp",
                                  imageURL: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F828183.jpg",
                                  instruction: "1.Preheat oven to 350 degrees F (175 degrees C).\n2.In a large bowl, gently toss together blackberries, raspberries, blueberries, and white sugar; set aside.\n3.In a separate large bowl, combine flour, oats, brown sugar, cinnamon, and nutmeg. Cut in butter until crumbly. Press half of mixture in the bottom of a 9x13 inch pan. Cover with berries. Sprinkle remaining crumble mixture over the berries. \n4.Bake in the preheated oven for 30 to 40 minutes, or until fruit is bubbly and topping is golden brown.",
                                  ingredients: ["1 ½ cups fresh blackberries", "1 ½ cups fresh raspberries", "1 ½ cups fresh blueberries", "4 tablespoons white sugar", "2 cups all-purpose flour", "2 cups rolled oats", "1 ½ cups packed brown sugar", "1 teaspoon ground cinnamon", "½ teaspoon ground nutmeg", "1 ½ cups butter"])
        
        let recipe9 = RecipeModel(id: UUID().uuidString,
                                  name: "Meatloaf",
                                  imageURL: "https://cafedelites.com/wp-content/uploads/2018/05/Perfect-Meatloaf-IMAGE-59-1365x2048.jpg",
                                  instruction: "1.Preheat oven to 350 degrees F (175 degrees C).\n2.In a large bowl, combine the beef, egg, onion, milk and bread OR cracker crumbs. Season with salt and pepper to taste and place in a lightly greased 9x5-inch loaf pan, or form into a loaf and place in a lightly greased 9x13-inch baking dish.\n3.In a separate small bowl, combine the brown sugar, mustard and ketchup. Mix well and pour over the meatloaf. \n4.Bake at 350 degrees F (175 degrees C) for 1 hour.",
                                  ingredients: ["1 ½ pounds ground beef", "1 egg", "1 onion, chopped", "1 cup milk", "1 cup dried bread crumbs", "salt and pepper to taste", "2 tablespoons brown sugar", "2 tablespoons prepared mustard", "⅓ cup ketchup"])
        
        let recipe10 = RecipeModel(id: UUID().uuidString,
                                   name: "Barbeque Shrimp",
                                   imageURL: "https://cafedelites.com/wp-content/uploads/2018/05/Honey-Garlic-Butter-Shrimp-IMAGE-99-1365x2048.jpg",
                                   instruction: "1.In a small bowl, stir together the garlic powder, onion powder, basil, thyme, rosemary, cayenne pepper and paprika. Set aside. \n2.Melt the butter in a large skillet over medium heat. Add garlic; cook and stir until fragrant, about 1 minute. Add the shrimp and cook for a couple of minutes. Season with the spice mixture and continue to cook and stir for a few minutes. Pour in the beer and Worcestershire sauce; simmer until shrimp is cooked through, about 1 more minute. Taste and season with salt before serving.",
                                   ingredients: ["1 teaspoon garlic powder", "1 teaspoon onion powder", "1 teaspoon dried basil", "½ teaspoon dried thyme", "½ teaspoon dried rosemary", "¼ teaspoon cayenne pepper", "⅓ teaspoon paprika", "½ cup butter", "4 cloves garlic, minced", "¼ cup beer, room temperature", "1 tablespoon Worcestershire sauce", "1 pound medium shrimp - peeled and deveined", "salt to taste"])
        
        let recipe11 = RecipeModel(id: UUID().uuidString,
                                   name: "Balsamic-Roasted Pumpkin with Goat Cheese",
                                   imageURL: "https://img.taste.com.au/5mHGGHMj/w643-h428-cfill-q90/taste/2017/03/pumpkin-wedges-with-goats-cheese-1980x1320-124908-1.jpg",
                                   instruction: "1.Preheat the oven to 375 degrees F (190 degrees C). Line a large baking sheet with parchment paper.\n2.Place pumpkin onto a secure cutting board. Cut the top and bottom off the pumpkin, removing as much of the stem as possible. Use a sharp vegetable peeler or a paring knife to remove the pumpkin peel. Cut pumpkin in half, and use a spoon to scoop out seeds and strings. Trim away any pieces of stem that may remain. Cut each pumpkin half into 1/2-inch strips. Chop each strip into 1/2-inch cubes. Place cubed pumpkin into a large bowl. \n3.Mix balsamic vinegar, maple syrup, olive oil, garlic powder, onion powder, salt, and pepper together in a small bowl until thoroughly combined. Pour over pumpkin pieces and toss to thoroughly coat. Pour pumpkin into an even layer on the prepared baking sheet. \n4.Bake in the preheated oven for 20 minutes. Stir gently, then continue baking until pumpkin is softened and slightly caramelized, 25 to 30 minutes more, stirring again if needed. Serve pumpkin warm, topped with goat cheese and fresh oregano.",
                                   ingredients: ["3 pound sugar pumpkin", "¼ cup balsamic vinegar", "2 tablespoons maple syrup, or to taste", "2 tablespoons olive oil", "1 teaspoon garlic powder", "1 teaspoon onion powder", "½ teaspoon kosher salt, or to taste", "¼ teaspoon freshly ground black pepper, or to taste", "2 ounces crumbled goat cheese, or to taste", "1 tablespoon chopped fresh oregano"])
        
        let kitchen1 = KitchenModel(id: UUID().uuidString, name: "Arco Tapas Bar", imageURL: "https://images.squarespace-cdn.com/content/v1/538acfa1e4b01f1c805e1329/1613598775068-Z4Y3LKMYU9QOR1ER5XHZ/junzi+family+meal_Photography+by+Mischelle+Moy_s.jpeg?format=2500w", locationString: "", recipes: [recipe1.id : recipe1.dictionary, recipe2.id : recipe2.dictionary,recipe3.id : recipe3.dictionary,recipe6.id : recipe6.dictionary], descriptions: ["Burger", "Pasta", "Chicken", "Traditional", "Spice", "Tapas"], avarageDeliveryTime: "30 - 40 Mins", rating: 4.9, ratingCount: 1203, latitude: 38.421117, longitude: 27.130687)
        
        let kitchen2 = KitchenModel(id: UUID().uuidString, name: "Elche", imageURL: "https://simonsheart.org/wp-content/uploads/2020/03/dining.jpg", locationString: "konak", recipes: [recipe1.id : recipe1.dictionary, recipe2.id : recipe2.dictionary,recipe3.id : recipe3.dictionary,recipe6.id : recipe6.dictionary,recipe7.id : recipe7.dictionary], descriptions: ["Burger", "Pasta", "Chicken"], avarageDeliveryTime: "10 - 20 Mins", rating: 4.3, ratingCount: 302,latitude: 38.419847, longitude: 27.128663)
        
        let kitchen3 = KitchenModel(id: UUID().uuidString, name: "Casa Ràfols", imageURL: "https://cdn.pixabay.com/photo/2020/11/14/10/49/food-5741259_960_720.jpg", locationString: "", recipes: [recipe8.id : recipe8.dictionary, recipe9.id : recipe9.dictionary,recipe3.id : recipe3.dictionary,recipe1.id : recipe1.dictionary,recipe6.id : recipe6.dictionary,recipe7.id : recipe7.dictionary], descriptions: ["Handmade-Burger", "Ramen", "Chicken", "Beef", "Fresh Fruits", "Ice Cream", "Cakes"], avarageDeliveryTime: "20 - 40 Mins", rating: 4.6, ratingCount: 340,latitude: 38.414988, longitude: 27.126888)
        
        let kitchen4 = KitchenModel(id: UUID().uuidString, name: "Orient Express", imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbvUU7g3Yko3bjMZmvS00IwQVlQRe3n_DwVqrUeLx9BJ_PLWO_a9zXxAViw9zdxa2F5bs&usqp=CAU", locationString: "", recipes: [recipe10.id : recipe10.dictionary, recipe9.id : recipe9.dictionary,recipe2.id : recipe2.dictionary,recipe8.id : recipe8.dictionary,recipe6.id : recipe6.dictionary,recipe7.id : recipe7.dictionary], descriptions: ["Wine", "Pasta", "Chicken", "Dinner", "Special Events"], avarageDeliveryTime: "30 - 40 Mins", rating: 4.8, ratingCount: 355,latitude: 38.408860, longitude: 27.119975)
        
        let kitchen5 = KitchenModel(id: UUID().uuidString, name: "Navarro", imageURL: "https://p0.pikist.com/photos/940/1021/breakfast-food-eating-meal-morning-restaurant-table-plates-waffles-thumbnail.jpg", locationString: "", recipes: [recipe10.id : recipe10.dictionary, recipe9.id : recipe9.dictionary,recipe2.id : recipe2.dictionary,recipe8.id : recipe8.dictionary,recipe6.id : recipe6.dictionary,recipe7.id : recipe7.dictionary], descriptions: ["Burger", "Sea-Food", "Chicken", "Traditional"], avarageDeliveryTime: "10 - 25 Mins", rating: 4.2, ratingCount: 458,latitude: 38.403830, longitude: 27.097520)
        
        let kitchen6 = KitchenModel(id: UUID().uuidString, name: "Tapavino Cafe & Restoran", imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTd-X5OL0Sf0a9kVK-w6m4PB9g2uGBkCx3t-kiGpYcLZAdNIa7B-3vhGVppr1Z4JYoM218&usqp=CAU", locationString: "", recipes: [recipe10.id : recipe10.dictionary, recipe9.id : recipe9.dictionary,recipe2.id : recipe2.dictionary,recipe8.id : recipe8.dictionary,recipe6.id : recipe6.dictionary,recipe1.id : recipe1.dictionary], descriptions: ["Burger", "Pasta", "Chicken", "Beef", "Pizza", "Dessert", "Wine", "Beer"], avarageDeliveryTime: "10 - 25 Mins", rating: 4.4, ratingCount: 30,latitude: 38.423830, longitude: 27.197520)
        
        let kitchen7 = KitchenModel(id: UUID().uuidString, name: "Etapes", imageURL: "https://static.thehoneycombers.com/wp-content/uploads/sites/2/2020/05/best-restaurants-in-singapore-feather-blade-900x643.png", locationString: "", recipes: [recipe5.id:recipe5.dictionary], descriptions: ["Burger", "Pasta", "Chicken", "Beef", "Pizza", "Dessert", "Wine", "Beer"], avarageDeliveryTime: "20 - 45 Mins", rating: 4.2, ratingCount: 30,latitude: 38.413830, longitude: 27.097520)
        
        let kitchen8 = KitchenModel(id: UUID().uuidString, name: "La Fuente", imageURL: "https://p0.pikist.com/photos/832/556/dish-restaurant-dining-food-dinner-meal-plate-eat-table.jpg", locationString: "", recipes: [recipe5.id:recipe5.dictionary,recipe9.id : recipe9.dictionary,recipe2.id : recipe2.dictionary,recipe8.id : recipe8.dictionary,recipe6.id : recipe6.dictionary], descriptions: ["Burger", "Pasta", "Chicken", "Beef", "Pizza", "Dessert", "Wine", "Beer"], avarageDeliveryTime: "20 - 45 Mins", rating: 4.3, ratingCount: 30,latitude: 38.423830, longitude: 27.087520)
        let kitchen9 = KitchenModel(id: UUID().uuidString, name: "Restaurant Culinaria", imageURL: "https://b.zmtcdn.com/data/pictures/chains/9/18577919/4c6b788b31123f4d6c045912a62e9ba0.jpeg", locationString: "", recipes: [recipe6.id:recipe6.dictionary, recipe8.id:recipe8.dictionary], descriptions: ["Pasta", " Vegetarian Burger"], avarageDeliveryTime: "10 - 15 Mins", rating: 3.4, ratingCount: 430,latitude: 37.403830, longitude: 27.097520)
        let kitchen10 = KitchenModel(id: UUID().uuidString, name: "Theatercafé - Restaurant", imageURL: "https://www.singleplatform.com/wp-content/uploads/2018/12/How-Significantly-Does-Restaurant-Lighting-Affect-the-Meal.jpg", locationString: "", recipes: [recipe10.id : recipe10.dictionary, recipe9.id : recipe9.dictionary,recipe2.id : recipe2.dictionary,recipe8.id : recipe8.dictionary,recipe6.id : recipe6.dictionary,recipe7.id : recipe7.dictionary,recipe11.id : recipe11.dictionary], descriptions: ["Burger", "Chicken", "Pizza", "Hotdog"], avarageDeliveryTime: "10 - 20 Mins", rating: 2.8, ratingCount: 2330,latitude: 38.413830, longitude: 27.099520)
        let kitchen11 = KitchenModel(id: UUID().uuidString, name: "Restaurant Veggie & Vega - Restaurant", imageURL: "https://www.veganmekanrehberi.com/vegan-mekan-haberleri/uploads/vegan-nedir.jpg", locationString: "", recipes: [recipe8.id:recipe8.dictionary, recipe11.id:recipe11.dictionary], descriptions: ["Pasta", "Vegetarian Burger", "Salads", "Traditional", "Dessert", "Fruits"], avarageDeliveryTime: "10 - 20 Mins", rating: 3.8, ratingCount: 435,latitude: 37.423830, longitude: 27.197520)
        
        var kitchens: [String:Any] = [:]
        kitchens[kitchen1.id] = kitchen1.dictionary
        kitchens[kitchen2.id] = kitchen2.dictionary
        kitchens[kitchen3.id] = kitchen3.dictionary
        kitchens[kitchen4.id] = kitchen4.dictionary
        kitchens[kitchen5.id] = kitchen5.dictionary
        kitchens[kitchen6.id] = kitchen6.dictionary
        kitchens[kitchen7.id] = kitchen7.dictionary
        kitchens[kitchen8.id] = kitchen8.dictionary
        kitchens[kitchen9.id] = kitchen9.dictionary
        kitchens[kitchen10.id] = kitchen10.dictionary
        kitchens[kitchen11.id] = kitchen11.dictionary
        
        // favoriye yada locationa göre sort olabilirler..
        FirebaseEndpoints.kitchens.getDatabasePath.setValue(kitchens)
        
        let user1 = UserModel(id: UUID().uuidString, name: "Oliver Sunrise", recipes:  [recipe10.id : recipe10.dictionary, recipe9.id : recipe9.dictionary,recipe2.id : recipe2.dictionary,recipe8.id : recipe8.dictionary,recipe6.id : recipe6.dictionary,recipe7.id : recipe7.dictionary,recipe11.id : recipe11.dictionary])
        
        var user: [String:Any] = [:]
        user[user1.id] = user1.dictionary
        FirebaseEndpoints.users.getDatabasePath.setValue(user)
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

