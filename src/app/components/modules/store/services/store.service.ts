import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class StoreService {

  private apiUrl = 'http://localhost:5000';

  constructor(private http: HttpClient) { }

  getProductTypes() {
    return this.http.get<any>(`${this.apiUrl}/shop_get_product_types`);
  }
  getProducts() {
    return this.http.get<any>(`${this.apiUrl}/shop_get_products`);
  }
  getCategories() {
    return this.http.get<any>(`${this.apiUrl}/shop_get_categories`);
  }
}
