import { Component, ViewChild, TemplateRef } from '@angular/core';
import { Input, Output, EventEmitter, ViewContainerRef } from '@angular/core';
import { Product } from '../../../product';
import { Observable, filter, mapTo, map, merge } from 'rxjs';

@Component({
  selector: 'app-product',
  templateUrl: './product.component.html',
  styleUrls: ['./product.component.scss'],
  
})
export class ProductComponent {
  @Input() product!: Product;
  @Output() addProduct: EventEmitter<Product> = new EventEmitter<Product>();
  @Output() removeProduct: EventEmitter<Product> = new EventEmitter<Product>();

  constructor(private viewContainerRef: ViewContainerRef) {}

  onAddProduct(product: Product) {
    // Вызываем метод addProduct из родительского компонента product-list
    product.quantity++;
    // this.addProduct.emit(product);
  }

  onRemoveProduct(product: Product) {
    // Вызываем метод removeProduct из родительского компонента product-list
    // this.removeProduct.emit(product);
    if (product.quantity > 0) {
      product.quantity--;
    }
  }
}
