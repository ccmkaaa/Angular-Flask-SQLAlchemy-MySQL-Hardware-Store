import { Injectable } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { ProductComponent } from '../components/product/product.component';
import { PaymentComponent } from '../components/payment/payment.component';

@Injectable({
  providedIn: 'root'
})
export class DialogService {
  private cart: { product: any, quantity: number }[] = [];

  constructor(private dialog: MatDialog) { 
    const cartData = localStorage.getItem('cart');
    this.cart = cartData ? JSON.parse(cartData) : [];
  }

  openProductInfoDialog(product: any): void {
    const dialogRef = this.dialog.open(ProductComponent, {
      width: 'auto',
      data: { product: product }
    });
  }

  openCartInfoDialog(total_amount: number): void {
    const dialogRef = this.dialog.open(PaymentComponent, {
      width: 'auto',
      data: {
        total_amount: total_amount
      }
    });
  }


  addToCart(product: any, quantity: number): void {
    const itemIndex = this.cart.findIndex(item => item.product.id === product.id);
    if (itemIndex !== -1) {
      // Если товар уже есть в корзине, обновляем количество
      this.cart[itemIndex].quantity += quantity;
    } else {
      // Если товара нет в корзине, добавляем новый элемент
      this.cart.push({ product: product, quantity: quantity });
    }
    // Сохраняем корзину в localStorage
    this.saveCartToLocalStorage();
  }

  private saveCartToLocalStorage(): void {
    localStorage.setItem('cart', JSON.stringify(this.cart));
  }
}
