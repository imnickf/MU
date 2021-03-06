//
//  FoodTableViewController.swift
//  MU
//
//  Created by Nick Flege on 2/19/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

/// A class used to manage the Food View.
class FoodTableViewController: UITableViewController
{
  /// An Item Repository.
  let itemRepo = ItemRepository()

  /// An array that is used to store Food items.
  var foods = [Food]()

  var selectedFood: Food?

  override func viewDidLoad()
  {
    super.viewDidLoad()

    navigationController?.navigationBar.barTintColor = Theme.primaryRedColor
    navigationController?.navigationBar.tintColor = UIColor.black
    tabBarController?.tabBar.barTintColor = Theme.primaryGrayColor
    tabBarController?.tabBar.tintColor = Theme.secondaryRedColor

    itemRepo.getItems(.food) { (items) in
      self.foods = items as! [Food]

      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
}

// MARK: - FoodTableViewController Protocol Methods

extension FoodTableViewController
{
  override func numberOfSections(in tableView: UITableView) -> Int
  {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return foods.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let food = foods[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell", for: indexPath) as! FoodTableViewCell

    cell.configureWith(food: food)

    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    selectedFood = self.foods[indexPath.row]
    performSegue(withIdentifier: "showFoodDetail", sender: self)
  }

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  {
    return 50.0
  }
}

// MARK: - Navigation

extension FoodTableViewController
{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.identifier == "showFoodDetail" {
      if let vc = segue.destination as? FoodDetailViewController {
        if let food = selectedFood {
          vc.food = food
          vc.navigationItem.title = food.name
        }
      }
    }
  }
}
