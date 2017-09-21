//
//  CalendarViewController.swift
//  ScreeningDeveloper
//
//  Created by Jorge Carbonell O'farrill on 2017-08-19.
//  Copyright © 2017 Jorge Carbonell O'farrill. All rights reserved.
//

import UIKit
import JTAppleCalendar
import Kingfisher

class CalendarViewController: UIViewController {

    
    @IBOutlet weak var notificationTableView: UITableView!

    @objc let tableNotificationUpdateLabel = ["Your schedual for today is","Tomorrow schedual is","For this week schedual is","This month","For the 15 days"]

    @objc let outsideMonthColor = UIColor(colorWithHexValue: 0x346AA1)
    @objc let monthColor = UIColor.white
    @objc let selectedMonthColor = UIColor(colorWithHexValue: 0xEA142D)
    @objc let currentDateSelectedViewColor = UIColor(colorWithHexValue: 0xEA142D)

    @objc let formatter = DateFormatter()

    @IBOutlet weak var calendarView: JTAppleCalendarView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCalendarView()



        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var yearLabelCalendar: UILabel!

    @IBOutlet weak var monthLabelCalendar: UILabel!

    func handleColorSelected(view: JTAppleCell?,cellState: CellState) {
        guard let validCell = view as? CellJT else {return}
        if cellState.isSelected {
            validCell.dateLabel.textColor = selectedMonthColor
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = monthColor
            } else {
                validCell.dateLabel.textColor = outsideMonthColor
            }
        }


    }

    func handleCellConfig(view: JTAppleCell?,cellState: CellState) {
        guard let validCell = view as? CellJT else {return}

        if validCell.isSelected {
            validCell.selectedView.isHidden = false
        } else {
            validCell.selectedView.isHidden = true
        }
    }

    func setupViewOfCalendar(from visibleDate: DateSegmentInfo)  {
        let date = visibleDate.monthDates.first!.date
        self.formatter.dateFormat = "yyyy"
        self.yearLabelCalendar.text = self.formatter.string(from: date)
        self.formatter.dateFormat = "MMMM"
        self.monthLabelCalendar.text = self.formatter.string(from: date)
    }

    @objc func setupCalendarView() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0

        calendarView.visibleDates { (visibleDates) in
           self.setupViewOfCalendar(from: visibleDates)
        }
    }

    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewOfCalendar(from: visibleDates)

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CalendarViewController: JTAppleCalendarViewDataSource {


    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {

        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale

        let startDate = formatter.date(from: "2017 01 01")
        let endDate = formatter.date(from: "2017 12 31")

        let parameters = ConfigurationParameters(startDate: startDate! , endDate: endDate!)

        return parameters

    }



}

extension CalendarViewController: JTAppleCalendarViewDelegate {


    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell  = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CellCal", for: indexPath) as! CellJT
        cell.dateLabel.text = cellState.text

        handleCellConfig(view: cell, cellState: cellState)
        handleColorSelected(view: cell, cellState: cellState)



        return cell
    }

    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {


        handleCellConfig(view: cell, cellState: cellState)
        handleColorSelected(view: cell, cellState: cellState)
    }

    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {


        handleCellConfig(view: cell, cellState: cellState)
        handleColorSelected(view: cell, cellState: cellState)

    }
}

extension UIColor {
    @objc convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0) {
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green:CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat((value & 0x0000FF) ) / 255.0,
            alpha: alpha

        )
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableNotificationUpdateLabel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notificationTableView.dequeueReusableCell(withIdentifier: "cellCall") as! CalendarTableViewCell
        cell.textLabel?.text = tableNotificationUpdateLabel[indexPath.row]
        

        return cell
    }
}


