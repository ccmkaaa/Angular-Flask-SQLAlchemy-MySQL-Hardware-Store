import { Component } from '@angular/core';
import { Input, Output, EventEmitter } from '@angular/core';
import { Product } from '../../../product';
import { Observable, filter, mapTo, map, merge } from 'rxjs';
import { AdminService } from '../../../services/admin.service';
import { MatSnackBar } from '@angular/material/snack-bar';

@Component({
  selector: 'app-form-add-new-product',
  templateUrl: './formaddnewproduct.component.html',
  styleUrls: ['./formaddnewproduct.component.scss']
})
export class FormAddNewProductComponent {
  @Input() productList!: Observable<Product[]>;
  @Input() newProduct!: Product; // Объявление входного свойства
  @Output() AddNewProduct: EventEmitter<Product> = new EventEmitter<Product>();

  constructor(private adminService: AdminService, private snackBar: MatSnackBar) {}

  onAddNewProduct() {
    this.AddNewProduct.emit(this.newProduct);  
  }
}
