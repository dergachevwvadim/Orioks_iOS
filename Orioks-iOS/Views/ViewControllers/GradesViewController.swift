//
//  GradesViewController.swift
//  Orioks_iOS
//
//  Created by User on 22.11.2025.
//

import UIKit

class GradesViewController: UIViewController {

    // MARK: - UI Elements

    private let dropdownMenu = DropdownMenuView()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()

    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        // ИСПРАВЛЕНИЕ: правильное имя свойства isLayoutMarginsRelativeArrangement
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 16, bottom: 30, right: 16)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupLayout()
        buildContent()
        setupDropdownMenu()
    }

    // MARK: - Layout Setup

    private func setupNavigationBar() {
        title = "ОРИОКС"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.2, green: 0.5, blue: 0.75, alpha: 1.0) // Синий цвет шапки
        navigationController?.navigationBar.isTranslucent = false
        
        let menuButton = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal"),
            style: .plain,
            target: self,
            action: #selector(menuButtonTapped)
        )
        menuButton.tintColor = .white
        navigationItem.rightBarButtonItem = menuButton
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
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

    // MARK: - Content Building

    private func buildContent() {
        // 1. Breadcrumbs
        let breadcrumbsLabel = UILabel()
        breadcrumbsLabel.text = "ГЛАВНАЯ  /  ОБУЧЕНИЕ  /  ИНСТРУКЦИИ"
        breadcrumbsLabel.font = .systemFont(ofSize: 12)
        breadcrumbsLabel.textColor = .systemBlue
        
        let breadcrumbsContainer = UIView()
        breadcrumbsContainer.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        breadcrumbsContainer.layer.borderWidth = 1
        breadcrumbsContainer.layer.borderColor = UIColor.systemGray5.cgColor
        breadcrumbsContainer.addSubview(breadcrumbsLabel)
        breadcrumbsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            breadcrumbsLabel.topAnchor.constraint(equalTo: breadcrumbsContainer.topAnchor, constant: 10),
            breadcrumbsLabel.bottomAnchor.constraint(equalTo: breadcrumbsContainer.bottomAnchor, constant: -10),
            breadcrumbsLabel.leadingAnchor.constraint(equalTo: breadcrumbsContainer.leadingAnchor, constant: 16),
            breadcrumbsLabel.trailingAnchor.constraint(equalTo: breadcrumbsContainer.trailingAnchor, constant: -16)
        ])
        contentStackView.addArrangedSubview(breadcrumbsContainer)

        // 2. Banner
        let bannerView = UIView()
        bannerView.backgroundColor = UIColor(red: 0.85, green: 0.55, blue: 0.2, alpha: 1.0) // Orange-ish
        let bannerLabel = UILabel()
        bannerLabel.text = "Тест на ЖИЗНЕСТОЙКОСТЬ (добровольный):\nсамоконтроль, принятие риска, вовлеченность!"
        bannerLabel.textColor = .white
        bannerLabel.font = .systemFont(ofSize: 14)
        bannerLabel.numberOfLines = 0
        bannerView.addSubview(bannerLabel)
        bannerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerLabel.topAnchor.constraint(equalTo: bannerView.topAnchor, constant: 15),
            bannerLabel.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: -15),
            bannerLabel.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor, constant: 16),
            bannerLabel.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor, constant: -16)
        ])
        contentStackView.addArrangedSubview(bannerView)

        // 3. Disciplines Section
        let disciplinesHeaderStack = UIStackView()
        disciplinesHeaderStack.axis = .horizontal
        disciplinesHeaderStack.distribution = .equalSpacing
        
        let discTitle = UILabel()
        discTitle.text = "Дисциплины"
        discTitle.font = .boldSystemFont(ofSize: 18)
        discTitle.textColor = .darkGray
        
        let scoreLabel = UILabel()
        scoreLabel.text = " балл "
        scoreLabel.backgroundColor = .systemGray5
        scoreLabel.textColor = .gray
        scoreLabel.font = .systemFont(ofSize: 12)
        scoreLabel.layer.masksToBounds = true
        
        disciplinesHeaderStack.addArrangedSubview(discTitle)
        disciplinesHeaderStack.addArrangedSubview(scoreLabel)
        contentStackView.addArrangedSubview(disciplinesHeaderStack)
        
        // Rows
        contentStackView.addArrangedSubview(createDisciplineRow(title: "Производственная практика\n(эксплуатационная практика)", score: 100))
        contentStackView.addArrangedSubview(createSeparator())
        contentStackView.addArrangedSubview(createDisciplineRow(title: "Государственная итоговая\nаттестация", score: 0))

        // 4. Info Section (Boxed)
        let infoContainer = UIView()
        infoContainer.layer.borderWidth = 1
        infoContainer.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        
        let infoStack = UIStackView()
        infoStack.axis = .vertical
        infoStack.spacing = 8
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        
        infoStack.addArrangedSubview(createLabelPair(boldText: "Направление:", normalText: " Информатика и вычислительная техника"))
        infoStack.addArrangedSubview(createLabelPair(boldText: "Профиль:", normalText: " Проектирование и эксплуатация ИТ-инфраструктуры (очно-заочная форма)"))
        
        let linkLabel = UILabel()
        linkLabel.text = "09.03.01 Учебный план 2021"
        linkLabel.textColor = .systemBlue
        linkLabel.font = .systemFont(ofSize: 14)
        infoStack.addArrangedSubview(linkLabel)
        
        // Form Controls (Mock)
        infoStack.addArrangedSubview(createFormRow(label: "Семестр:", value: "2025 - 2026 год, 1 семестр"))
        
        let changeLabel = UILabel()
        changeLabel.text = "Сменить"
        changeLabel.textColor = .systemBlue
        changeLabel.font = .systemFont(ofSize: 14)
        infoStack.addArrangedSubview(changeLabel)
        
        infoStack.addArrangedSubview(createFormRow(label: "Учетная запись:", value: "ИВТ-51В (2021 г., бакалавры)"))

        infoContainer.addSubview(infoStack)
        NSLayoutConstraint.activate([
            infoStack.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: 16),
            infoStack.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: -16),
            infoStack.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 16),
            infoStack.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -16)
        ])
        contentStackView.addArrangedSubview(infoContainer)
        
        // 5. Action Button
        let actionContainer = UIView()
        actionContainer.layer.borderWidth = 1
        actionContainer.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        actionContainer.backgroundColor = .white // or very light gray
        
        let actionLabel = UILabel()
        actionLabel.text = "Получить обходной лист"
        actionLabel.textColor = .systemBlue
        actionLabel.font = .systemFont(ofSize: 16)
        
        actionContainer.addSubview(actionLabel)
        actionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actionLabel.topAnchor.constraint(equalTo: actionContainer.topAnchor, constant: 20),
            actionLabel.bottomAnchor.constraint(equalTo: actionContainer.bottomAnchor, constant: -20),
            actionLabel.leadingAnchor.constraint(equalTo: actionContainer.leadingAnchor, constant: 16)
        ])
        contentStackView.addArrangedSubview(actionContainer)
        
        // 6. Upcoming Classes
        let upcomingContainer = UIView()
        upcomingContainer.layer.borderWidth = 1
        upcomingContainer.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        
        let upcomingStack = UIStackView()
        upcomingStack.axis = .vertical
        upcomingStack.spacing = 10
        upcomingStack.translatesAutoresizingMaskIntoConstraints = false
        
        let upTitle = UILabel()
        upTitle.text = "Предстоящие занятия"
        upTitle.font = .boldSystemFont(ofSize: 18)
        upTitle.textColor = .darkGray
        upcomingStack.addArrangedSubview(upTitle)
        
        let dateLabel = UILabel()
        dateLabel.text = "Пятница 09/01"
        dateLabel.font = .systemFont(ofSize: 16)
        dateLabel.textColor = .black
        upcomingStack.addArrangedSubview(dateLabel)
        
        upcomingStack.addArrangedSubview(createSeparator())
        
        // Class Info
        let classRow = UIStackView()
        classRow.axis = .horizontal
        classRow.alignment = .top
        classRow.spacing = 15
        
        let timeLabel = UILabel()
        timeLabel.text = "09:00"
        timeLabel.font = .systemFont(ofSize: 15)
        
        let classDetailStack = UIStackView()
        classDetailStack.axis = .vertical
        classDetailStack.spacing = 4
        
        let className = UILabel()
        className.text = "Практическая подготовка (12 пар)"
        className.numberOfLines = 0
        className.font = .systemFont(ofSize: 15)
        
        let roomLabel = UILabel()
        roomLabel.text = " Ауд. практ. подг. 24 "
        roomLabel.backgroundColor = UIColor(red: 0.4, green: 0.7, blue: 0.9, alpha: 0.5)
        roomLabel.font = .systemFont(ofSize: 12)
        roomLabel.textColor = .darkGray
        roomLabel.layer.masksToBounds = true
        roomLabel.sizeToFit()
        
        // Wrap room label to not stretch
        let roomContainer = UIView()
        roomContainer.addSubview(roomLabel)
        roomLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roomLabel.leadingAnchor.constraint(equalTo: roomContainer.leadingAnchor),
            roomLabel.topAnchor.constraint(equalTo: roomContainer.topAnchor),
            roomLabel.bottomAnchor.constraint(equalTo: roomContainer.bottomAnchor),
            roomLabel.trailingAnchor.constraint(lessThanOrEqualTo: roomContainer.trailingAnchor)
        ])
        
        classDetailStack.addArrangedSubview(className)
        classDetailStack.addArrangedSubview(roomContainer)
        
        classRow.addArrangedSubview(timeLabel)
        classRow.addArrangedSubview(classDetailStack)
        
        upcomingStack.addArrangedSubview(classRow)
        
        upcomingContainer.addSubview(upcomingStack)
        NSLayoutConstraint.activate([
            upcomingStack.topAnchor.constraint(equalTo: upcomingContainer.topAnchor, constant: 16),
            upcomingStack.bottomAnchor.constraint(equalTo: upcomingContainer.bottomAnchor, constant: -16),
            upcomingStack.leadingAnchor.constraint(equalTo: upcomingContainer.leadingAnchor, constant: 16),
            upcomingStack.trailingAnchor.constraint(equalTo: upcomingContainer.trailingAnchor, constant: -16)
        ])
        contentStackView.addArrangedSubview(upcomingContainer)
    }

    // MARK: - Helpers

    private func createDisciplineRow(title: String, score: Int) -> UIView {
        let row = UIStackView()
        row.axis = .horizontal
        row.alignment = .center
        row.spacing = 8
        
        let nameLabel = UILabel()
        nameLabel.text = title
        nameLabel.numberOfLines = 0
        nameLabel.font = .systemFont(ofSize: 14)
        nameLabel.textColor = .black
        
        let outOfLabel = UILabel()
        outOfLabel.text = "из 100"
        outOfLabel.font = .systemFont(ofSize: 12)
        outOfLabel.textColor = .gray
        
        let scoreButton = UIButton(type: .custom) // Явно указываем custom, чтобы избежать проблем с цветами
        scoreButton.setTitle("\(score)", for: .normal)
        scoreButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        scoreButton.backgroundColor = score > 50 ? .systemGreen : .systemRed
        scoreButton.layer.cornerRadius = 4
        
        // ИСПРАВЛЕНИЕ: обработка deprecated contentEdgeInsets
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
            // Важно: в конфигурации по умолчанию цвет заголовка может переопределяться, вернем его к белому (как у custom кнопки)
            config.baseForegroundColor = .white
            
            // Чтобы конфигурация не перекрывала backgroundColor уровня UIView
            config.background.backgroundColor = .clear
            
            // Применяем заголовок через конфигурацию для консистентности
            var container = AttributeContainer()
            container.font = UIFont.boldSystemFont(ofSize: 14)
            config.attributedTitle = AttributedString("\(score)", attributes: container)
            
            scoreButton.configuration = config
        } else {
            scoreButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
            scoreButton.setTitleColor(.white, for: .normal)
        }
        
        // Constraint to make nameLabel take available space
        row.addArrangedSubview(nameLabel)
        row.addArrangedSubview(outOfLabel)
        row.addArrangedSubview(scoreButton)
        
        // Ensure static widths for right elements
        outOfLabel.setContentHuggingPriority(.required, for: .horizontal)
        scoreButton.setContentHuggingPriority(.required, for: .horizontal)
        
        return row
    }
    
    private func createLabelPair(boldText: String, normalText: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        let attributedText = NSMutableAttributedString(string: boldText, attributes: [.font: UIFont.boldSystemFont(ofSize: 15), .foregroundColor: UIColor.darkGray])
        attributedText.append(NSAttributedString(string: normalText, attributes: [.font: UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor.black]))
        label.attributedText = attributedText
        return label
    }
    
    private func createFormRow(label: String, value: String) -> UIView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        
        let titleLbl = UILabel()
        titleLbl.text = label
        titleLbl.font = .boldSystemFont(ofSize: 15)
        titleLbl.textColor = .darkGray
        titleLbl.setContentHuggingPriority(.required, for: .horizontal)
        
        let valueContainer = UIView()
        valueContainer.layer.borderWidth = 1
        valueContainer.layer.borderColor = UIColor.lightGray.cgColor
        valueContainer.layer.cornerRadius = 2
        
        let valLbl = UILabel()
        valLbl.text = value
        valLbl.font = .systemFont(ofSize: 13)
        valLbl.textColor = .darkGray
        
        let arrow = UIImageView(image: UIImage(systemName: "chevron.down"))
        arrow.tintColor = .gray
        arrow.contentMode = .scaleAspectFit
        
        let hStack = UIStackView(arrangedSubviews: [valLbl, arrow])
        hStack.axis = .horizontal
        hStack.spacing = 5
        hStack.alignment = .center
        hStack.distribution = .fill
        
        valueContainer.addSubview(hStack)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: valueContainer.topAnchor, constant: 6),
            hStack.bottomAnchor.constraint(equalTo: valueContainer.bottomAnchor, constant: -6),
            hStack.leadingAnchor.constraint(equalTo: valueContainer.leadingAnchor, constant: 8),
            hStack.trailingAnchor.constraint(equalTo: valueContainer.trailingAnchor, constant: -8),
            arrow.widthAnchor.constraint(equalToConstant: 12),
            arrow.heightAnchor.constraint(equalToConstant: 12)
        ])
        
        stack.addArrangedSubview(titleLbl)
        stack.addArrangedSubview(valueContainer)
        
        return stack
    }
    
    private func createSeparator() -> UIView {
        let line = UIView()
        line.backgroundColor = .systemGray5
        line.translatesAutoresizingMaskIntoConstraints = false
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return line
    }

    // MARK: - Actions

    @objc private func menuButtonTapped() {
        if let navBar = navigationController?.navigationBar {
            dropdownMenu.toggle(below: navBar)
        }
    }
}

// MARK: - DropdownMenuDelegate

extension GradesViewController: DropdownMenuDelegate {
    func didSelectMenuItem(_ item: MenuItem) {
        dropdownMenu.hide()
    }

    func didTapOutsideMenu() {
        dropdownMenu.hide()
    }
}
