import { ResolveFn } from '@angular/router';
import { Injectable } from '@angular/core';
import { Router, Resolve, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { catchError, delay, Observable, of, EMPTY } from 'rxjs';
import { AdminService } from '../services/admin.service';
import { User } from '../user';

@Injectable({
  providedIn: 'root'
})
export class UserResolver implements Resolve<User> {
  constructor(private adminService: AdminService, private router: Router) {}

  resolve(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<User> {
    return this.adminService.getPerson(route.params?.['id']).pipe(
      delay(1000),
      catchError(() => {
        this.router.navigate(['admin/contacts']);
        return EMPTY;
      })
    );
  }
}