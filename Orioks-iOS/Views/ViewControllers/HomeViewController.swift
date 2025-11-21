//
//  HomeViewController.swift
//  Orioks_iOS
//
//  Created by User on 21.11.2025.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel = HomeViewModel()
    
    // MARK: - UI Elements
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "ОРИОКС"
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let menuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bannerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.85, green: 0.55, blue: 0.25, alpha: 1.0) // Оранжевый
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bannerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let quickLinksStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false // Scroll в scrollView
        return tableView
    }()
    
    private let sectionHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Новости"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupUI()
        setupConstraints()
        setupTableView()
        bindViewModel()
        
        viewModel.loadData()
    }
    
    // MARK: - Setup
    private func setupNavigation() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(headerView)
        headerView.addSubview(headerLabel)
        headerView.addSubview(menuButton)
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(bannerView)
        bannerView.addSubview(bannerLabel)
        
        contentView.addSubview(quickLinksStackView)
        contentView.addSubview(sectionHeaderLabel)
        contentView.addSubview(newsTableView)
        
        // Добавляем quick links
        setupQuickLinks()
    }
    
    private func setupQuickLinks() {
        let items = MenuItem.quickLinks()
        
        for item in items {
            let linkView = createQuickLinkView(item: item)
            quickLinksStackView.addArrangedSubview(linkView)
        }
    }
    
    private func createQuickLinkView(item: MenuItem) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton(type: .system)
        button.setTitle(item.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor(red: 0.29, green: 0.56, blue: 0.71, alpha: 1.0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if let iconName = item.icon {
            let icon = UIImage(systemName: iconName)
            button.setImage(icon, for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        }
        
        containerView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            button.topAnchor.constraint(equalTo: containerView.topAnchor),
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        return containerView
    }
    
    private func setupConstraints() {
        let contentHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentHeightConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            // Header
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 56),
            
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            
            menuButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            menuButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            menuButton.widthAnchor.constraint(equalToConstant: 44),
            menuButton.heightAnchor.constraint(equalToConstant: 44),
            
            // ScrollView 
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Content View
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentHeightConstraint,
            
            // Banner
            bannerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            bannerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bannerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            bannerLabel.topAnchor.constraint(equalTo: bannerView.topAnchor, constant: 16),
            bannerLabel.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor, constant: 16),
            bannerLabel.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor, constant: -16),
            bannerLabel.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: -16),
            
            // Quick Links
            quickLinksStackView.topAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: 24),
            quickLinksStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            quickLinksStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Section Header
            sectionHeaderLabel.topAnchor.constraint(equalTo: quickLinksStackView.bottomAnchor, constant: 32),
            sectionHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            sectionHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // News Table
            newsTableView.topAnchor.constraint(equalTo: sectionHeaderLabel.bottomAnchor, constant: 16),
            newsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            newsTableView.heightAnchor.constraint(equalToConstant: 600) // Временно фиксированная высота
        ])
    }
    
    private func setupTableView() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel.onNewsUpdated = { [weak self] in
            self?.newsTableView.reloadData()
            // Обновляем высоту таблицы
            self?.updateTableViewHeight()
        }
        
        viewModel.onBannerAvailable = { [weak self] text in
            self?.bannerLabel.text = text
        }
    }
    
    private func updateTableViewHeight() {
        newsTableView.layoutIfNeeded()
        let height = newsTableView.contentSize.height
        newsTableView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = height
            }
        }
    }
    
    // MARK: - Actions
    @objc private func menuButtonTapped() {
        print("Menu button tapped")
        // TODO: Показать боковое меню или action sheet
        showMenuOptions()
    }
    
    @objc private func quickLinkTapped(_ sender: UIButton) {
        let menuItem = MenuItem.quickLinks()[sender.tag]
        
        if let urlString = menuItem.url, let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    private func showMenuOptions() {
        let alert = UIAlertController(title: "Меню", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Практика", style: .default))
        alert.addAction(UIAlertAction(title: "Обучение", style: .default))
        alert.addAction(UIAlertAction(title: "Домашние задания", style: .default))
        alert.addAction(UIAlertAction(title: "Портфолио", style: .default))
        alert.addAction(UIAlertAction(title: "Проектная работа", style: .default))
        alert.addAction(UIAlertAction(title: "Зачётная книжка", style: .default))
        alert.addAction(UIAlertAction(title: "Заявки", style: .default))
        alert.addAction(UIAlertAction(title: "Электронные библиотеки", style: .default))
        alert.addAction(UIAlertAction(title: "Помощь", style: .default))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfNews
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsTableViewCell.identifier,
            for: indexPath
        ) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        
        if let newsItem = viewModel.newsItem(at: indexPath.row) {
            cell.configure(with: newsItem)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectNews(at: indexPath.row)
    }
}
