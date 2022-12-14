//
//  CalendarView.swift
//  MobDevFactoryApp
//
//  Created by Мария Вольвакова on 09.09.2022.
//

import UIKit
import FSCalendar

class CalendarView: UIView {
    
    // MARK: - Properties
    
    lazy var toggle = UISwitch()
    lazy var formatter = DateFormatter()
    
    lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Неделя", "Месяц"])
        segmentControl.selectedSegmentTintColor = .orange
        segmentControl.backgroundColor = .systemGroupedBackground
        return segmentControl
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tintColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "back")
        tableView.separatorColor = .darkGray
        tableView.separatorInsetReference = .fromCellEdges
        tableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: CalendarTableViewCell.identifier)
        tableView.rowHeight = 50
        return tableView
    }()
    
    lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.scrollDirection = .horizontal
        calendar.appearance.weekdayTextColor = .brown
        calendar.appearance.titleTodayColor = .white
        calendar.appearance.todayColor = .darkGray
        calendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 16)
        calendar.appearance.headerDateFormat = "LLLL, yyyy"
        calendar.appearance.headerTitleFont = .systemFont(ofSize: 20, weight: .heavy)
        calendar.appearance.headerTitleColor = .brown
        calendar.appearance.headerTitleAlignment = .center
        calendar.collectionView.tintColor = .orange
        calendar.appearance.imageOffset = CGPoint(x: 0, y: 5)
        calendar.locale = Locale(identifier: "ru_RU")
        calendar.allowsMultipleSelection = false
        calendar.firstWeekday = 2
        calendar.placeholderType = .fillSixRows
        calendar.backgroundColor = .systemGroupedBackground
        calendar.layer.cornerRadius = 20
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "cell")
        return calendar
    }()
    
    // MARK: - Initial
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    // MARK: - Settings
    
    func setupView() {
        backgroundColor = Metric.colorBackround
        tintColor = .white
    }
    
    func setupHierarchy() {
        addSubview(segmentControl)
        addSubview(calendar)
        addSubview(tableView)
        
    }
    
    func setupLayout() {
        
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalTo(calendar.snp.left).offset(20)
            make.right.equalTo(calendar.snp.right).offset(-20)
        }
        
        calendar.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(15)
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(15)
            make.right.equalTo(safeAreaLayoutGuide.snp.right).offset(-15)
            make.height.equalTo(300)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(30)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-15)
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(15)
            make.right.equalTo(safeAreaLayoutGuide.snp.right).offset(-15)
        }
    }
    
    func remakeCalendarConstraints(bounds: CGRect) {
        calendar.snp.remakeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(15)
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(safeAreaLayoutGuide.snp.right).offset(-20)
            make.height.equalTo(Int(bounds.height))
        }
    }
}

