//
//  HomeViewController.swift.swift
//  Books
//
//  Created by Ahmed Moncer on 02/09/2024.
//

import UIKit

protocol HomeViewControllerProtocol: UIViewControllerRouting {
    func set(interactor: HomeInteractorProtocol)
    func set(router: HomeRouterProtocol)
    func set(imageLoader: ImageLoaderProtocol)

    func displayBooks(with books: [BookModel])
    func displayFilteredBooks(with books: [BookModel])
}

class HomeViewController: UIViewController, HomeViewControllerProtocol {

    // MARK: Private

    private var interactor: HomeInteractorProtocol?
    private var router: HomeRouterProtocol?
    private var imageLoader: ImageLoaderProtocol?

    private var booksDataSource = BooksDataSource()

    // MARK: Outlets

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var booksCollectionView: UICollectionView!
    
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor?.handleViewDidLoad()
    }

    // MARK: DI

    func set(interactor: HomeInteractorProtocol) {
        self.interactor = interactor
    }

    func set(router: HomeRouterProtocol) {
        self.router = router
    }

    func set(imageLoader: ImageLoaderProtocol) {
        self.imageLoader = imageLoader
    }

    // MARK: Setup

    private func setupUI() {
        booksCollectionView.register(
            .init(nibName: R.nib.bookCell.identifier,
                  bundle: nil),
            forCellWithReuseIdentifier: R.reuseIdentifier.bookCell.identifier
        )
        booksDataSource.set(imageLoader: imageLoader)
        booksCollectionView?.dataSource = booksDataSource
        booksCollectionView?.delegate = self
    }

    // MARK: Display

    func displayBooks(with books: [BookModel]) {
        booksDataSource.set(books: books, isComingFromHome: true)
        booksCollectionView.reloadData()
    }

    func displayFilteredBooks(with books: [BookModel]) {
        booksDataSource.set(books: books, isComingFromHome: true)
        booksCollectionView.reloadData()

    }
}

// MARK: UICollectionViewDelegate

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterBooks(searchText: searchText)
    }

    private func filterBooks(searchText: String) {
        interactor?.handleSearch(searchText: searchText)
    }
}

// MARK: UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = booksDataSource.item(at: indexPath.row)
        router?.route(to: .details(book: book))
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.size.width
        let collectionViewHeight = collectionViewWidth * 0.7

        return CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    // Distance Between Item Cells
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        32
    }
}
