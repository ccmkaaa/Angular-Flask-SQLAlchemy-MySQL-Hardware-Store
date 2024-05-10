import { Component, OnInit } from '@angular/core';
import { CartService } from '../../services/cart.service';
import { StoreService } from '../../services/store.service';

@Component({
  selector: 'app-orders',
  templateUrl: './orders.component.html',
  styleUrls: ['./orders.component.scss']
})
export class OrdersComponent implements OnInit {

  orders!: any[];

  constructor (private cartService: CartService, private storeService: StoreService) {

  }

  ngOnInit(): void {
    this.cartService.getOrders(localStorage.getItem('token')).subscribe(
      (data) => {
        this.orders = data;
        // console.log(this.orders);
        this.loadProductImages();
      },
      (error) => {
        console.error('Error loading orders:', error);
      }
    );
  }

  toggleCollapse(orderId: number): void {
    const collapseId = 'collapseOrder' + orderId;
    const collapseElement = document.getElementById(collapseId);
    if (collapseElement) {
      collapseElement.classList.toggle('show');
    }
  }

  loadProductImages(): void {
    this.orders.forEach((order) => {
      order.cart_products.forEach((item: any) => { // Используйте явное указание типа, если не знаете точный тип
        this.storeService.getProductImage(item.product.id).subscribe(
          (imageBlob: Blob) => {
            item.product.imageUrl = URL.createObjectURL(imageBlob);
          },
          (error) => {
            console.error('Error loading product image:', error);
          }
        );
      });
    });
  }
}
