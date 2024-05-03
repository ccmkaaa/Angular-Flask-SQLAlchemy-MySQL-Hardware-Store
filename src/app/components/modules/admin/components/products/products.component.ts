import { Component, OnInit, Pipe, PipeTransform, ComponentFactoryResolver, ComponentRef, ViewChild, ViewContainerRef } from '@angular/core';
import { trigger, state, style, transition, animate } from '@angular/animations'
import { ProductType } from '../../../interface/product_type';
import { Observable, map, of } from 'rxjs';
import { ActivatedRoute, Router } from '@angular/router';
import { AdminService } from '../../services/admin.service';
import { SearchFilterPipe } from '../../pipe/search-filter.pipe';
import { DynamicComponentDirective } from '../../directives/dynamic-component.directive';
import { ShowComponent } from './show/show.component';
import { EditComponent } from './edit/edit.component';

@Component({
  selector: 'app-products',
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.scss'],
  providers: [SearchFilterPipe],
})


export class ProductsComponent implements OnInit {

  productTypes!: Observable<ProductType[]>

  selectedTableType: 'edit' | 'show' = 'edit';
  selectedProductType!: string
  selectedSearch!: string

  columns: any[] = [];
  products: any[] = [];
  idOptions: any = {};

  constructor(private adminService: AdminService, 
    private router: Router, 
    private activatedRoute: ActivatedRoute, 
    private componentFactoryResolver: ComponentFactoryResolver,
    ) { }
    

  ngOnInit(): void {
    this.productTypes = this.activatedRoute.data.pipe(map((data) => data?.['product_types']))
  }
  
  onTypeSelect(): void {
    this.getProductsTable();
    
    this.adminService.getCats(this.selectedProductType).subscribe(data => {
      let idOptionsWithPrefix: { [key: string]: any[] } = {};
      for (let key in data) {
        idOptionsWithPrefix[`id_${key}`] = data[key];
      }
      this.idOptions = idOptionsWithPrefix;
    })
  }

  getProductsTable() {
    this.adminService.getProductsTable(this.selectedTableType, this.selectedProductType).subscribe(data => {
      this.products = data;
    });

    let selectedTable: string = this.selectedTableType === 'show' ? 'all_product' : this.selectedProductType;

    this.adminService.getTableColumns(selectedTable).subscribe(data => {
      this.columns = data;
    })
  }

}
