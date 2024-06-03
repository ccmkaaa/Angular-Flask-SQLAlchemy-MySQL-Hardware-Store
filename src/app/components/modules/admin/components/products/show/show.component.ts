import { Component, ViewChild, Input, Output, EventEmitter } from '@angular/core';
import { Observable } from 'rxjs';
import { SearchFilterPipe } from '../../../pipe/search-filter.pipe';
import { PriceFormatPipe } from '../../../pipe/price-format.pipe';
import { AdminService } from '../../../services/admin.service';

@Component({
  selector: 'app-show',
  templateUrl: './show.component.html',
  styleUrls: ['./show.component.scss'],
  providers: [SearchFilterPipe]
})
export class ShowComponent {
  @Input() columns: any[] = [];
  @Input() products: any[] = [];
  @Input() selectedSearch!: string;

  @Output() priceChange = new EventEmitter<{ index: number, newValue: number }>();


  constructor(private adminService: AdminService) {}
  
  ngOnInit(): void {

  }

  increaseQuantity(product: any): void {
    product.quantity += 1;
  }

  decreaseQuantity(product: any): void {
    if (product.quantity > 0) {
      product.quantity -= 1;
    }
  }

  getTotalAmount(product: any): number {
    return product.quantity * product.price;
  }

  // валидаторы
  validateInput(event: any): void {
    const inputValue: number = event.target.value;
    if (isNaN(inputValue) || inputValue < 0) {
      event.preventDefault(); // Отменяем ввод
    }
  }
  onKeyPress(event: any): void {
    const inputValue = event.key;
    // Проверка на число
    if (!/^\d+$/.test(inputValue)) {
      event.preventDefault();
    }
  }
  isEditable(column: string): boolean {
    return column === 'price' || column === 'quantity' || column === 'description';
  }
  
  // save products
  saveProduct(): void {
    this.adminService.setProductsShow(this.products)
      .subscribe(
        data => {
          console.log(data);
        },
        error => {
          console.error(error);
        }
      );
  }
}
