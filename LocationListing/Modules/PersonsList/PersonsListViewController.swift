//
//  PersonsListViewController.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import UIKit
import Moya

final class PersonsListViewController: UIViewController {

    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle  = .none
        tableView.indicatorStyle = .default
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "pink001")
        // Do any additional setup after loading the view.
        viewModel.getPersonList()
    }

    let viewModel: PersonsListViewModelProtocol

    init(viewModel: PersonsListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PersonsListViewController {
    private func addSubViews() {

    }

    private func makeConstraints() {

    }
}
