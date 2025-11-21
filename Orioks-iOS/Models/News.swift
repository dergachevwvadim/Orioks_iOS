//
//  New.swift
//  Orioks_iOS
//
//  Created by User on 21.11.2025.
//

import Foundation

struct News {
    let id: String
    let date: Date
    let title: String
    let isRead: Bool
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
}

// Mock данные
extension News {
    static func mockData() -> [News] {
        return [
            News(
                id: "1",
                date: Date().addingTimeInterval(-2*24*60*60),
                title: "О запрете деятельности компании, которая разработала популярные игры \"Казаки\" и S.T.A.L.K.E.R",
                isRead: false
            ),
            News(
                id: "2",
                date: Date().addingTimeInterval(-7*24*60*60),
                title: "Новое в ОРИОКС: Психологический тест",
                isRead: false
            ),
            News(
                id: "3",
                date: Date().addingTimeInterval(-7*24*60*60),
                title: "Всероссийский космический диктант",
                isRead: true
            ),
            News(
                id: "4",
                date: Date().addingTimeInterval(-9*24*60*60),
                title: "Конкурс на стипендию имени К.А.Валиева на 2025/26 учебный год",
                isRead: false
            ),
            News(
                id: "5",
                date: Date().addingTimeInterval(-10*24*60*60),
                title: "Семинар о налоговых вычетах",
                isRead: false
            ),
            News(
                id: "6",
                date: Date().addingTimeInterval(-14*24*60*60),
                title: "Проведение дополнительных санитарно-противоэпидемических мероприятий",
                isRead: true
            ),
        ]
    }
}
