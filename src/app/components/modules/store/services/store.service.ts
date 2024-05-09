import { Injectable } from '@angular/core';
import { Observable, BehaviorSubject  } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { DialogService } from './dialog.service';

interface Subcategory {
  name: string;
  values: { id: number; name: string }[];
}

interface Category {
  category: string;
  subcategories: { [key: string]: Subcategory };
}

interface Subcategories {
  [key: string]: {
    name: string;
    values: { id: number; name: string }[];
  };
}

// Объявление типа для словаря категорий
interface CategoriesDict {
  [key: string]: Subcategories;
}

@Injectable({
  providedIn: 'root'
})
export class StoreService {

  private apiUrl = 'http://localhost:5000';

  constructor(private http: HttpClient) { }

  // for searchText
  private searchTextSource$ = new BehaviorSubject<string>('');
  searchText$ = this.searchTextSource$.asObservable();
  setSearchText(searchText: string) {
    this.searchTextSource$.next(searchText);
  }

  // api

  getProductTypes() {
    return this.http.get<any>(`${this.apiUrl}/shop_get_product_types`);
  }
  getProducts() {
    return this.http.get<any>(`${this.apiUrl}/shop_get_products`);
  }
  getCategories() {
    return this.http.get<any>(`${this.apiUrl}/shop_get_categories`);
  }
  getProductImage(product_id: number) {
    return this.http.get(`${this.apiUrl}/shop_get_pic/${product_id}`, { responseType: 'blob' });
  }

  // sort 
  getSortedProductIds(categories: Category[], searchText: string, productTypes: any[]) {
    const categoriesDict: CategoriesDict = {};
    categories.forEach(category => {
      categoriesDict[category.category] = category.subcategories;
    });
    // console.log(categoriesDict)
    const body = {
      categoriesDict,
      searchText,
      productTypes
    }
    // console.log(categories)
    return this.http.post<any>(`${this.apiUrl}/shop_get_sorted_product_ids`, body);
  }

}
