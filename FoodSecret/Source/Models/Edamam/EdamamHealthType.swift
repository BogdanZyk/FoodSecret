//
//  EdamamHealthType.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 23.03.2023.
//

import Foundation

enum EdamamHealthType: String{
   
    
    case vegan = "Vegan"
    case vegetarian = "Vegetarian"
    case alcoholDree = "alcohol-free"
    case celeryFree = "Celery-Free"
    case crustceanFree = "Crustcean-Free"
    case dairyFree = "Dairy-Free"
    case dash = "DASH"
    case eggFree = "Egg-Free"
    case fishFree = "Fish-Free"
    case fodmapFree = "FODMAP-Free"
    case glutenFree = "Gluten-Free"
    case immunoSupportive = "Immuno-Supportive"
    case ketofriendly = "Keto-Friendly"
    case kosher = "Kosher"
    case lowPotassium = "Low Potassium"
    case lowSugar = "Low Sugar"
    case lupineFree = "Lupine-Free"
    case mediterranean = "Mediterranean"
    case molluskFree = "Mollusk-Free"
    case mustardFree = "Mustard-Free"
    case noOilAdded = "No oil added"
    case paleo = "Paleo"
    case peanutFree = "Peanut-Free"
    case pescatarian = "Pescatarian"
    case porkFree = "Pork-Free"
    case redMeatFree = "Red-Meat-Free"
    case treeNutFree = "Tree-Nut-Free"
    
    
    var uRLQueryItem: URLQueryItem{
        .init(name: "health", value: rawValue.lowercased())
    }
    
    var emoji: String {return ""}
}


//alcohol-cocktail    Describes an alcoholic cocktail
//Alcohol-Free    alcohol-free    No alcohol used or contained
//Celery-Free    celery-free    Does not contain celery or derivatives
//Crustcean-Free    crustacean-free    Does not contain crustaceans (shrimp, lobster etc.) or derivatives
//Dairy-Free    dairy-free    No dairy; no lactose
//DASH    DASH    Dietary Approaches to Stop Hypertension diet
//Egg-Free    egg-free    No eggs or products containing eggs
//Fish-Free    fish-free    No fish or fish derivatives
//FODMAP-Free    fodmap-free    Does not contain FODMAP foods
//Gluten-Free    gluten-free    No ingredients containing gluten
//Immuno-Supportive    immuno-supportive    Recipes which fit a science-based approach to eating to strengthen the immune system
//Keto-Friendly    keto-friendly    Maximum 7 grams of net carbs per serving
//Kidney-Friendly    kidney-friendly    Per serving – phosphorus less than 250 mg AND potassium less than 500 mg AND sodium less than 500 mg
//Kosher    kosher    Contains only ingredients allowed by the kosher diet. However it does not guarantee kosher preparation of the ingredients themselves
//Low Potassium    low-potassium    Less than 150mg per serving
//Low Sugar    low-sugar    No simple sugars – glucose, dextrose, galactose, fructose, sucrose, lactose, maltose
//Lupine-Free    lupine-free    Does not contain lupine or derivatives
//Mediterranean    Mediterranean    Mediterranean diet
//Mollusk-Free    mollusk-free    No mollusks
//Mustard-Free    mustard-free    Does not contain mustard or derivatives
//No oil added    No-oil-added    No oil added except to what is contained in the basic ingredients
//Paleo    paleo    Excludes what are perceived to be agricultural products; grains, legumes, dairy products, potatoes, refined salt, refined sugar, and processed oils
//Peanut-Free    peanut-free    No peanuts or products containing peanuts
//Pescatarian    pecatarian    Does not contain meat or meat based products, can contain dairy and fish
//Pork-Free    pork-free    Does not contain pork or derivatives
//Red-Meat-Free    red-meat-free    Does not contain beef, lamb, pork, duck, goose, game, horse, and other types of red meat or products containing red meat.
//Sesame-Free    sesame-free    Does not contain sesame seed or derivatives
//Shellfish-Free    shellfish-free    No shellfish or shellfish derivatives
//Soy-Free    soy-free    No soy or products containing soy
//Sugar-Conscious    sugar-conscious    Less than 4g of sugar per serving
//Sulfite-Free    sulfite-free    No Sulfites
//Tree-Nut-Free    tree-nut-free    No tree nuts or products containing tree nuts
//Vegan    vegan    No meat, poultry, fish, dairy, eggs or honey
//Vegetarian    vegetarian    No meat, poultry, or fish
//Wheat-Free    wheat-free    No wheat, can have gluten though
