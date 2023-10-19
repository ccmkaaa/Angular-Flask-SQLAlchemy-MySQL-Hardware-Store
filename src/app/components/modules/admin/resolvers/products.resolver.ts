import { Injectable } from '@angular/core';
import {
  Router, Resolve,
  RouterStateSnapshot,
  ActivatedRouteSnapshot
} from '@angular/router';
import {delay, Observable, of} from 'rxjs';
import {Product} from '../product';
import {AdminService} from '../services/admin.service';

@Injectable({
  providedIn: 'root'
})

export class ProductsResolver implements Resolve<Product[]> {

  constructor(private adminService: AdminService) {
  }
  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<Product[]> {
    return this.adminService.getProductList().pipe(
      delay(1000)
    )
  }
}