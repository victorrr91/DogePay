//
//  DogeHomeRouter.swift
//  DogePay
//
//  Created by Victor Lee on 2023/03/10.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol DogeHomeRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol DogeHomeDataPassing
{
  var dataStore: DogeHomeDataStore? { get }
}

class DogeHomeRouter: NSObject, DogeHomeRoutingLogic, DogeHomeDataPassing
{
  weak var viewController: DogeHomeViewController?
  var dataStore: DogeHomeDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: DogeHomeViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: DogeHomeDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
