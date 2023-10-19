import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, ResolveEnd, ResolveStart, Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';
import { AdminService } from '../../services/admin.service';
import { Observable, filter, mapTo, merge } from 'rxjs';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss']
})
export class HeaderComponent implements OnInit{
  constructor(private authService: AuthService, private adminService: AdminService, private router: Router, private activatedRoute: ActivatedRoute) {

  }

  private showLoader!: Observable<boolean>;
  private hideLoader!: Observable<boolean>;

  isLoading!: Observable<boolean>;

  
  ngOnInit(): void {
    this.hideLoader = this.router.events.pipe(filter((e) => e instanceof ResolveEnd), mapTo(false));
    this.showLoader = this.router.events.pipe(filter((e) => e instanceof ResolveStart), mapTo(true));

    this.isLoading = merge(this.hideLoader, this.showLoader)

  }

  logout() {
    this.authService.logout()
  }

}
