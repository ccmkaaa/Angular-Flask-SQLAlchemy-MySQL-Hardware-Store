import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class StatService {

  private apiUrl = 'http://localhost:5000';

  constructor(private http: HttpClient) { }

  getTotalQuantityAmount() {
    return this.http.get<any>(`${this.apiUrl}/total_quantity_amount`).pipe(map(response => response.total_quantity));
  }

  getTotalOrdersSales() {
    return this.http.get<any>(`${this.apiUrl}/total_orders_sales`).pipe(map(response => response.total_orders));
  }

  getTotalSalesProducts() {
    return this.http.get<any>(`${this.apiUrl}/total_sales_products`).pipe(map(response => response.total_sales));
  }

  getTotalSalesAmount() {
    return this.http.get<any>(`${this.apiUrl}/total_sales_amount`).pipe(map(response => response.total_amount));
  }

  getTotalQuantityRemainingByProductType() {
    return this.http.get<any>(`${this.apiUrl}/total_quantity_remaining_by_product_type`);
  }

  getTotalAmountRemainingByProductType() {
    return this.http.get<any>(`${this.apiUrl}/total_amount_remaining_by_product_type`);
  }
}
