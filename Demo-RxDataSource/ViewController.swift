//
//  ViewController.swift
//  Demo-RxDataSource
//
//  Created by NishiokaKohei on 15/06/2019.
//  Copyright © 2019 Takumi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

private let cellIdentifier = "Cell"

final class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

        tableView.rx.setDelegate(self).disposed(by: disposeBag)

        let dataSource = RxTableViewSectionedAnimatedDataSource<SectionOfCustomData>(configureCell: { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            cell.textLabel?.text = "Item \(item.anInt): \(item.aString) - \(item.aCGPoint.x):\(item.aCGPoint.y)"
            return cell
        })

        dataSource.titleForHeaderInSection = { dataSource, section -> String in
            return dataSource.sectionModels[section].header
        }
        dataSource.canMoveRowAtIndexPath = { dataSource, indexPath -> Bool in
            return true
        }
        dataSource.canEditRowAtIndexPath = { dataSource, indexPath in
            return true
        }

        dataSource.animationConfiguration
            = AnimationConfiguration(insertAnimation: UITableView.RowAnimation.automatic,
                                     reloadAnimation: UITableView.RowAnimation.automatic,
                                     deleteAnimation: UITableView.RowAnimation.automatic)

        let sections = [
            SectionOfCustomData(
                header: "First section",
                items: [
                    CustomData(anInt: 0, aString: "zero", aCGPoint: CGPoint.zero),
                    CustomData(anInt: 1, aString: "one", aCGPoint: CGPoint(x: 1, y: 1))
                ]
            ),
            SectionOfCustomData(
                header: "Second section",
                items: [
                    CustomData(anInt: 2, aString: "two", aCGPoint: CGPoint(x: 2, y: 2)),
                    CustomData(anInt: 3, aString: "three", aCGPoint: CGPoint(x: 3, y: 3))
                ]
            )
        ]

        Observable.just(sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
}
