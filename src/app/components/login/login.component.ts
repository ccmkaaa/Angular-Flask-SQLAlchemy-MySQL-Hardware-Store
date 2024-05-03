import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit{
  loginForm!: FormGroup

  constructor(
    private authService: AuthService,
    private router: Router) { }

  submitLogin() {
    this.authService.login(this.loginForm.value).subscribe({
      next: (response) => {
        if (response.token === 'admin') {
          this.router.navigate(['admin']);
        } else {
          this.router.navigate(['store']);
        }
      },
      error: (err) => alert(err.message)
    });
  }

  ngOnInit(): void {
      this.loginForm = new FormGroup({
        'email': new FormControl('', [Validators.required]),
        'password': new FormControl('', 
        [Validators.required, 
          Validators.pattern(/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/)
        ])
      });
      if (this.authService.isLoggedIn() && this.authService.isAdmin()) {  // для админа
        this.router.navigate(['admin'])
      } else if (this.authService.isLoggedIn()) {
        this.router.navigate(['store'])
      }
  }
}
