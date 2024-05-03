import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { StoreDashboardComponent } from './components/store-dashboard/store-dashboard.component';
import { HomeComponent } from './components/home/home.component';
import { CartComponent } from './components/cart/cart.component';
import { ProductsResolver } from './resolvers/products.resolver';
import { ProductTypesResolver } from './resolvers/productTypes.resolver';
import { CategoriesResolver } from './resolvers/categories.resolver';

const routes: Routes = [
  { path: '', component: StoreDashboardComponent,
    children: [
      { path: '', 
        redirectTo: 'home', 
        pathMatch: 'full' 
      },
      {path: 'home', component: HomeComponent, resolve: {
        products: ProductsResolver,
        product_types: ProductTypesResolver,
        categories: CategoriesResolver,
      }},
      {path: 'cart', component: CartComponent, resolve: {

      }},
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class StoreRoutingModule { }
