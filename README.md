 [![Generic badge](https://img.shields.io/badge/Language-Swift-red.svg)](https://developer.apple.com/swift/)

# Banabi Kitchen 
#### *FinalRestaurantProject for Yemeksepeti iOS Bootcamp*

## Table of Contents
- <a href="#description">Description</a>
- <a href="#tech-stack">Tech Stack</a>
- <a href="#features">Features</a>
- <a href="#libraries">Libraries</a>
- <a href="#previews">Previews</a>

## Description

Banabi Kitchen is a final project for the Yemeksepeti iOS Bootcamp. The project was created to simulate a food ordering app which is mimicking the Yemeksepeti. But it's a little bit different from the food ordering apps we already know. Instead of ordering the foods from the restraurants' specific menus, now you can crate your own recipes (inherited from your grandma maybe!), and you will get an offer for your selected or created recipe from different kitchens which are able to cook your meal! These kitchens were designed as Banabi - associated restaurants which can willing to serve you privately! 

## Tech Stack

* Firebase Realtime Database and Storage for backend
* MVVM, delegation patterns for bindings 
* Swift Package Manager
* MapKit
* CoreData, image caching
* Localization 
* Storyboard for UI design
* Image Picker Controller
* Some reusables views, empty state views, custom alerts, activity indicators, proper searching, organized folder structure.


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


## Requirements

* Xcode 12.5
* Swift 5
* iOS 14.5

## License
```
Copyright (c) 2021 Gizem Boskan

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
