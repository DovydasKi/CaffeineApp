//
//  MeetupTopicsWithSelectionTableView.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-04-03.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class MeetupTopicsWithSelectionTableView: NSObject, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView
    var refreshControl = UIRefreshControl()
    private var topicArr = [TopicModal]()
    private var cellType = String()
    private var topicAmountLabel = UILabel ()

    init(tv: UITableView, withMultipleSelection: Bool, topicAmountLabel: UILabel) {
        self.tableView = tv
        self.tableView.showsVerticalScrollIndicator = true
        self.tableView.flashScrollIndicators()
        self.tableView.isUserInteractionEnabled = true
        self.topicAmountLabel = topicAmountLabel
        super.init()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.separatorColor = UIColor.clear
        self.tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        // Register all of your cells
        if withMultipleSelection {
            tableView.register(MeetupTopicsWithSelectionCustomTableViewCell.self, forCellReuseIdentifier: "MultipleCell")
            self.cellType = "MultipleCell"
            tableView.allowsMultipleSelection = true
        } else {
            tableView.register(MeetupTopicsCustomTableViewCell.self, forCellReuseIdentifier: "SingleCell")
            self.cellType = "SingleCell"
        }
        self.readFromJSON()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        self.tableView.addSubview(refreshControl)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return self.topicArr.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.cellType {
        case "SingleCell":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SingleCell", for: indexPath) as? MeetupTopicsCustomTableViewCell else { fatalError("Unable to create cell") }
            cell.meetupPurposeLabel.text = self.topicArr[indexPath.row].meetupPurpose
            return cell
        case "MultipleCell":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MultipleCell", for: indexPath) as? MeetupTopicsWithSelectionCustomTableViewCell else { fatalError("Unable to create cell") }
            cell.meetupPurposeLabel.text = self.topicArr[indexPath.row].meetupPurpose
            cell.selectionStyle = .none

            return cell
        default:
            break
        }
        return MeetupTopicsCustomTableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.cellType == "MultipleCell" {
            //TODO: new filed in TopicModal and probably new json file
            let filteredArr = self.topicArr.filter {$0.isSelected == true}
            //self.topicAmountLabel.text = "Iš viso: \(String(describing: filteredArr.count))"
            print(filteredArr.count)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if self.cellType == "MultipleCell" {
            //TODO: new filed in TopicModal and probably new json file
            let filteredArr = self.topicArr.filter {$0.isSelected == false}
            //self.topicAmountLabel.text = "Iš viso: \(String(describing: filteredArr.count))"
            print(filteredArr.count)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 64 }

}

//MARK: Helper functions
extension MeetupTopicsWithSelectionTableView {
    @objc func refresh(sender: AnyObject) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.readFromJSON()
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func insertValue(meetupPurpose: String) {
        self.topicArr.insert(TopicModal(meetupPurpose: meetupPurpose, isSelected: true), at: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
        tableView.endUpdates()
        tableView.selectRow(at: IndexPath.init(row: 0, section: 0), animated: false, scrollPosition: .none)
        self.writeToJSON()
    }

    func deleteValue(indexPath: IndexPath) {
        self.topicArr.remove(at: indexPath.row)
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        self.tableView.endUpdates()
        self.writeToJSON()
    }

    private func writeToJSON() {
        do {
            let fileURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("example.json")

            try JSONEncoder().encode(self.topicArr)
                .write(to: fileURL)
        } catch {
            print(error)
        }
    }

    private func readFromJSON() {
        if !topicArr.isEmpty {
            topicArr.removeAll()
        }
        do {
            let fileURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("example.json")

            let data = try Data(contentsOf: fileURL)
            let topics = try JSONDecoder().decode([TopicModal].self, from: data)
            for topic in topics {
                if topic.isSelected == true {
                    self.topicArr.append(topic)
                }
            }
        } catch {
            print(error)
        }
    }

    public func getTopicArr() -> [TopicModal] {
        return self.topicArr
    }
}
