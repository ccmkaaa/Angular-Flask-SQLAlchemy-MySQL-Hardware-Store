import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { ActivatedRoute, ResolveEnd, ResolveStart, Router } from '@angular/router';
import { Observable, filter, mapTo, merge } from 'rxjs';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss']
})
export class HeaderComponent implements OnInit {
  constructor(private authService: AuthService, private router: Router, private activatedRoute: ActivatedRoute) { }

  searchText: string = '';

  ngOnInit(): void {

  }

  isLoggedIn() {
    return this.authService.isLoggedIn()
  }
  logout() {
    this.authService.logout()
  }
}
