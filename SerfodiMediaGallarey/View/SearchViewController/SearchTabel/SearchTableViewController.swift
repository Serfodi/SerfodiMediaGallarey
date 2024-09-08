//
//  SearchTableViewController.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 07.09.2024.
//

import UIKit


class SearchTableViewController: UITableViewController {

    // Data for section
    
    private var lastSearch : [String] = []
    
    /// Data for color filters section
    ///  - Seealso: https://unsplash.com/documentation#search
    private let colorFilters: [ColorFilter] = [
        .init(title: "Black".localized(), filter: "black", color: .black),
        .init(title: "White".localized(), filter: "white", color: .white),
        .init(title: "Yellow".localized(), filter: "yellow", color: .systemYellow),
        .init(title: "Orange".localized(), filter: "orange", color: .systemOrange),
        .init(title: "Red".localized(), filter: "red", color: .systemRed),
        .init(title: "Purple".localized(), filter: "purple", color: .systemPurple),
        .init(title: "Magenta".localized(), filter: "magenta", color: .magenta),
        .init(title: "Green".localized(), filter: "green", color: .systemGreen),
        .init(title: "Teal".localized(), filter: "teal", color: .systemTeal),
        .init(title: "Blue".localized(), filter: "blue", color: .systemBlue)
    ]
    
    private var dataSource: SearchDataSours!
    
    /// Action for history tap
    open var selectedHistory: ((String) -> ())?
    /// Action for color filter tap
    open var selectedColor: ((ColorFilter) -> ())?
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = SearchDataSours(tableView)
        tableView.register(UITableViewCell.self)
        tableView.dataSource = dataSource
        tableView.allowsMultipleSelection = false
        lastSearch = UserDefaults.standard.stringArray(forKey: "history") ?? []
        reload()
    }
    
    // MARK: Helpers
    
    func reload(with search: String? = nil) {
        var history = lastSearch
        // фильтруем по вхождению символов
        if let text = search, !text.isEmpty {
            history = lastSearch.filter{ $0.lowercased().contains(text.lowercased()) }
        }
        dataSource.reload([
            .init(key: .history, values: history.map { .history($0) }),
            .init(key: .color, values: colorFilters.map { .color($0) }),
        ])
    }
    
    func addItemHistory(text: String) {
        lastSearch.removeAll(where: {  $0 == text })
        lastSearch.insert(text, at: 0)
        lastSearch = Array(lastSearch.prefix(5))
        UserDefaults.standard.set(lastSearch, forKey: "history")
    }
}

// MARK: UITableViewDelegate

extension SearchTableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sectionId = dataSource.sectionIdentifier(for: indexPath.section) else { return }
        switch sectionId {
        case .history:
            guard case let .history(model) = dataSource.itemIdentifier(for: indexPath) else { return }
            selectedHistory?(model)
        case .color:
            guard case let .color(model) = dataSource.itemIdentifier(for: indexPath) else { return }
            selectedColor?(model)
        }
    }
}
