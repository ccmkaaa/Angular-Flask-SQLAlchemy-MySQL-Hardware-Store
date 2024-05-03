import { ResolveFn } from '@angular/router';
import { Router, Resolve, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { StoreService } from '../services/store.service';
import { Observable } from 'rxjs';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})


export class ProductsResolver implements Resolve<any> {
  constructor(private storeService: StoreService, private router: Router) {}

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {
    return this.storeService.getProducts();
  }
};
