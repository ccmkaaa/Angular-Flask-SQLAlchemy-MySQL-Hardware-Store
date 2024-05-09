import { Component, OnInit, EventEmitter, Output, OnChanges, SimpleChanges, Input, HostListener } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { ActivatedRoute, ResolveEnd, ResolveStart, Router } from '@angular/router';
import { Observable, filter, mapTo, merge } from 'rxjs';
import { StoreService } from '../../services/store.service';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss']
})
export class HeaderComponent implements OnInit {
  constructor(private authService: AuthService, private router: Router, private activatedRoute: ActivatedRoute, private storeService: StoreService) { }

  searchText: string = '';
  cartLength!: number;

  getCartLength() {
    const cart = JSON.parse(localStorage.getItem('cart') || '[]');
    this.cartLength = cart.length;
  }

  onSearchTextChange(newValue: string) {
    this.storeService.setSearchText(newValue);
  }

  isHomePage() {
    return this.router.url.includes('/store/home');
  }

  isLoggedIn() {
    return this.authService.isLoggedIn()
  }
  logout() {
    this.authService.logout()
  }

  ngOnInit(): void {
    this.getCartLength();
    // addEventListener("storage", (event) => {
    //   this.getCartLength()
    // });
  }

  @HostListener('window:storage')
  onStorageChange() {
    console.log('change...');
    this.getCartLength();
  }
}
