//
//  CVCalendarController.swift
//  SwiftPods
//
//  Created by ZZJ on 2022/4/1.
//  Copyright © 2022 天天. All rights reserved.
//

import UIKit
import SnapKit
import CVCalendar

class CVCalendarController: UIViewController {
    lazy var topCalendarView: BTNCalendar = {
        let calendar = BTNCalendar()

        return calendar
    }()
    
    var label: UILabel = {
        let bale = UILabel()
        bale.font = .systemFont(ofSize: 14)
        bale.numberOfLines = 0
        return bale
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        topCalendarView.frame = CGRect.init(x: 18, y: 15, width: view.frame.width - 36, height: 355)
        view.addSubview(topCalendarView)
        
        label.frame = CGRect.init(x: 12, y: topCalendarView.frame.maxY + 20, width: view.frame.width - 24, height: 300)
        view.addSubview(label)
        
        label.text = """
                  1. 选中的日期切换后消失，且选中的日期不能再次被点击
                  2. 默认选中今天，后面每月第一天将被选中，取消选中后都不被选中
                  3. cell自定义度较小，只能修改文本的大小颜色背景色等，不能自定义
                """
        
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


class BTNCalendar: UIView {

    var viewCalendarMenu: CVCalendarMenuView!
    var viewCalendar: CVCalendarView!
    
    private var selectedDay: DayView!
    private var currentCalendar = Calendar(identifier: .gregorian)
    private var changeDate: CVDate = CVDate(date: Date())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.backgroundColor = .white

        viewCalendarMenu = CVCalendarMenuView()
        viewCalendarMenu.menuViewDelegate = self
        addSubview(viewCalendarMenu)
        
        viewCalendar = CVCalendarView()
        viewCalendar.bounds = CGRect.init(x: 0, y: 0, width: 375, height: 55)
        viewCalendar.calendarDelegate = self
        viewCalendar.appearance.dayLabelPresentWeekdayTextColor = UIColor.colorFromCode(0x1D62F0)
        viewCalendar.calendarAppearanceDelegate = self
        addSubview(viewCalendar)
        
        viewCalendarMenu.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(34)
        }

        viewCalendar.snp.makeConstraints { make in
            make.top.equalTo(viewCalendarMenu.snp.bottom)
            make.left.right.equalTo(0)
            make.bottom.equalTo(-10)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.borderCorners([.bottomLeft, .bottomRight], radius: 20.0)
        viewCalendarMenu.commitMenuViewUpdate()
        viewCalendar.commitCalendarViewUpdate()
        print(viewCalendar.frame.height)
    }
    
    fileprivate var autoSelect = true
    
}

// MARK: - CVCalendarMenuViewDelegate
extension BTNCalendar: CVCalendarMenuViewDelegate {
    // 改变某个星期的标题颜色
    func dayOfWeekTextColor(by weekday: Weekday) -> UIColor {
        return UIColor.hexString("#A8A8AE")
    }
    
    func dayOfWeekBackGroundColor() -> UIColor { return .white }
    
    func dayOfWeekTextColor() -> UIColor { return UIColor.hexString("#A8A8AE") }
    
    func dayOfWeekFont() -> UIFont { return .systemFont(ofSize: 10.0, weight: .medium) }
    
    func weekdaySymbolType() -> WeekdaySymbolType { return .veryShort }
    
}

// MARK: - CVCalendarViewDelegate
extension BTNCalendar: CVCalendarViewDelegate  {
    // MARK: Required methods
    
    func presentationMode() -> CalendarMode { return .monthView }
    func firstWeekday() -> Weekday { return .sunday }
    
    // MARK: Optional methods
    //是否允许动态的尺寸缩放，默认你true
    func shouldAnimateResizing() -> Bool { return true }
    /*
    func toggleDateAnimationDuration() -> Double { return 0.3 }
     // 不在本月的日期是否可以点击滑动到那个月
    func shouldScrollOnOutDayViewSelection() -> Bool { return false }
     */
    
    func shouldAutoSelectDayOnWeekChange() -> Bool {
        return autoSelect
    }
    
    //切换月份时日历是否自动选择某一天（本月为今天，其他月为第一天）
    func shouldAutoSelectDayOnMonthChange() -> Bool {
        return autoSelect
    }
    //是否允许突出显示某个日期
    func shouldShowWeekdaysOut() -> Bool { return true }
    //设置某个日期是否可被选中
    func shouldSelectDayView(_ dayView: DayView) -> Bool {
        return true
    }
    //某个日期被选中的回调
    func didSelectDayView(_ dayView: DayView, animationDidFinish: Bool) {
        autoSelect = false
        selectedDay = dayView
    }
    //当前日历的年月
    func presentedDateUpdated(_ date: CVDate) {
        autoSelect = false
        print(date.globalDescription)
        print(viewCalendar.frame.height)
    }
    //是否允许在每个日期上方添加横线（形成每行的分割线）
    func topMarker(shouldDisplayOnDayView dayView: DayView) -> Bool {
        return false
    }
    //
    func shouldHideTopMarkerOnPresentedView() -> Bool {
        return true
    }
    /*
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: DayView) -> Bool
    func dotMarker(shouldShowOnDayView dayView: DayView) -> Bool
    func dotMarker(colorOnDayView dayView: DayView) -> [UIColor]
    func dotMarker(moveOffsetOnDayView dayView: DayView) -> CGFloat
    func dotMarker(sizeOnDayView dayView: DayView) -> CGFloat
*/
    // 设置选中区域的贝塞尔路径
    func selectionViewPath() -> ((CGRect) -> (UIBezierPath)) {
        return { UIBezierPath(rect: CGRect(x: 0, y: 0, width: $0.width, height: $0.height)) }
    }
    // 是否允许显示自定义的单独选区
    func shouldShowCustomSingleSelection() -> Bool {
        //是否使用 selectionViewPath 返回的贝塞尔曲线
        return false
        
    }

    // 用来设置显示在日期上的辅助视图
    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        dayView.setNeedsLayout()
        dayView.layoutIfNeeded()
        
        // 使用的背景样式
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.frame, shape: CVShape.circle)
        circleView.fillColor = .white //.colorFromCode(0xCCCCCC)
        return circleView
    }
    // 用来设置是否允许在日期视图上显示一个辅助视图
    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        if (dayView.isCurrentDay) {
            return true
        }
        return false
    }

    // 用来设置补充视图
    func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
        return UIView()
    }
    // 用来设置在何种情况下，允许显示辅助视图
    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        return true
    }
    
/*
    // 下一个月
    func didShowNextMonthView(_ date: Foundation.Date)
    // 上一个月
    func didShowPreviousMonthView(_ date: Foundation.Date)
    // 下一周
    func didShowNextWeekView(from startDayView: DayView, to endDayView: DayView)
    // 上一周
    func didShowPreviousWeekView(from startDayView: DayView, to endDayView: DayView)
  */
    // Localization
    func calendar() -> Calendar? { return currentCalendar }
    
    // Range selection
    // 是否允许范围选择
    func shouldSelectRange() -> Bool{
        return false
    }
    //选中的日期的范围
    func didSelectRange(from startDayView: DayView, to endDayView: DayView){
        print("Range Select: \(startDayView.date.commonDescription) to \(endDayView.date.commonDescription)")
    }
    /*
     //无法滚动到指定日期前的日历
    func disableScrollingBeforeDate() -> Date
    func disableScrollingBeyondDate() -> Date
    //范围选择可跨越的最大天数
    func maxSelectableRange() -> Int
     //最早的可选时间
    func earliestSelectableDate() -> Date
     //最迟的可选时间
    func latestSelectableDate() -> Date
    */
    
}

// MARK: - CVCalendarViewAppearanceDelegate
extension BTNCalendar: CVCalendarViewAppearanceDelegate {
    
    func dayLabelBackgroundColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        if present == .present {
            return UIColor.colorFromCode(0x1D62F0)
        }
        
        return nil
    }
    
    //选中的日期的背景色
    func dayLabelWeekdaySelectedBackgroundColor() -> UIColor {
        return UIColor.colorFromCode(0x1D62F0)
    }
    //选中当天的背景色
    func dayLabelPresentWeekdaySelectedBackgroundColor() -> UIColor {
        return UIColor.colorFromCode(0x1D62F0)
    }
    func dayLabelPresentWeekdaySelectedTextColor() -> UIColor {
        return .white
    }
    // 今天日期的颜色
    func dayLabelPresentWeekdayTextColor() -> UIColor {
        return UIColor.colorFromCode(0x1D62F0)
    }
    
}
