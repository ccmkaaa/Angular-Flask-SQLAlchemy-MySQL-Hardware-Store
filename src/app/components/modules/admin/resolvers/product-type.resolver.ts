import { ResolveFn } from '@angular/router';
import { Injectable } from '@angular/core';
import {
  Router, Resolve,
  RouterStateSnapshot,
  ActivatedRouteSnapshot
} from '@angular/router';
import { delay, Observable, of } from 'rxjs';
import { AdminService } from '../services/admin.service';
import { ProductType } from '../../interface/product_type';

@Injectable({
  providedIn: 'root'
})
export class ProductTypeResolver implements Resolve<ProductType[]> {
  constructor(private adminService: AdminService) {}

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {
    return this.adminService.getProductTypes();
  }
}