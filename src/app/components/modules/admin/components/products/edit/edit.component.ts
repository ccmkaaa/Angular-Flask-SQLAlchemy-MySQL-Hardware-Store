import { Component, ViewChild, Input } from '@angular/core';
import { DynamicComponentDirective } from '../../../directives/dynamic-component.directive';
import { Observable } from 'rxjs';
import { SearchFilterPipe } from '../../../pipe/search-filter.pipe';
import { AdminService } from '../../../services/admin.service';

@Component({
  selector: 'app-edit',
  templateUrl: './edit.component.html',
  styleUrls: ['./edit.component.scss'],
  providers: [SearchFilterPipe]
})
export class EditComponent {
  @Input() columns: any[] = [];
  @Input() products: any[] = [];
  @Input() selectedSearch!: string;
  @Input() idOptions: any = {};
  @Input() selectedTable!: string;

  filteredColumns: any[] = [];
  newProduct: any = {};

  imageFile: File | null = null;
  price: { price: number } = { price: 0 };

  constructor(private adminService: AdminService) {}

  addProduct(): void {
    const missingFields = this.getMissingFields();
    console.log('New Product:', this.newProduct);
    if (this.isValidForm()) {
      this.adminService.addEditProduct(this.selectedTable, this.newProduct).subscribe(
        (response) => {
          this.products.push(response.createdRecord);
          this.newProduct = {};

          const newProductId = response.createdRecord.id;
          this.adminService.setEditProduct(newProductId, this.imageFile, this.price.price, this.selectedTable).subscribe(
            (data) => {
              this.imageFile = null;
              this.price = { price: 0 };
              alert('Product Added')
            },
            (data) => {
              console.error('Error processing product parameters: ', data);
            }
          );
        },
        (error) => {
          console.error('Error adding product', error);
        }
      );
    } else {
      alert('Please fill in all required fields: ' + missingFields.join(', ') + ' (also pic the file and price)');
    }
  }

  deleteProduct(product: any): void {
    const productId = product.id; 
    this.adminService.deleteProduct(this.selectedTable, productId).subscribe(
      () => {
        const index = this.products.findIndex(p => p.id === productId);
        if (index !== -1) {
          this.products.splice(index, 1);
        }
        alert('Product Deleted');
      },
      (error) => {
        console.error('Error deleting product', error);
      }
    );
  }

  ngOnInit(): void {
    this.filteredColumns = this.columns
    .filter(column => column.startsWith('id_'))
    .map(column => column.replace('id_', ''));
  }

  // validation 

  isValidForm(): boolean {
    const requiredFields = ['name', ...Object.keys(this.idOptions)]; 
    const isImageFieldFilled = this.imageFile !== null && this.imageFile !== undefined;
    const isPriceFieldFilled = this.price.price !== null && this.price.price !== undefined;

    const areRequiredFieldsFilled = requiredFields.every(field =>
      this.newProduct[field] !== null && this.newProduct[field] !== undefined
    );
    return areRequiredFieldsFilled && isImageFieldFilled && isPriceFieldFilled;
  }

  getMissingFields(): string[] {
    const requiredFields = ['name', ...Object.keys(this.idOptions)]; 
    return requiredFields.filter(field => this.newProduct[field] === null || this.newProduct[field] === undefined);
  }

  onImageChange(event: any): void {
    const files = event.target.files;
    if (files.length > 0) {
      this.imageFile = files[0];
    }
  }

  onKeyPress(event: any): void {
    const inputValue = event.key;
    
    // Проверка на число
    if (!/^\d+$/.test(inputValue)) {
      event.preventDefault();
    }
  }
}
