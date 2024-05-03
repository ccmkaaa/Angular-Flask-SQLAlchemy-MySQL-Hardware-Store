import { ResolveFn } from '@angular/router';
import { Router, Resolve, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Injectable } from '@angular/core';
import { StoreService } from '../services/store.service';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})

export class CategoriesResolver implements Resolve<any> {
  constructor(private storeService: StoreService, private router: Router) {}

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {
    return this.storeService.getCategories();
  }
};
