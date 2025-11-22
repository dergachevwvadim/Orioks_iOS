//
//  DropdownMenuView.swift
//  Orioks_iOS
//
//  Created by User on 22.11.2025.
//

import UIKit

protocol DropdownMenuDelegate: AnyObject {
    func didSelectMenuItem(_ item: MenuItem)
    func didTapOutsideMenu()
}

final class DropdownMenuView: UIView {
    
    // MARK: - Properties
    weak var delegate: DropdownMenuDelegate?
    private let menuItems = MenuItem.sideMenuItems()
    
    private var isExpanded = false
    private let menuHeight: CGFloat = 600 // Высота меню
    
    // MARK: - UI Elements
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.backgroundColor = UIColor.alpha(0.5)
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let menuContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .orioksPrimary
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let notificationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let weekInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "📅 12 неделя\n2 знаменатель"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Дергачев В.В. ▼", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var menuTopConstraint: NSLayoutConstraint!
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupTableView()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        addSubview(overlayView)
        addSubview(menuContainerView)
        menuContainerView.addSubview(tableView)
        menuContainerView.addSubview(footerView)
        
        footerView.addSubview(notificationButton)
        footerView.addSubview(weekInfoLabel)
        footerView.addSubview(userButton)
    }
    
    private func setupConstraints() {
        menuTopConstraint = menuContainerView.topAnchor.constraint(equalTo: topAnchor, constant: -menuHeight)
        
        NSLayoutConstraint.activate([
            // Overlay
            overlayView.topAnchor.constraint(equalTo: topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Menu Container
            menuTopConstraint,
            menuContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuContainerView.heightAnchor.constraint(equalToConstant: menuHeight),
            
            // Table View
            tableView.topAnchor.constraint(equalTo: menuContainerView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: menuContainerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: menuContainerView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            
            // Footer
            footerView.leadingAnchor.constraint(equalTo: menuContainerView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: menuContainerView.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: menuContainerView.bottomAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 140),
            
            // Footer elements
            notificationButton.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 16),
            notificationButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            notificationButton.widthAnchor.constraint(equalToConstant: 30),
            notificationButton.heightAnchor.constraint(equalToConstant: 30),
            
            weekInfoLabel.topAnchor.constraint(equalTo: notificationButton.bottomAnchor, constant: 12),
            weekInfoLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            weekInfoLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20),
            
            userButton.topAnchor.constraint(equalTo: weekInfoLabel.bottomAnchor, constant: 12),
            userButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            userButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20),
            userButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DropdownMenuCell.self, forCellReuseIdentifier: DropdownMenuCell.identifier)
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(overlayTapped))
        overlayView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    @objc private func overlayTapped() {
        delegate?.didTapOutsideMenu()
    }
    
    // MARK: - Public Methods
    func toggle(below navigationBar: UIView) {
        isExpanded.toggle()
        
        let navigationBarHeight = navigationBar.frame.maxY
        
        if isExpanded {
            // Показываем меню
            menuTopConstraint.constant = navigationBarHeight
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                self.overlayView.alpha = 1
                self.layoutIfNeeded()
            }
        } else {
            // Скрываем меню
            menuTopConstraint.constant = -menuHeight
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
                self.overlayView.alpha = 0
                self.layoutIfNeeded()
            }
        }
    }
    
    func hide() {
        guard isExpanded else { return }
        isExpanded = false
        
        menuTopConstraint.constant = -menuHeight
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.overlayView.alpha = 0
            self.layoutIfNeeded()
        }
    }
}

// MARK: - UITableViewDataSource
extension DropdownMenuView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DropdownMenuCell.identifier,
            for: indexPath
        ) as? DropdownMenuCell else {
            return UITableViewCell()
        }
        
        let item = menuItems[indexPath.row]
        cell.configure(with: item)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DropdownMenuView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = menuItems[indexPath.row]
        delegate?.didSelectMenuItem(item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - Helper Extension
extension UIColor {
    static func alpha(_ alpha: CGFloat) -> UIColor {
        return UIColor.black.withAlphaComponent(alpha)
    }
}
