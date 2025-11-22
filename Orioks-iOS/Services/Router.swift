//
//  Router.swift
//  Orioks_iOS
//
//  Created by User on 22.11.2025.
//

import UIKit
import SafariServices

final class Router {
    
    // MARK: - Properties
    weak var navigationController: UINavigationController?
    
    // MARK: - Init
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController}
    
    // MARK: - Navigation
    func navigate(to menuItem: MenuItem) {
        switch menuItem.type {
        case .native(let destination):
            navigateToNative(destination: destination)
            
        case .web(let urlString):
            openInSafari(urlString: urlString)
        }
    }
    
    // MARK: - Native Navigation
    private func navigateToNative(destination: NativeDestination) {
        let viewController: UIViewController
        
        switch destination {
        case .schedule:
            viewController = ScheduleViewController()
            
        case .contacts:
            viewController = ContactsViewController()
            
        case .faq:
            viewController = FAQViewController()
            
        case .news:
            viewController = HomeViewController()
            
        case .profile:
            viewController = ProfileViewController()
            
        case .grades:
            viewController = GradesViewController()
            
        case .homework:
            viewController = HomeworkViewController()
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Web Navigation
    private func openInSafari(urlString: String) {
        guard let url = URL(string: urlString) else {
            showError(message: "Некорректная ссылка")
            return
        }
        
        // Используем SFSafariViewController - остаемся в приложении
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .orioksPrimary
        safariVC.preferredBarTintColor = .systemBackground
        
        navigationController?.present(safariVC, animated: true)
    }
    
    // MARK: - Helpers
    private func showError(message: String) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        navigationController?.present(alert, animated: true)
    }
    
    // MARK: - Check Availability
    func canNavigate(to menuItem: MenuItem) -> Bool {
        return menuItem.isAvailable
    }
    
    func handleUnavailableItem(_ menuItem: MenuItem) {
        let alert = UIAlertController(
            title: "Скоро появится",
            message: "Раздел «\(menuItem.title)» в разработке",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        navigationController?.present(alert, animated: true)
    }
}
