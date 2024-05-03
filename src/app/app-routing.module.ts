import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './components/login/login.component';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { AppComponent } from './app.component';
import { AdminModule } from './components/modules/admin/admin.module';
import { StoreModule } from './components/modules/store/store.module';
import { AdminAuthGuard_ca } from './guards/auth/admin-auth-ca.guard';
import { AdminAuthGuard_cd } from './guards/auth/admin-auth-cd.guard';

const routes: Routes = [
  {path: 'login', component: LoginComponent},
  {path: '', redirectTo: '/store', pathMatch: 'full'},
  {
    path: 'admin',
    canActivate: [AdminAuthGuard_ca],
    canDeactivate: [AdminAuthGuard_cd],
    loadChildren: () => import('./components/modules/admin/admin.module').then((m) => m.AdminModule), 
  },
  { path: 'store',
    canActivate: [AdminAuthGuard_ca],
    canDeactivate: [AdminAuthGuard_cd], 
    loadChildren: () => import('./components/modules/store/store.module').then((m) => m.StoreModule),
  }, 
  { path: '**', component:NotFoundComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
