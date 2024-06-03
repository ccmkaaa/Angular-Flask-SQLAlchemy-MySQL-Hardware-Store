import { Component, OnInit, Input } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { StoreService } from '../../services/store.service';
import { Subscription } from 'rxjs'
import { DialogService } from '../../services/dialog.service';

interface Subcategory {
  name: string;
  values: { id: number; name: string }[];
}

interface Category {
  category: string;
  subcategories: { [key: string]: Subcategory };
}


@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss'],
})
export class HomeComponent implements OnInit {

  private searchTextSubscription!: Subscription;

  constructor(private route: ActivatedRoute, private storeService: StoreService, private dialogService: DialogService) { 
    this.searchTextSubscription = this.storeService.searchText$.subscribe(searchText => {
      this.searchText = searchText;
      this.onAnyChange(); // Вызываем метод при каждом изменении searchText
    });
  }

  products!: any[];
  initialProducts!: any[];
  productTypes!: any[];
  categories!: Category[];

  searchText: string = '';
  selectedCategories: Category[] = [];
  filteredProducts: any[] = [];

  selectedProductTypes: string[] = []; 
  isProductTypeSelected: { [key: string]: boolean } = {};
  selectedValues: { [key: string]: boolean } = {}; // Object to store selected value names

  products_cart!: any[];

  onAnyChange() {
    this.storeService.getSortedProductIds(
      this.getSelectedCategories(this.categories),
      this.searchText,
      this.getSelectedProductTypes(this.productTypes)
    )
    .subscribe((data) => {
      console.log(data)
      const productIds  = data;
      this.products = this.initialProducts.filter(product => productIds.includes(product.id));
      this.products.forEach(product => {
        this.storeService.getProductImage(product.id).subscribe(image => {
          product.imageUrl = URL.createObjectURL(image);
        });
      });
    });
  }

  show_info() {
    console.log(this.searchText)
    console.log(this.getSelectedProductTypes(this.productTypes))
    console.log(this.getSelectedCategories(this.categories))
    console.log(this.products)
  }

  getCombinedValueId(categoryName: string, subcategoryId: string, valueId: number): string {
    return `${categoryName}-${subcategoryId}-${valueId}`;
  }

  parseCategories(categories: Category[]) {
    const _categories = categories;
    for (const categoryName in _categories) {
      const category = _categories[categoryName];
      console.log(`Category: ${category.category}`);
  
      for (const subcategoryName in category.subcategories) {
        const subcategory = category.subcategories[subcategoryName];
        console.log(`  Subcategory: ${subcategory.name}`);
  
        // Access subcategory values here
        for (const value of subcategory.values) {
          console.log(`    Value: id=${value.id}, name=${value.name}`);
        }
      }
    }
  }

    getSelectedCategories(categories: Category[]) {
      const selectedCategories: Category[] = [];

      for (const category of categories) {
        const selectedSubcategories: { [key: string]: Subcategory } = {};

        for (const subcategoryName in category.subcategories) {
          const subcategory = category.subcategories[subcategoryName];
          const selectedValues: { id: number; name: string }[] = [];

          for (const value of subcategory.values) {
            const valueId = this.getCombinedValueId(category.category, subcategoryName, value.id);
            if (this.selectedValues[valueId]) {
              selectedValues.push(value);
            }
          }

          if (selectedValues.length > 0) {
            selectedSubcategories[subcategoryName] = { name: subcategory.name, values: selectedValues };
          }
        }

        if (Object.keys(selectedSubcategories).length > 0) {
          selectedCategories.push({ category: category.category, subcategories: selectedSubcategories });
        }
      }

      return selectedCategories;
  }

  getSelectedProductTypes(productTypes: any[]) {
    const selectedProductTypes: any[] = [];

    for (const productType of productTypes) {
        if (this.isProductTypeSelected[productType.id]) {
            selectedProductTypes.push(productType);
        }
    }

    return selectedProductTypes;
  }
  onCheckboxChange(event: any) {
    this.onValueChange(event);
    this.onAnyChange();
  }
  onValueChange(event: any) {
    const valueId = event.target.value;
    this.selectedValues[valueId] = event.target.checked;
    // Call a function to update your filtered categories based on selected values (explained later)
    // this.updateFilteredCategories();
  }
  

  updateFilteredCategories() {
    const filteredCategories: Category[] = [];
    for (const category of this.categories) {
      const hasSelectedValues = Object.values(this.selectedValues).some(isSelected => isSelected); // Check if any value is selected in this category
      if (hasSelectedValues) {
        filteredCategories.push(category);
      }
    }

    this.categories = filteredCategories;
  }

  openProductInfoDialog(product: any): void {
    this.dialogService.openProductInfoDialog(product);
  }

  loadProducts(): void {
    this.storeService.getProducts().subscribe(products => {
      this.products = products;
      this.products.forEach(product => {
        this.storeService.getProductImage(product.id).subscribe(image => {
          product.imageUrl = URL.createObjectURL(image);
        });
      });
    });
  }


  ngOnInit() {
    // Получаем данные из резолверов
    this.route.data.subscribe(data => {
      this.products = data['products'];
      this.productTypes = data['product_types'];
      this.categories = data['categories'];
    });
    // загрузка товаров
    this.loadProducts();
    // подписка на поисковую строку
    this.searchTextSubscription = this.storeService.searchText$.subscribe(searchText => {
      this.searchText = searchText;
    });
    this.initialProducts = this.products;
  }

}
