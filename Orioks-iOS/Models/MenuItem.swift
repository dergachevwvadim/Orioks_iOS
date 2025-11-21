//
//  MenuItem.swift
//  Orioks_iOS
//
//  Created by User on 21.11.2025.
//

import Foundation

struct MenuItem {
    let id: String
    let title: String
    let icon: String? // SF Symbol name
    let url: String?
}

extension MenuItem {
    static func quickLinks() -> [MenuItem] {
        return [
            MenuItem(id: "contacts", title: "Контакты", icon: "phone.fill", url: ""),
            MenuItem(id: "handbook", title: "Справочник студента", icon: "book.fill", url: ""),
            MenuItem(id: "schedule", title: "Расписание занятий", icon: "calendar", url: "https://www.miet.ru/schedule/"),
            MenuItem(id: "faq", title: "Часто задаваемые вопросы", icon: "questionmark.circle.fill", url: ""),
            MenuItem(id: "features", title: "Возможности ОРИОКС", icon: "star.fill", url: ""),
        ]
    }
}
