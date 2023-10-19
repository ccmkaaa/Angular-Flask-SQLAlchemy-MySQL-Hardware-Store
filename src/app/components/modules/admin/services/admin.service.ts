import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import {User} from '../user';
import {Product} from '../product';

@Injectable({
  providedIn: 'root'
})
export class AdminService {

  private productsUrl = '/assets/products.json';

  constructor(private http: HttpClient) { }

  getPersonalList() {
    return this.http.get<User[]>('https://jsonplaceholder.typicode.com/users?_start=0&_limit=5');
  }

  getPerson(id: number) {
    return this.http.get<User>(`https://jsonplaceholder.typicode.com/users/${id}`);
  }

  getProductList() {
    return this.http.get<Product[]>(this.productsUrl);
  }

  addProduct(productData: any) {
    return this.http.post<any>('http://localhost:5000/add_product', productData);
  }
}
