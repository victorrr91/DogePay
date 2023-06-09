//
//  ChartHomeViewController.swift
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

protocol ChartHomeDisplayLogic: AnyObject
{
    func displayPriceList(viewModel: ChartHome.ConnectWebSocket.ViewModel)
}

class ChartHomeViewController: UIViewController, ChartHomeDisplayLogic
{
    var interactor: ChartHomeBusinessLogic?
    var router: (NSObjectProtocol & ChartHomeRoutingLogic & ChartHomeDataPassing)?

    typealias DisplayPrice = ChartHome.ConnectWebSocket.ViewModel.DisplayedPrice

    var priceList: [DisplayPrice] = []

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup()
    {
        let viewController = self
        let interactor = ChartHomeInteractor()
        let presenter = ChartHomePresenter()
        let router = ChartHomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View Components

    private let rootFlexContainer = UIView()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 80
        tableView.separatorColor = .white

        tableView.register(ChartTableViewCell.self, forCellReuseIdentifier: "ChartTableViewCell")

        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        rootFlexContainer.pin.all(view.pin.safeArea)
        rootFlexContainer.flex.layout(mode: .fitContainer)
    }

    private func setupViews() {
        view.addSubview(rootFlexContainer)

        rootFlexContainer.flex.direction(.column).define {
            $0.addItem(tableView).grow(1)
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()

        setupViews()

        fetchPriceList()
    }

    func fetchPriceList() {
        interactor?.fetchPriceList()
    }

    func displayPriceList(viewModel: ChartHome.ConnectWebSocket.ViewModel)
    {
        let price = viewModel.displayedPrice
        self.priceList = [price] + self.priceList
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ChartHomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priceList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChartTableViewCell", for: indexPath) as? ChartTableViewCell else { return UITableViewCell() }

        let cellData = priceList[indexPath.row]

        cell.configureCell(data: cellData)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let price = priceList[indexPath.row]
        router?.routeToChartDetail(priceBase: price.priceBase)
    }
}
