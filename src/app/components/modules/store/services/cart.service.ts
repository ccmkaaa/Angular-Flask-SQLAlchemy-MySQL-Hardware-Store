import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { of } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CartService {

  private apiUrl = 'http://localhost:5000';

  constructor(private http: HttpClient) { }

  orderCart(total_amount: number) {
    const cartItemsString = this.getProducts();
    if (cartItemsString) {
      const cartItems = JSON.parse(cartItemsString); // Преобразовать строку в объект
      const body = {
        products: cartItems,
        user_login: this.getToken(),
        total_amount: total_amount
      }
      return this.http.post<any>(`${this.apiUrl}/shop_set_order`, body).subscribe(
        (response) => {
          console.log('Order placed successfully', response);
          console.log(cartItems);
          localStorage.removeItem('cart');
        },
        (error) => {
          console.error('Error placing order', error);
        }
      );
    } else {
      console.error('Cart items not found in localStorage');
      return of(null); // Возвращает Observable, содержащий null
    }
  }

  getProducts() {
    return localStorage.getItem('cart');
  }

  getToken() {
    return localStorage.getItem('token');
  }

  // get order

  getOrders(token: any) {
    const data = {
      user_login: token
    }
    return this.http.post<any>(`${this.apiUrl}/shop_get_orders`, data);
  }

}
