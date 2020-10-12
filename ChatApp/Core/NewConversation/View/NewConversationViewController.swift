//
//  NewConversationViewController.swift
//  ChatApp
//
//  Created by Angel Aguilar on 12/10/20.
//

import UIKit

protocol NewConversationViewControllerDelegate: AnyObject {
    func selectedUser(user: SearchResult)
}

class NewConversationViewController: UIViewController {

    weak var delegate: NewConversationViewControllerDelegate?
    private var users = [[String: String]]()
    private var results = [SearchResult]()
    private var hasFetched = false
    var viewModel: NewConversationViewModel?

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for Users..."
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    private let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.register(NewConversationCell.self, forCellReuseIdentifier: NewConversationCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private let noResultsLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "No Results!"
        label.textAlignment = .center
        label.textColor = .darkText
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        
    }
    
    private func initViews() {
        view.addSubview(noResultsLabel)
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()

        searchBar.delegate = self
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(dismissView))
        searchBar.becomeFirstResponder()
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            noResultsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension NewConversationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = results[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: NewConversationCell.identifier,
                                                 for: indexPath) as! NewConversationCell
        cell.configure(with: model)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = results[indexPath.row]

        dismiss(animated: true, completion: { [weak self] in
            self?.delegate?.selectedUser(user: user)
        })
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension NewConversationViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }
        searchBar.resignFirstResponder()
        results = [SearchResult]()
        
        viewModel?.searchUser(text)
    }



    func updateUI() {
        if results.isEmpty {
            noResultsLabel.isHidden = false
            tableView.isHidden = true
        }
        else {
            noResultsLabel.isHidden = true
            tableView.isHidden = false
            tableView.reloadData()
        }
    }

}

extension NewConversationViewController: NewConversationView {
    func loadUsersResult(users: [SearchResult]) {
        self.results = users
        updateUI()
    }
}
