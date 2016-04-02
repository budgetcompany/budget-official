//
//  DashboardViewController.swift
//  Budget
//
//  Created by md10 on 3/18/16.
//  Copyright © 2016 Budget. All rights reserved.
//

import UIKit
import Charts

class DashboardViewController: UIViewController {

    @IBOutlet weak var lblBalancoTotal: UILabel!
    @IBOutlet weak var lblTotalDespesas: UILabel!
    @IBOutlet weak var lblTotalReceitas: UILabel!
    @IBOutlet var btnMenuSidebar: UIBarButtonItem!
    @IBOutlet var barChart: BarChartView!
    @IBOutlet var pieChartDespesas: PieChartView!
    @IBOutlet var pieChartReceitas: PieChartView!
    let dashboard:Dashboard = Dashboard()
    var drawChartLoaded:Bool = false
//    var zoom:CGFloat = 0.0
    func initDashboard(){
        lblBalancoTotal.text = dashboard.getTotalBalanco().convertToMoedaBr()
        lblTotalReceitas.text = dashboard.getTotalReceitas().convertToMoedaBr()
        lblTotalDespesas.text = dashboard.getTotalDespesas().convertToMoedaBr()
        
        let (months, balanco) = dashboard.getBalancoAnual()
        let (despesas, valorDespesas) = dashboard.getDespesasPorCategoria()
        let (receitas, valorReceitas) = dashboard.getReceitasPorCategoria()
//        print(Dashboard.getDespesasPorCategoria())
//        print(Dashboard.getReceitasPorCategoria())
        
        if(balanco.count > 0){
            setChartBalanco(months, values: balanco)
            barChart.opaque = true
        }
        
        if(valorDespesas.count > 0){
            setPieChart(despesas, values: valorDespesas, pieChart: pieChartDespesas)
            pieChartDespesas.opaque = true
        }
        
        if(valorReceitas.count > 0) {
            setPieChart(receitas, values: valorReceitas, pieChart: pieChartReceitas)
            pieChartReceitas.opaque = true
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnMenuSidebar.target = self.revealViewController()
        btnMenuSidebar.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    private func drawBarChartBalanco() {
        let xAxis = barChart.xAxis
        xAxis.labelPosition = .Bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.spaceBetweenLabels = 2
        
        let leftAxis = barChart.leftAxis
        leftAxis.labelPosition = .OutsideChart
        leftAxis.spaceTop = 0.15
        leftAxis.customAxisMin = 0
        leftAxis.labelFont = UIFont(name: "Futura", size: 10.0)!
        
        let rightAxis = barChart.rightAxis
        rightAxis.enabled = true
        rightAxis.drawGridLinesEnabled = false
        rightAxis.spaceTop = 0.15
        rightAxis.customAxisMin = 0
        rightAxis.labelFont = leftAxis.labelFont
        
        barChart.legend.position = .BelowChartLeft
        barChart.legend.form = .Square
        barChart.legend.formSize = 9.0
        barChart.legend.xEntrySpace = 4.0
        barChart.descriptionText = ""
    }
    
    private func setChartBalanco(months: [String], values: [Double]) {
        barChart.noDataText = "You need to provide data for the chart."
        
        var dataEntries:[BarChartDataEntry] = []
        for i in 0..<values.count {
            dataEntries.append(BarChartDataEntry(value: values[i], xIndex: i))
        }
        
        let dataSet = BarChartDataSet(yVals: dataEntries, label: "Balanço")
//        dataSet.valueFormatter?.positivePrefix = "R$ "
        let data = BarChartData(xVals: months, dataSet: dataSet)
        barChart.data = data
        
        if(!drawChartLoaded){
            drawBarChartBalanco()
            dataSet.barSpace = 0.35
            dataSet.valueFormatter = NSNumberFormatter()
            dataSet.valueFormatter?.minimumFractionDigits = 2
            data.setValueFont(UIFont(name: "Futura", size: 10.0))
            drawChartLoaded = true
        }
    }
    
    private func setPieChart(months: [String], values: [Double], pieChart:PieChartView) {
        
        pieChart.noDataText = "You need to provide data for the chart."
        
        var dataEntries:[ChartDataEntry] = []
        for i in 0..<values.count {
            dataEntries.append(ChartDataEntry(value: values[i], xIndex: i))
        }
        
        let dataSet = PieChartDataSet(yVals: dataEntries, label: "Balanço")
        let data = PieChartData(xVals: months, dataSet: dataSet)
        
        var colors: [UIColor] = []
        for _ in 0..<months.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        dataSet.colors = colors
        
        data.setValueFont(UIFont(name: "Futura", size: 10.0))
        pieChart.data = data
    }

    override func viewWillAppear(animated: Bool) {
//        self.viewDidLoad()
        initDashboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
