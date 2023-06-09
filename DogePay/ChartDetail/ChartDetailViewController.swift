//
//  ChartDetailViewController.swift
//  DogePay
//
//  Created by Victor Lee on 2023/03/13.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Charts

protocol ChartDetailDisplayLogic: AnyObject
{
    func displayPriceList(viewModel: ChartDetail.ConnectWebSocket.ViewModel)
    var priceList: ChartDetail.ConnectWebSocket.ViewModel? { get set }
}

class ChartDetailViewController: UIViewController, ChartDetailDisplayLogic
{
    var interactor: ChartDetailBusinessLogic?
    var router: (NSObjectProtocol & ChartDetailRoutingLogic & ChartDetailDataPassing)?

    var priceList: ChartDetail.ConnectWebSocket.ViewModel? = nil

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
        let interactor = ChartDetailInteractor()
        let presenter = ChartDetailPresenter()
        let router = ChartDetailRouter()
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

    private let coinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()

    // MARK: View lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()

        setupViews()
        fetchPriceLists()
    }

    func fetchPriceLists()
    {
        interactor?.fetchPriceLists()
    }

    func displayPriceList(viewModel: ChartDetail.ConnectWebSocket.ViewModel)
    {
        priceList = viewModel
        let coinImage = priceList?.displayedPrices.first?.coinImage

        DispatchQueue.main.async { [weak self] in
            self?.coinImage.image = coinImage
        }

        let priceData = viewModel.displayedPrices.compactMap { Double($0.price) }
        let index = Array(0..<priceData.count).map { "\($0)" }

        if priceData.isEmpty != true {
            DispatchQueue.main.async { [weak self] in
                self?.setChartViewConfig(index: index, priceData: priceData)
            }
        }
    }

    // MARK: Charts

    var chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.noDataText = "그래프가 그려지는 중이에요!"
        chartView.noDataFont = .systemFont(ofSize: 22, weight: .bold)
        chartView.noDataTextColor = .red
        chartView.chartDescription.enabled = false
        chartView.xAxis.gridColor = .systemBackground

        return chartView
    }()

    func setChartViewConfig(index: [String], priceData: [Double]) {
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: index)
        chartView.xAxis.setLabelCount(priceData.count, force: false)

        setLineData(lineChartView: chartView, lineChartDataEntries: entryData(values: priceData))
    }

    func setLineData(lineChartView: LineChartView, lineChartDataEntries: [ChartDataEntry]) {
        let lineChartDataSet = LineChartDataSet(entries: lineChartDataEntries, label: "Price")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
    }

    func entryData(values: [Double]) -> [ChartDataEntry] {
        var lineDataEntries: [ChartDataEntry] = []

        for i in 0..<values.count {
            let lineDataEntry = ChartDataEntry(x: Double(i), y: values[i])
            lineDataEntries.append(lineDataEntry)
        }

        return lineDataEntries
    }

    func setupViews() {
        view.backgroundColor = .systemBackground

        view.addSubview(chartView)
        view.addSubview(coinImage)

        NSLayoutConstraint.activate([
            coinImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            coinImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            coinImage.widthAnchor.constraint(equalToConstant: 40),
            coinImage.heightAnchor.constraint(equalToConstant: 40),

            chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            chartView.topAnchor.constraint(equalTo: coinImage.bottomAnchor, constant: 40),
            chartView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
