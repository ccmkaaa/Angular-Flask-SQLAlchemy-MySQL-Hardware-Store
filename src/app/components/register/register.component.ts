import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent {
  registrationForm: FormGroup;

  constructor(private formBuilder: FormBuilder, private router: Router, private authService: AuthService) {
    this.registrationForm = this.formBuilder.group({
      email: ['', [Validators.required, Validators.email]],
      confirmEmail: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(8)]]
    });
  }

  submitRegistration(): void {
    if (this.registrationForm.valid) {
      if (!this.areEmailsMatching()) {
        alert('Email and Confirm Email must match');
        return; // Останавливаем отправку формы
      }
      
      // Получаем значение email из формы, предварительно проверив, существует ли контроль формы
      const emailControl = this.registrationForm.get('email');
      const email = emailControl ? emailControl.value : '';
  
      // Получаем значение password из формы, предварительно проверив, существует ли контроль формы
      const passwordControl = this.registrationForm.get('password');
      const password = passwordControl ? passwordControl.value : '';
      
      // Вызываем функцию register() из сервиса AuthService
      const userInfo = { email, password };
      this.authService.register(userInfo).subscribe(
        (data) => {
          console.log('Registration successful:', data);
          // Можете выполнить перенаправление на другую страницу, например, на страницу входа
          alert('Registration successful')
          this.router.navigate(['/login']);
        },
        (error) => {
          console.error('Registration failed:', error);
          alert('Registration failed:' +  error)
          // Здесь можно обработать ошибку регистрации, например, отобразить сообщение об ошибке
        }
      );
    } else {
      // Handle form validation errors
      console.error('Invalid registration form');
      alert('Invalid registration form')
    }
  }

  areEmailsMatching(): boolean {
    const emailControl = this.registrationForm.get('email');
    const confirmEmailControl = this.registrationForm.get('confirmEmail');
    if (emailControl && confirmEmailControl) {
      const email = emailControl.value;
      const confirmEmail = confirmEmailControl.value;
      return email === confirmEmail;
    }
    return false;
  }
}