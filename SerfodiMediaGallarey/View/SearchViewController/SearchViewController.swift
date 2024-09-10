//
//  SearchViewController.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 07.09.2024.
//

import UIKit

protocol SearchDelegate: AnyObject {
    func clickedSearch(parameters: Configuration)
}

final class SearchViewController: UISearchController {

    weak var searchDelegate: SearchDelegate?
    
    private let searchTable: SearchTableViewController
    
    // MARK: Object lifecycle
    
    init() {
        searchTable = SearchTableViewController()
        super.init(searchResultsController: searchTable)
        
        // Add Actions
        searchTable.selectedHistory = { [weak self] in
            self?.searchBar.text = $0
        }
        searchTable.selectedColor = { [weak self] in
            guard let self = self else { return }
            self.searchBar.searchTextField.tokens = [self.searchToken($0)]
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchResultsUpdater = self
        hidesNavigationBarDuringPresentation = false
        obscuresBackgroundDuringPresentation = false
        scopeBarActivation = .manual
    }
    
    // MARK: Helpers
    
    private func isShow(_ show: Bool) {
        showsSearchResultsController = show
    }
    
    private func searchToken(_ tokenValue: ColorFilter) -> UISearchToken {
        let image = StaticImage.colorIcon?.withTintColor(tokenValue.color, renderingMode: .alwaysOriginal)
        let searchToken = UISearchToken(icon: image, text: tokenValue.title.localized())
        searchToken.representedObject = tokenValue.filter
        return searchToken
    }
    
    private func getToken() -> String? {
        searchBar.searchTextField.tokens.first?.representedObject as? String
    }
    
}

// MARK: UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isShow(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTable.reload(with: searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        isShow(false)
        let parameters = Configuration(query: text, color: getToken())
        searchTable.addItemHistory(text: text)
        searchDelegate?.clickedSearch(parameters: parameters)
        searchTable.reload()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isShow(false)
    }
}

// MARK: UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        searchController.showsSearchResultsController = searchController.isActive
    }
        
}
