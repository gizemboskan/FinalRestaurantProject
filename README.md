 [![Generic badge](https://img.shields.io/badge/Language-Swift-red.svg)](https://developer.apple.com/swift/)

# Banabi Kitchen 
#### *FinalRestaurantProject for Yemeksepeti iOS Bootcamp*

## Description

Banabi Kitchen is a final project for the Yemeksepeti iOS Bootcamp. The project was created to simulate a food ordering app which is mimicking the Yemeksepeti. But it's a little bit different from the food ordering apps we already know. Instead of ordering the foods from the restraurants' specific menus, now you can crate your own recipes (inherited from your grandma maybe!), and you will get an offer for your selected or created recipe from different kitchens want able to cook your meal! These kitchens were designed as Banabi - associated restaurants which can willing to serve you privately! 

## Tech Stack

* Firebase Realtime Database and Storage for backend
* MVVM, delegation patterns for bindings 
* MapKit
* CoreData, image caching
* Localization 
* Storyboard for UI design
* Image Picker Controller


## Features

* Users can create their own recipes and customize any time they want by defining the instructions, images, ingredients and name of the recipe. 
* Users can like or unlike any recipe to add or delete from their own recipes and search among the kitchens or recipes according to their name.
* Users can see kitchens' recipes and details (ratings, locations, descriptions, etc.).
* Users can order a meal from kitchens by getting offers from available kitchens, depending on the estimated delivery time and cost of the service. Kitchens also have rating numbers and counts to represent a quality of their services. Offered data from kitchens only made by simulation purposes meaning that they are only mocked data to simulate the scenario.

## Libraries

* PaperOnboarding https://github.com/Ramotion/paper-onboarding
* RAMAnimatedTabBarController https://github.com/Ramotion/animated-tab-bar
* StepIndicator https://github.com/chenyun122/StepIndicator
* Firebase Database, Firebase Storage https://github.com/firebase/firebase-ios-sdk
* WSTagsField https://github.com/whitesmith/WSTagsField

## Previews 

| Onboarding Screen | Recipes & Orders Screen | Kitchens Screen |   
| --- | --- | --- | 
| ![Preview](gifs/recipes.gif) | ![Preview](gifs/order.gif) | ![Preview](gifs/kitchens.gif) | 








