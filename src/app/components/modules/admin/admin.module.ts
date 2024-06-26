import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { NgApexchartsModule } from 'ng-apexcharts';

import { AdminRoutingModule } from './admin-routing.module';
import { FooterComponent } from './components/footer/footer.component';
import { HeaderComponent } from './components/header/header.component';
import { HomeComponent } from './components/home/home.component';
import { ContactsComponent } from './components/contacts/contacts.component';
import { ContactsDetailsComponent } from './components/contacts-details/contacts-details.component';
import { AdminDashboardComponent } from './components/admin-dashboard/admin-dashboard.component';
import { FormsModule }   from '@angular/forms';
import { ProductsComponent } from './components/products/products.component';
import { SearchFilterPipe } from './pipe/search-filter.pipe';
import { ShowComponent } from './components/products/show/show.component';
import { EditComponent } from './components/products/edit/edit.component';
import { DynamicComponentDirective } from './directives/dynamic-component.directive';
import { PriceFormatPipe } from './pipe/price-format.pipe';


@NgModule({
  declarations: [
    FooterComponent,
    HeaderComponent,
    HomeComponent,
    ContactsComponent,
    ContactsDetailsComponent,
    ContactsDetailsComponent,
    AdminDashboardComponent,
    ProductsComponent,
    SearchFilterPipe,
    ShowComponent,
    EditComponent,
    DynamicComponentDirective,
    PriceFormatPipe,
  ],
  imports: [
    CommonModule,
    AdminRoutingModule,
    FormsModule,
    NgApexchartsModule
  ]
})
export class AdminModule { }
