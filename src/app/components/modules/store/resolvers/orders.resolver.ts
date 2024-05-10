import { ResolveFn } from '@angular/router';
import { Router, Resolve, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { CartService } from '../services/cart.service';
import { Observable } from 'rxjs';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})


export class OrdersResolver implements Resolve<any> {
  constructor(private cartService: CartService, private router: Router) {}

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {
    const token = localStorage.getItem('token');
    return this.cartService.getOrders(token);
  }
};
