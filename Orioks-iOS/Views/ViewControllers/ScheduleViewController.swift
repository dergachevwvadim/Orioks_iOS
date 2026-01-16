//
//  ScheduleViewController.swift
//  Orioks_iOS
//
//  Created by User on 22.11.2025.
//

import UIKit

class ScheduleViewController: UIViewController {

    // MARK: - UI Elements

    private let dropdownMenu = DropdownMenuView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Осенний семестр 2025/2026\n2-й знаменатель"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.bounces = false
        return scrollView
    }()
    
    // Контейнер для всего содержимого внутри ScrollView
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = -1 // Чтобы границы ячеек перекрывались
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: - Data Mock
    
    private let days = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"]
    private let times = [
        ("1\nпара", "09:00\n10:30"),
        ("2\nпара", "10:40\n12:10"),
        ("3\nпара", "12:40\n14:10"),
        ("4\nпара", "14:20\n15:50"),
        ("5\nпара", "16:20\n17:50"),
        ("6\nпара", "18:00\n19:30"),
        ("7\nпара", "19:40\n21:10")
    ]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupLayout()
        buildScheduleGrid()
        
        // Меню добавляется последним, чтобы перекрывать остальной контент
        setupDropdownMenu()
    }

    // MARK: - Layout Setup

    private func setupNavigationBar() {
        let menuButton = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal"),
            style: .plain,
            target: self,
            action: #selector(menuButtonTapped)
        )
        menuButton.tintColor = .black
        // Присваиваем кнопку правому бару
        navigationItem.rightBarButtonItem = menuButton
        navigationItem.title = "Расписание"
    }

    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            // ScrollView
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            // Content StackView (Grid)
            contentStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupDropdownMenu() {
        view.addSubview(dropdownMenu)
        dropdownMenu.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dropdownMenu.topAnchor.constraint(equalTo: view.topAnchor),
            dropdownMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dropdownMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dropdownMenu.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        dropdownMenu.delegate = self
    }

    // MARK: - Grid Building

    private func buildScheduleGrid() {
        // 1. Создаем строку заголовков (Дни недели)
        let headerRow = UIStackView()
        headerRow.axis = .horizontal
        headerRow.spacing = -1
        
        // Пустая ячейка в левом верхнем углу (для колонки времени)
        let cornerCell = createCell(text: "", width: 60, isHeader: true)
        headerRow.addArrangedSubview(cornerCell)

        for day in days {
            let cell = createCell(text: day, width: 140, isHeader: true)
            headerRow.addArrangedSubview(cell)
        }
        contentStackView.addArrangedSubview(headerRow)

        // 2. Создаем строки с парами
        for (index, timeData) in times.enumerated() {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = -1
            rowStack.distribution = .fill

            // Колонка времени (левая)
            let timeText = "\(timeData.0)\n\n\(timeData.1)"
            let timeCell = createCell(text: timeText, width: 60, isHeader: true)
            rowStack.addArrangedSubview(timeCell)

            // Ячейки расписания для каждого дня
            for dayIndex in 0..<days.count {
                var text = ""
                // Пример заполнения (имитация данных со скриншота)
                if (index == 0 && (dayIndex == 0 || dayIndex == 2 || dayIndex == 4)) {
                     text = "Аудитория практической подготовки 24 |\nПрактическая подготовка"
                } else if (index == 1 && (dayIndex == 0 || dayIndex == 2 || dayIndex == 4)) {
                    text = "Аудитория практической подготовки 24 |\nПрактическая подготовка"
                } else if (index == 2 && (dayIndex == 0 || dayIndex == 2 || dayIndex == 4)) {
                    text = "Аудитория практической подготовки 24 |\nПрактическая подготовка"
                } else if (index == 3 && (dayIndex == 0 || dayIndex == 2 || dayIndex == 4)) {
                    text = "Аудитория практической подготовки 24 |\nПрактическая подготовка"
                }

                let classCell = createCell(text: text, width: 140, isHeader: false)
                rowStack.addArrangedSubview(classCell)
            }

            contentStackView.addArrangedSubview(rowStack)
        }
    }

    // MARK: - Helper Factory

    private func createCell(text: String, width: CGFloat, isHeader: Bool) -> UIView {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.lightGray.cgColor
        container.translatesAutoresizingMaskIntoConstraints = false
        
        // Фиксированная ширина для создания сетки
        container.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        // Для строк контента задаем минимальную высоту, чтобы вместить текст
        if !isHeader {
             container.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        } else {
             container.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        }

        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = isHeader ? UIFont.boldSystemFont(ofSize: 12) : UIFont.systemFont(ofSize: 11)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 4),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -4),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -4)
        ])

        return container
    }
    
    // MARK: - Actions
    
    @objc private func menuButtonTapped() {
        if let navBar = navigationController?.navigationBar {
            dropdownMenu.toggle(below: navBar)
        } else {
            // Фолбек если нет нав бара
            let dummyView = UIView(frame: CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: 44))
            dropdownMenu.toggle(below: dummyView)
        }
    }
}

// MARK: - DropdownMenuDelegate

extension ScheduleViewController: DropdownMenuDelegate {
    func didSelectMenuItem(_ item: MenuItem) {
        print("Selected item: \(item.title)")
        dropdownMenu.hide()
        // Здесь можно добавить логику перехода на другой экран
    }
    
    func didTapOutsideMenu() {
        dropdownMenu.hide()
    }
}
