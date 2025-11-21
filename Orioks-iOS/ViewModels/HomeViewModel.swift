//
//  HomeViewModel.swift
//  Orioks_iOS
//
//  Created by User on 21.11.2025.
//

import Foundation

class HomeViewModel {
    
    // MARK: - Properties
    private var news: [News] = []
    private var menuItems: [MenuItem] = []
    
    var onNewsUpdated: (() -> Void)?
    var onBannerAvailable: ((String) -> Void)?
    
    // MARK: - Computed Properties
    var numberOfNews: Int {
        return news.count
    }
    
    var hasBanner: Bool {
        return true // Проверка есть ли доступные тесты/уведомления
    }
    
    var bannerText: String {
        return "Вам доступен добровольный ПСИХОЛОГИЧЕСКИЙ тест для прохождения"
    }
    
    // MARK: - Init
    init() {
        loadData()
    }
    
    // MARK: - Public Methods
    func loadData() {
        // Имитация загрузки данных
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.news = News.mockData()
            self?.menuItems = MenuItem.quickLinks()
            self?.onNewsUpdated?()
            
            if let bannerText = self?.bannerText {
                self?.onBannerAvailable?(bannerText)
            }
        }
    }
    
    func newsItem(at index: Int) -> News? {
        guard index < news.count else { return nil }
        return news[index]
    }
    
    func menuItem(at index: Int) -> MenuItem? {
        guard index < menuItems.count else { return nil }
        return menuItems[index]
    }
    
    func didSelectNews(at index: Int) {
        guard let newsItem = newsItem(at: index) else { return }
        print("Selected news: \(newsItem.title)")
        // TODO: Открыть детальный экран новости
    }
    
    func didSelectMenuItem(at index: Int) {
        guard let item = menuItem(at: index) else { return }
        print("Selected menu item: \(item.title)")
        // TODO: Навигация к соответствующему экрану
    }
}
