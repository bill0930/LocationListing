//
//  PersonsListViewController.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import UIKit
import Moya
import SnapKit

final class PersonsListViewController: UIViewController {

    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle  = .none
        tableView.indicatorStyle = .default
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PersonsListTableViewCell.self, forCellReuseIdentifier: String(describing: PersonsListTableViewCell.self))
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setCallbacksHandler()
        addSubViews()
        makeConstraints()
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
        view.addSubview(tableView)
    }

    private func makeConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.left.right.equalToSuperview()
        }
    }

    private func setCallbacksHandler() {
        viewModel.updateLoadingStatus = { [weak self] in

        }

        viewModel.didFinishFetch = { [weak self] in
            self?.tableView.reloadData()
            print("didFinishFetch, billychan")
        }
    }

}

extension PersonsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.persons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PersonsListTableViewCell.self), for: indexPath) as? PersonsListTableViewCell {
            cell.textLabel?.text = viewModel.persons[indexPath.row].name.first
            return cell
        }
        return UITableViewCell()
    }

}
