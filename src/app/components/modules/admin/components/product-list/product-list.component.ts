import { Component, OnInit } from '@angular/core';
import { Observable, filter, mapTo, map, merge } from 'rxjs';
import { Product } from '../../product';
import { ActivatedRoute, Router } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { AdminService } from '../../services/admin.service';
import { MatSnackBar } from '@angular/material/snack-bar';

@Component({
  selector: 'app-product-list',
  templateUrl: './product-list.component.html',
  styleUrls: ['./product-list.component.scss']
})
export class ProductListComponent implements OnInit {

  productList!: Observable<Product[]>
  newProduct: Product = { id: 0, name: '', quantity: 0, price: 0 };

  constructor(private adminService: AdminService, private router: Router, private activatedRoute: ActivatedRoute, private snackBar: MatSnackBar) {}

  addProduct(product: any) {
    product.quantity++;
  }

  removeProduct(product: any) {
    if (product.quantity > 0) {
      product.quantity--;
    }
  }

  addNewProduct() {
    // Добавление нового товара в список товаров (в данном случае, просто в памяти, не в JSON-файл)
    this.productList = this.productList.pipe(
      map((products) => [...products, this.newProduct])
    );

    // Вызов сервиса для отправки данных на сервер Flask
    this.adminService.addProduct(this.newProduct).subscribe(
      (response) => {
          this.openSnackBar('Товар успешно добавлен', 'OK');
      },
      (error) => {
          this.openSnackBar('Произошла ошибка', 'Закрыть');
      }
    );
  }

  openSnackBar(message: string, action: string) {
    this.snackBar.open(message, action, {
      duration: 3000, // Продолжительность показа оповещения в миллисекундах
    });
  }

  ngOnInit(): void {
      this.productList = this.activatedRoute.data.pipe(map((data) => data?.['products']))
  }

  
}
