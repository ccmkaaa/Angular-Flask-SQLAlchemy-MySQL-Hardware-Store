import { Component, OnInit, HostListener } from '@angular/core';
import { StoreService } from '../../services/store.service';
import { DialogService } from '../../services/dialog.service';

@Component({
  selector: 'app-cart',
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.scss']
})
export class CartComponent {
  constructor(private storeService: StoreService, private dialogService: DialogService) {}

  products!: any[];

  openCartInfoDialog(product: any): void {
    this.dialogService.openCartInfoDialog(product);
  }

  parseCart() {
    const cartData = localStorage.getItem('cart');
    if (cartData) {
      this.products = JSON.parse(cartData);
      this.products.forEach(item => {
        this.loadProductImage(item.product.id, item);
      });
    }
  }
  loadProductImage(productId: number, item: any): void {
    this.storeService.getProductImage(productId).subscribe(imageBlob => {
      item.product.imageUrl = URL.createObjectURL(imageBlob);
    });
  }

  getTotalPrice() {
    return this.products.reduce((total, item) => total + (item.product.price * item.quantity), 0);
  }

  removeItem(item: any) {
    const itemIndex = this.products.findIndex(product => product.product.id === item.product.id);
    if (itemIndex !== -1) {
      this.products.splice(itemIndex, 1);
      this.saveCartToLocalStorage();
    }
  }
  updateQuantity(item: any) {
    this.saveCartToLocalStorage();
  }

  saveCartToLocalStorage() {
    localStorage.setItem('cart', JSON.stringify(this.products));
  }

  ngOnInit() {
    this.parseCart()
  }
}
