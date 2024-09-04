//
//  FavoritesStoryboard.swift
//  Books
//
//  Created by Ahmed Moncer on 04/09/2024.
//

import Swinject
import SwinjectStoryboard

class FavoritesStoryboard: Storyboard {

    private let container: Container
    private let assembly: Assembly
    private let storyboard: SwinjectStoryboard

    init(sharedContainer: Container, assembly: Assembly) {
        self.assembly = assembly
        container = Container(parent: sharedContainer)
        assembly.assemble(container: container)
        storyboard = SwinjectStoryboard.create(name: R.storyboard.favorites.name,
                                               bundle: nil,
                                               container: container)
    }


    func initial<T>() -> T? where T: UIViewController {
        return storyboard.instantiateInitialViewController() as? T
    }

    func viewController<T>(identifier: StoryboardId) -> T? where T: UIViewController {
        return storyboard.instantiateViewController(withIdentifier: identifier.identifier) as? T
    }
}
