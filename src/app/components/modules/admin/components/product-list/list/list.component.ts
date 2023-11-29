import { Component } from '@angular/core';
import { Input, Output, EventEmitter } from '@angular/core';
import { Product } from '../../../product';
import { Observable, filter, mapTo, map, merge } from 'rxjs';

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.scss']
})
export class ListComponent {
  @Input() productList!: Observable<Product[]>;
  @Output() addProduct: EventEmitter<Product> = new EventEmitter<Product>();
  @Output() removeProduct: EventEmitter<Product> = new EventEmitter<Product>();

  onAddProduct(product: Product) {
    // Вызываем метод addProduct из родительского компонента product-list
    this.addProduct.emit(product);
  }

  onRemoveProduct(product: Product) {
    // Вызываем метод removeProduct из родительского компонента product-list
    this.removeProduct.emit(product);
  }
}
