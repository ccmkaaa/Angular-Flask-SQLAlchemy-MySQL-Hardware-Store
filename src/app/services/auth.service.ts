import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, throwError } from 'rxjs';
import { of, map, catchError } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(private router: Router, private http: HttpClient) {

   }

   private apiUrl = 'http://localhost:5000';

   setToken(token: string) {
      localStorage.setItem('token', token)
   }

   getToken() {
      return localStorage.getItem('token')
   }

   isLoggedIn() {
      return this.getToken() !== null;
   }

   isAdmin(): boolean {
      return this.getToken() === 'admin'; 
    }

   login(userInfo: {email: string, password: string}): Observable<{ token: string }> {
      // if(userInfo.email === "admin@gmail.com" && userInfo.password === 'admin123') {
      //   this.setToken('abcdefg123')
      //   return of(true);
      // }
      // return throwError(()=>new Error('Failed Login'))
      const loginData = {
         email: userInfo.email,
         password: userInfo.password
       };
       return this.http.post<any>(`${this.apiUrl}/login`, loginData).pipe(
         map(response => {
           if (response && response.token) {
             this.setToken(response.token); // Установите токен после успешного входа
             return { token: response.token };
           } else {
             return { token: null };
           }
         }),
         catchError(error => {
           console.error('Login failed', error);
           return throwError('Failed Login');
         })
       );
   }

   register(userInfo: {email: string, password: string}): Observable<any> {
    const registerData = {
      email: userInfo.email,
      password: userInfo.password
    };
    return this.http.post<any>(`${this.apiUrl}/register`, registerData).pipe(
      catchError(error => {
        console.error('Registration failed', error);
        return throwError('Failed Registration');
      })
    );
  }

   logout() {
      this.router.navigate(['login'])
   }

 }
