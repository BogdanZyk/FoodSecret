//
//  MocksEdamam.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 24.03.2023.
//

import Foundation

class MockEdamam{
    
    
  static let recept: Recipe = .init(
        uri: "",
        label: "Blanquette De Veau (White Veal Stew)",
        image: "https://edamam-product-images.s3.amazonaws.com/web-img/754/75447d70cd6cfc1e738422666a1f4afe-l.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEAoaCXVzLWVhc3QtMSJIMEYCIQDuBpvjQFXRAokx2mtMoboXcoHMvhA0ZmDL%2BSnLTeo3VgIhAKAaz%2FLeTmxL1wf86lStzUY3qIVI0UGMnyb4quykZ1P%2BKsIFCNL%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQABoMMTg3MDE3MTUwOTg2IgyLsQ0yeUA0Cy3d1HYqlgWopRx4D%2B8%2FtzIZZhOhM01iAsMtbSfAsNDFdkiZpZjE8hPAfnqpDAyAvTROw%2FX8rUw6%2BQSFPmp4Rl5TH55D3zZwYsZzO4axJ3gU6hO3GN6dlxW%2BEJL3zIsE1eYWr15SgR%2Be4WxGxS9RCemVJFNCN4OXVSIzS7uNzqlRPWLHlys%2FgZwy7YjjjDwkmfoLtwxkpX5yoX%2FmI2vzcR82gLGlDGz8gn60oR1HiBErbR1Sw4jmlom%2F3qF8Lzr7qskr4cSqKjBvMnDuqpeLG8DvZjo2fzutCHP46bLHFVg2ZNNXA6bS5l40KCO2vq%2FAnd1qvFNVakGdSQWMZQJmrbbM7cfgI5veENH1RvahI3T1xnykxuVz7Za9aRI22e6zIPaIWYiBzwf0vxdGfIWoAGIsha9OiFiZWyxnlBN%2BPLHKF9GgjVMxb49hVfEjWz6ci%2F3FNvR2xIO%2B2aBlAO9LYNvOm5xO55nrEWXJGPS1BTxrwYocBuQkZzoT0aMeDmOzLp97JcO1vAYZHwCyFhrsqERrrZmMauZOEnxQcAAQ9eXKKngnVL7Yn6MDfaXQuMNabSFDzUQDtkzFOkDP0bL5KYdG7m2HMdzZLb6onfa28%2BUfTGc0qlfizOFtSa%2Bemtrfa5b6uqgpm4xgwSX6nV2Z6wCpgn9qvJmDGztRo9PvZ49Ero9YHSWnEe0G41wct4OJejlboClVwyAhdTD%2FMi2r2U4LsLqPhTWjL4yZv1kjq%2FpNHfAePbmfuVBL1zPfBTO8oZRXQlnnZKcLgBASheq2Ln5MZfnYHuiF5Am96SKjdRhkkWRFLdc3k5T2zvG%2Fnk3PvWLd%2Bvfn%2BT6K%2FPq%2BIp%2FyV156BRJxYQhvS4HGZ3aplR4fnI1XE3079yKDpVerxjCZ1fWgBjqwAept676jQZC4w%2FifJtYbcmmVvoKGbs4qsThQP5T5TV1XeKm8aPVjQpZAtweTT4B81PdPbjJ2Dnu2Hz6hP87BDUKMavDWTjEilcNEkcSy0ufPQJjEeN4rfLHNsEzQuAJEyXKxsjAkm9fdGiGgSE7hFlp4FfD3Vur%2BOQZeEmys%2F%2B6GCxS4qFCo7%2BVze9P4v7RO2EzdRgstZ%2BJ77HY1LhYp53NODswGDYpp5I0LywRYfG1e&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230324T095835Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFB7D7PR5J%2F20230324%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=8fe14b81af9470349193c14c701cd6bdb369d1ef06f067726862aa5fd2ce3d22",
        images: nil,
        source: nil,
        url: nil,
        shareAs: nil,
        yield: 0,
        dietLabels: ["High-Fiber", "Low-Carb"],
        healthLabels: ["Peanut-Free", "Tree-Nut-Free", "Soy-Free", "Fish-Free", "Shellfish-Free", "Pork-Free", "Crustacean-Free", "Celery-Free", "Mustard-Free", "Sesame-Free", "Lupine-Free", "Mollusk-Free", "Alcohol-Free", "Sulfite-Free"],
        cautions: ["Sulfites"],
        ingredientLines: ["6 tablespoons butter", "2 pounds boneless veal shoulder, cut into 2-inch cubes", "1 onion, peeled and quartered","2 carrots, cut into chunks", "2 turnips or parsnips, trimmed, peeled, and cut into chunks", "salt", "black pepper", "2 cups chicken stock, preferably homemade","2 bay leaves", "7 fresh thyme sprigs", "1/4 cup flour", "2 egg yolks","1/2 cup heavy cream","1 tablespoon fresh lemon juice","fresh parsley leaves"],
        ingredients: [.init(text: "", quantity: 1.0, measure: "pinch", food: "sea salt", weight: 10, foodId: UUID().uuidString)],
        calories: 2918,
        totalWeight: 2215,
        totalTime: 120,
        cuisineType: ["french"],
        mealType: ["lunch/dinner"],
        dishType: ["main course"],
        externalId: nil
    )
    
}
