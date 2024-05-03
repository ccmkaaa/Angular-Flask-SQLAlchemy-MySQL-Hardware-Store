import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

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

  constructor(private route: ActivatedRoute) { }

  products!: any[];
  productTypes!: any[];
  categories!: Category[];
  selectedCategories: Category[] = [];
  filteredProducts: any[] = [];
  searchText: string = '';
  selectedProductTypes: string[] = []; 
  isProductTypeSelected: { [key: string]: boolean } = {};
  selectedValues: { [key: string]: boolean } = {}; // Object to store selected value names


  parseCategories(categories: Category[]) {
    const _categories = categories;

    console.log(this.getSelectedProductTypes(this.productTypes))
  
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

  getCombinedValueId(categoryName: string, subcategoryId: string, valueId: number): string {
    return `${categoryName}-${subcategoryId}-${valueId}`;
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
    // Update your categories with the filtered list (assuming you have a way to display filtered categories)
    this.categories = filteredCategories;
  }


  ngOnInit() {
    // Получаем данные из резолверов
    this.route.data.subscribe(data => {
      this.products = data['products'];
      this.productTypes = data['product_types'];
      this.categories = data['categories'];
      // this.filterProducts();
      this.parseCategories(this.categories);
    });
    console.log(this.products)
    console.log(this.productTypes)
    console.log(this.categories)
  }
}
