//
//  MenuItem.swift
//  Orioks_iOS
//
//  Created by User on 21.11.2025.
//

import Foundation

enum MenuItemType {
    case native(destination: NativeDestination)
    case web(url: String)
}

enum NativeDestination {
    case schedule
    case contacts
    case faq
    case news
    case profile
    case grades
    case homework
}

struct MenuItem {
    let id: String
    let title: String
    let icon: String?
    let type: MenuItemType
    let isAvailable: Bool
}

extension MenuItem {
    static func quickLinks() -> [MenuItem] {
        return [
            MenuItem(
                id: "contacts",
                title: "Контакты",
                icon: "person.2.fill",
                type: .native(destination: .contacts),
                isAvailable: true
            ),
            MenuItem(
                id: "handbook",
                title: "Справочник студента",
                icon: "book.fill",
                type: .web(url: "https://mirea.ru/education/the-magistracy/"),
                isAvailable: true
            ),
            MenuItem(
                id: "faq",
                title: "Часто задаваемые вопросы",
                icon: "questionmark.circle.fill",
                type: .native(destination: .faq),
                isAvailable: true
            ),
            MenuItem(
                id: "features",
                title: "Возможности ОРИОКС",
                icon: "star.fill",
                type: .web(url: "https://mirea.ru/"),
                isAvailable: true
            ),
        ]
    }
    
    static func sideMenuItems() -> [MenuItem] {
        return [
            MenuItem(
                id: "practice",
                title: "Практика",
                icon: "briefcase.fill",
                type: .native(destination: .schedule),
                isAvailable: false
            ),
            MenuItem(
                id: "education",
                title: "Обучение",
                icon: "graduationcap.fill",
                type: .native(destination: .schedule),
                isAvailable: true
            ),
            MenuItem(
                id: "homework",
                title: "Домашние задания",
                icon: "doc.text.fill",
                type: .native(destination: .homework),
                isAvailable: true
            ),
            MenuItem(
                id: "portfolio",
                title: "Портфолио",
                icon: "folder.fill",
                type: .native(destination: .profile),
                isAvailable: false
            ),
            MenuItem(
                id: "project",
                title: "Проектная работа",
                icon: "hammer.fill",
                type: .native(destination: .schedule),
                isAvailable: false
            ),
            MenuItem(
                id: "gradebook",
                title: "Зачётная книжка",
                icon: "book.closed.fill",
                type: .native(destination: .grades),
                isAvailable: true
            ),
            MenuItem(
                id: "requests",
                title: "Заявки",
                icon: "paperplane.fill",
                type: .native(destination: .schedule),
                isAvailable: false
            ),
            MenuItem(
                id: "libraries",
                title: "Электронные библиотеки",
                icon: "books.vertical.fill",
                type: .web(url: "https://lib.mirea.ru"),
                isAvailable: true
            ),
            MenuItem(
                id: "help",
                title: "Помощь",
                icon: "questionmark.circle.fill",
                type: .web(url: "https://mirea.ru/sveden/"),
                isAvailable: true
            ),
        ]
    }
}
