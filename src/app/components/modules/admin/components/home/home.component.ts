import { Component, OnInit, ViewChild } from '@angular/core';
import { StatService } from '../../services/stat.service';

import { ChartComponent } from "ng-apexcharts";


import {
  ApexNonAxisChartSeries,
  ApexResponsive,
  ApexChart
} from "ng-apexcharts";

export type ChartOptions = {
  series: ApexNonAxisChartSeries;
  chart: ApexChart;
  responsive: ApexResponsive[];
  labels: any;
};


@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {

  @ViewChild("chart1") chart1!: ChartComponent;
  public chartOptions1: Partial<ChartOptions> = {};

  @ViewChild("chart2") chart2!: ChartComponent;
  public chartOptions2: Partial<ChartOptions> = {};

  constructor(private statService: StatService) {
  }

  total_quantity_amount!: any; // all quantity amount of products in AllProduct
  total_orders_sales!: any;   // total quantity of orders in OrderCart
  total_sales_products!: any;   // total quantity of sold products
  total_sales_amount!: any;   // total price amount of sales

  total_quantity_remaining_by_product_type!: any;  // total quantity of products remaining by product_types
  total_amount_remaining_by_product_type!: any;
  
  ngOnInit(): void {
    this.statService.getTotalQuantityAmount().subscribe(data => {
      this.total_quantity_amount = data;
    });

    this.statService.getTotalOrdersSales().subscribe(data => {
      this.total_orders_sales = data;
    });

    this.statService.getTotalSalesProducts().subscribe(data => {
      this.total_sales_products = data;
    });

    this.statService.getTotalSalesAmount().subscribe(data => {
      this.total_sales_amount = data;
    });

    this.statService.getTotalQuantityRemainingByProductType().subscribe(data => {
      this.total_quantity_remaining_by_product_type = data;
      console.log('getTotalQuantityRemainingByProductType')
      console.log(data)
      this.updateChartOptions1();
    });

    this.statService.getTotalAmountRemainingByProductType().subscribe(data => {
      this.total_amount_remaining_by_product_type = data;
      console.log('getTotalAmountyRemainingByProductType')
      console.log(data)
      this.updateChartOptions2();
    });
  }

  updateChartOptions1(): void {
    if (this.total_quantity_remaining_by_product_type) {
      // Extract keys and values from the data object
      const keys = Object.keys(this.total_quantity_remaining_by_product_type);
      const values = Object.values(this.total_quantity_remaining_by_product_type);

      const series = values.map(value => parseFloat(value as string));

      // Update chartOptions with the extracted keys and values
      this.chartOptions1 = {
        series: series,
        chart: {
          type: 'donut',
          background: '#1a1e21'
        },
        labels: keys,
        responsive: [
          {
            breakpoint: 480,
            options: {
              chart: {
                width: 200
              },
              legend: {
                position: "bottom"
              }
            }
          }
        ]
      };
    }
  }

  updateChartOptions2(): void {
    if (this.total_amount_remaining_by_product_type) {
      // Extract keys and values from the data object
      const keys = Object.keys(this.total_amount_remaining_by_product_type);
      const values = Object.values(this.total_amount_remaining_by_product_type);

      const series = values.map(value => parseFloat(value as string));

      // Update chartOptions with the extracted keys and values
      this.chartOptions2 = {
        series: series,
        chart: {
          type: 'donut',
          background: '#1a1e21'
        },
        labels: keys,
        responsive: [
          {
            breakpoint: 480,
            options: {
              chart: {
                width: 200
              },
              legend: {
                position: "bottom"
              }
            }
          }
        ]
      };
    }
  }

}
