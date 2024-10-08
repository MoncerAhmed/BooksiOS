//
//  BookDetailsViewController.swift
//  Books
//
//  Created by Ahmed Moncer on 05/09/2024.
//

import UIKit

protocol BookDetailsViewControllerProtocol: UIViewControllerRouting {
    func set(interactor: BookDetailsInteractorProtocol)
    func set(router: BookDetailsRouterProtocol)
    func set(imageLoader: ImageLoaderProtocol)

    func setBook(with book: BookModel)
    func displayDetails(with book: BookModel)
    func displayFavoriteButton(with isFavorite: Bool)
}

class BookDetailsViewController: UIViewController, BookDetailsViewControllerProtocol {

    // MARK: Private

    private var interactor: BookDetailsInteractorProtocol?
    private var router: BookDetailsRouterProtocol?
    private var imageLoader: ImageLoaderProtocol?
    private var bookModel: BookModel?

    // MARK: Outlets
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var bookImageView: RoundedImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    @IBOutlet weak var bookSummary: UILabel!
    @IBOutlet weak var bookReads: UILabel!
    @IBOutlet weak var bookReviews: UILabel!

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        guard let bookModel = bookModel else { return }
        interactor?.handleBookDetail(with: bookModel)
    }

    // MARK: DI

    func set(interactor: BookDetailsInteractorProtocol) {
        self.interactor = interactor
    }

    func set(router: BookDetailsRouterProtocol) {
        self.router = router
    }

    func set(imageLoader: ImageLoaderProtocol) {
        self.imageLoader = imageLoader
    }

    func setBook(with book: BookModel) {
        self.bookModel = book
    }


    // MARK: Setup

    private func setupUI() {
        backButton.setImage(R.image.backArrow(), for: .normal)
        backButton.tintColor = .green
    }


    // MARK: Display

    func displayDetails(with book: BookModel) {
        bookTitle.text = book.title
        bookAuthor.text = book.author
        bookDescription.text = book.bookDescription
        bookSummary.text = book.summary
        bookReads.text = book.reads + " reads"
        bookReviews.text = book.reviews + " reviews"
        if let imageURL = URL(string: book.coverURL) {
            imageLoader?.loadImage(
                url: imageURL,
                into: bookImageView,
                placeholder: nil,
                completion: nil
            )
        }
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        router?.route(to: .back)
    }

    @IBAction func favoriteButtonTapped(_ sender: Any) {
        interactor?.handleFavoriteButtonTapped()
    }

    func displayFavoriteButton(with isFavorite: Bool) {
        let favoriteImage: UIImage? = isFavorite ? R.image.heartActive() : R.image.heartInactive()
        favoritesButton.setImage(favoriteImage, for: .normal)
    }
}
