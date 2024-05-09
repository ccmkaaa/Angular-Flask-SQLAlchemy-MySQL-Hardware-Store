import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class CartService {

  private apiUrl = 'http://localhost:5000';

  constructor(private http: HttpClient) { }

  orderCart() {
    const products = this.getProducts();
    const user_login = this.getToken();
  }

  getProducts() {
    return localStorage.getItem('cart');
  }

  getToken() {
    return localStorage.getItem('token');
  }

}
