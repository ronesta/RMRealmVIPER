//
//  ViewController.swift
//  RMRealmVIPER
//
//  Created by Ибрагим Габибли on 02.02.2025.
//

//
//  ViewController.swift
//  RMCoreDataVIPER
//
//  Created by Ибрагим Габибли on 02.02.2025.
//

import UIKit
import SnapKit

final class CharacterViewController: UIViewController {
    var presenter: CharacterPresenterProtocol?
    var dataSource: CharacterDataSourceProtocol?

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        presenter?.viewDidLoad()
    }

    private func setupNavigationBar() {
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.register(CharacterTableViewCell.self,
                           forCellReuseIdentifier: CharacterTableViewCell.id)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - CharacterViewProtocol
extension CharacterViewController: CharacterViewProtocol {
    func displayCharacters(_ characters: [RealmCharacter]) {
        dataSource?.characters = characters
        tableView.reloadData()
    }

    func displayError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        128
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
