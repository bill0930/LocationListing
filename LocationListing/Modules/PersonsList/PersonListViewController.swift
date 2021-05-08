//
//  PersonListViewController.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import UIKit
import Moya
import SnapKit
import SkeletonView

final class PersonListViewController: UIViewController {

    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 76
        tableView.rowHeight = 76
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl

        tableView.register(PersonListTableViewCell.self, forCellReuseIdentifier: String(describing: PersonListTableViewCell.self))
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setCallbacksHandler()
        addSubViews()
        makeConstraints()
        viewModel.retrievePersonList(completion: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    let viewModel: PersonListViewModelProtocol

    init(viewModel: PersonListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PersonListViewController {
    private func addSubViews() {
        view.backgroundColor = UIColor(named: "pink003")!
        view.addSubview(tableView)
    }

    private func makeConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(44)
            $0.bottom.equalToSuperview()
            $0.left.equalTo(16)
            $0.right.equalTo(-16)
        }
    }

    private func setCallbacksHandler() {
        viewModel.updateLoadingStatus = {  [weak self] isLoading in
            if isLoading == true {
                let gradient = SkeletonGradient(baseColor: UIColor(named: "pink004")!)
                let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
                self?.tableView.isSkeletonable = true
                self?.tableView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
            }

            if isLoading == false {
                self?.tableView.hideSkeleton()
            }
        }

        viewModel.didFinishFetch = { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
        }

        viewModel.didFetchFromCache = { [weak self] in
            guard let strongSelf = self else { return }
            Toast.showTheListIsFromCache(sender: strongSelf)
        }

    }

    @objc private func pullToRefresh() {
        viewModel.pullToRefresh()
    }

}

extension PersonListViewController: SkeletonTableViewDataSource {

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return String(describing: PersonListTableViewCell.self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.persons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PersonListTableViewCell.self), for: indexPath) as? PersonListTableViewCell {
            let person = viewModel.persons[indexPath.row]
            cell.setModel(with: PersonListTableViewCellModel(person: person))
            return cell
        }

        return PersonListTableViewCell()
    }

}

extension PersonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = viewModel.persons[indexPath.row]
        print(person)
        let viewModel = SingleLocationMapViewModel(person: person)
        let vc = SingleLocationMapViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
