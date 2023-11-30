import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import {User} from '../user';
import {Product} from '../product';
import { ProductType } from '../../interface/product_type';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AdminService {

  private apiUrl = 'http://localhost:5000';

  private productsUrl = '/assets/products.json';

  constructor(private http: HttpClient) { }

  getPersonalList() {
    return this.http.get<User[]>('https://jsonplaceholder.typicode.com/users?_start=0&_limit=5');
  }

  getPerson(id: number) {
    return this.http.get<User>(`https://jsonplaceholder.typicode.com/users/${id}`);
  }

  // delete in future

  getProductList() {
    return this.http.get<Product[]>(this.productsUrl);
  }

  addProduct(productData: any) {
    return this.http.post<any>('http://localhost:5000/add_product', productData);
  }

  // admin products db
  getProductTypes() {
    return this.http.get<ProductType[]>('http://localhost:5000/get_product_types')
  }

  getProductsTable(selectedTableType: 'edit' | 'show' = 'edit', selectedProductType: string) {
    const requestBody = {
      selectedTableType: selectedTableType,
      selectedProductType: selectedProductType
    };
    return this.http.post<any>(`${this.apiUrl}/get_product_table`, requestBody);
  }

  getTableColumns(selectedTable: string) {
    return this.http.get<any>(`${this.apiUrl}/get_columns_table/${selectedTable}`);
  }

  // set_products (show)

  setProductsShow(products: any[]): Observable<any> {
  return this.http.post<any>(`${this.apiUrl}/set_products_show`, { products });
  }

  // products (edit)

  getCats(selectedTable: string): Observable<any[]> {
    return this.http.post<any[]>(`${this.apiUrl}/get_table_cats`, { selectedTable });
  }

  addEditProduct(selectedTable: string, newProduct: any = {}) {
    return this.http.post<any>(`${this.apiUrl}/add_edit_product`, {selectedTable, newProduct});
  }

  setEditProduct(newProductId: number, imageFile: File | null, price: number, selectedTable: string): Observable<any> {
    const formData = new FormData();
    formData.append('newProductId', newProductId.toString());
    formData.append('selectedTable', selectedTable);
    
    if (imageFile) {
      formData.append('imageFile', imageFile);
    }

    formData.append('price', price.toString());

    return this.http.post<any>(`${this.apiUrl}/set_edit_product`, formData);
  }

  deleteProduct(selectedTable: string, productId: any) {
    return this.http.post<any>(`${this.apiUrl}/delete_edit_product`, {selectedTable, productId});
  }
  
}
