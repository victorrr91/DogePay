//
//  ChartHomePresenter.swift
//  DogePay
//
//  Created by Victor Lee on 2023/03/12.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ChartHomePresentationLogic
{
  func presentSomething(response: ChartHome.Something.Response)
}

class ChartHomePresenter: ChartHomePresentationLogic
{
  weak var viewController: ChartHomeDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: ChartHome.Something.Response)
  {
    let viewModel = ChartHome.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
