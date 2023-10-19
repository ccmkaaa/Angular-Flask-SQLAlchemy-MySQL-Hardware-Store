import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './components/login/login.component';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { AppComponent } from './app.component';
import { AdminModule } from './components/modules/admin/admin.module';
import { AuthGuard_ca } from './guards/auth/auth-ca.guard';
import { AuthGuard_cd } from './guards/auth/auth-cd.guard';

const routes: Routes = [
  {path: 'login', component: LoginComponent},
  {path:'', redirectTo: '/login', pathMatch: 'full'},
  {
    path: 'admin',
    canActivate: [AuthGuard_ca],
    canDeactivate: [AuthGuard_cd],
    loadChildren: () => import('./components/modules/admin/admin.module').then((m) => m.AdminModule) // loadChildren: () => import('./components/modules/admin/admin.module').then((m: {AdminModule:AdminModule} ) => m.AdminModule)
  }, 
  {path: '**', component:NotFoundComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
