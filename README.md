# FirstApp

This project was generated with [Angular CLI](https://github.com/angular/angular-cli) version 16.2.4.

## Development server

Run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. The application will automatically reload if you change any of the source files.

## Code scaffolding

Run `ng generate component component-name` to generate a new component. You can also use `ng generate directive|pipe|service|class|guard|interface|enum|module`.

## Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory.

## Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io).

## Running end-to-end tests

Run `ng e2e` to execute the end-to-end tests via a platform of your choice. To use this command, you need to first add a package that implements end-to-end testing capabilities.

## Further help

To get more help on the Angular CLI use `ng help` or go check out the [Angular CLI Overview and Command Reference](https://angular.io/cli) page.

```
First_App
├─ .angular
├─ angular.json
├─ package-lock.json
├─ package.json
├─ README.md
├─ Server_Flask
│  ├─ admin
│  │  ├─ db
│  │  │  ├─ conn.py
│  │  │  └─ __pycache__
│  │  │     └─ conn.cpython-311.pyc
│  │  ├─ products
│  │  │  ├─ get_products.py
│  │  │  ├─ get_set_edit_products.py
│  │  │  ├─ set_products.py
│  │  │  ├─ __init__.py
│  │  │  └─ __pycache__
│  │  │     ├─ get_cats.cpython-311.pyc
│  │  │     ├─ get_products.cpython-311.pyc
│  │  │     ├─ get_produtcs.cpython-311.pyc
│  │  │     ├─ get_set_edit_products.cpython-311.pyc
│  │  │     ├─ set_products.cpython-311.pyc
│  │  │     └─ __init__.cpython-311.pyc
│  │  ├─ __init__.py
│  │  └─ __pycache__
│  │     └─ __init__.cpython-311.pyc
│  ├─ alchemy
│  │  ├─ model.py
│  │  ├─ __init__.py
│  │  └─ __pycache__
│  │     ├─ model.cpython-311.pyc
│  │     └─ __init__.cpython-311.pyc
│  ├─ app.py
├─ src
│  ├─ app
│  │  ├─ app-routing.module.ts
│  │  ├─ app.component.html
│  │  ├─ app.component.scss
│  │  ├─ app.component.ts
│  │  ├─ app.module.ts
│  │  ├─ components
│  │  │  ├─ login
│  │  │  │  ├─ login.component.html
│  │  │  │  ├─ login.component.scss
│  │  │  │  └─ login.component.ts
│  │  │  ├─ modules
│  │  │  │  ├─ admin
│  │  │  │  │  ├─ admin-routing.module.ts
│  │  │  │  │  ├─ admin.module.ts
│  │  │  │  │  ├─ components
│  │  │  │  │  │  ├─ admin-dashboard
│  │  │  │  │  │  │  ├─ admin-dashboard.component.html
│  │  │  │  │  │  │  ├─ admin-dashboard.component.scss
│  │  │  │  │  │  │  ├─ admin-dashboard.component.spec.ts
│  │  │  │  │  │  │  └─ admin-dashboard.component.ts
│  │  │  │  │  │  ├─ contacts
│  │  │  │  │  │  │  ├─ contacts.component.html
│  │  │  │  │  │  │  ├─ contacts.component.scss
│  │  │  │  │  │  │  └─ contacts.component.ts
│  │  │  │  │  │  ├─ contacts-details
│  │  │  │  │  │  │  ├─ contacts-details.component.html
│  │  │  │  │  │  │  ├─ contacts-details.component.scss
│  │  │  │  │  │  │  └─ contacts-details.component.ts
│  │  │  │  │  │  ├─ footer
│  │  │  │  │  │  │  ├─ footer.component.html
│  │  │  │  │  │  │  ├─ footer.component.scss
│  │  │  │  │  │  │  ├─ footer.component.spec.ts
│  │  │  │  │  │  │  └─ footer.component.ts
│  │  │  │  │  │  ├─ header
│  │  │  │  │  │  │  ├─ header.component.html
│  │  │  │  │  │  │  ├─ header.component.scss
│  │  │  │  │  │  │  ├─ header.component.spec.ts
│  │  │  │  │  │  │  └─ header.component.ts
│  │  │  │  │  │  ├─ home
│  │  │  │  │  │  │  ├─ home.component.html
│  │  │  │  │  │  │  ├─ home.component.scss
│  │  │  │  │  │  │  ├─ home.component.spec.ts
│  │  │  │  │  │  │  └─ home.component.ts
│  │  │  │  │  │  ├─ product-list
│  │  │  │  │  │  │  ├─ formAddNewProduct
│  │  │  │  │  │  │  │  ├─ formaddnewproduct.component.html
│  │  │  │  │  │  │  │  ├─ formaddnewproduct.component.scss
│  │  │  │  │  │  │  │  └─ formaddnewproduct.component.ts
│  │  │  │  │  │  │  ├─ list
│  │  │  │  │  │  │  │  ├─ list.component.html
│  │  │  │  │  │  │  │  ├─ list.component.scss
│  │  │  │  │  │  │  │  └─ list.component.ts
│  │  │  │  │  │  │  ├─ product
│  │  │  │  │  │  │  │  ├─ product.component.html
│  │  │  │  │  │  │  │  ├─ product.component.scss
│  │  │  │  │  │  │  │  └─ product.component.ts
│  │  │  │  │  │  │  ├─ product-list.component.html
│  │  │  │  │  │  │  ├─ product-list.component.scss
│  │  │  │  │  │  │  └─ product-list.component.ts
│  │  │  │  │  │  └─ products
│  │  │  │  │  │     ├─ edit
│  │  │  │  │  │     │  ├─ edit.component.html
│  │  │  │  │  │     │  ├─ edit.component.scss
│  │  │  │  │  │     │  └─ edit.component.ts
│  │  │  │  │  │     ├─ products.component.html
│  │  │  │  │  │     ├─ products.component.scss
│  │  │  │  │  │     ├─ products.component.ts
│  │  │  │  │  │     └─ show
│  │  │  │  │  │        ├─ show.component.html
│  │  │  │  │  │        ├─ show.component.scss
│  │  │  │  │  │        └─ show.component.ts
│  │  │  │  │  ├─ directives
│  │  │  │  │  │  └─ dynamic-component.directive.ts
│  │  │  │  │  ├─ pipe
│  │  │  │  │  │  ├─ price-format.pipe.ts
│  │  │  │  │  │  └─ search-filter.pipe.ts
│  │  │  │  │  ├─ product.ts
│  │  │  │  │  ├─ resolvers
│  │  │  │  │  │  ├─ product-type.resolver.ts
│  │  │  │  │  │  ├─ products.resolver.ts
│  │  │  │  │  │  ├─ user.resolver.ts
│  │  │  │  │  │  └─ users.resolver.ts
│  │  │  │  │  ├─ services
│  │  │  │  │  │  └─ admin.service.ts
│  │  │  │  │  └─ user.ts
│  │  │  │  ├─ admin.rar
│  │  │  │  └─ interface
│  │  │  │     └─ product_type.ts
│  │  │  └─ not-found
│  │  │     ├─ not-found.component.html
│  │  │     ├─ not-found.component.scss
│  │  │     └─ not-found.component.ts
│  │  ├─ guards
│  │  │  └─ auth
│  │  │     ├─ auth-ca.guard.ts
│  │  │     └─ auth-cd.guard.ts
│  │  └─ services
│  │     ├─ auth.service.ts
│  │     └─ db
│  │        └─ indexed-db.service.ts
│  ├─ assets
│  │  ├─ .gitkeep
│  │  ├─ images
│  │  │  ├─ app
│  │  │  │  └─ sql_query
│  │  │  │     ├─ insert into.txt
│  │  │  │     ├─ triggers after insert to insert to all_product.txt
│  │  │  │     ├─ triggers for id and fields.txt
│  │  │  │     ├─ triggers.txt
│  │  │  │     └─ update_all_prod product_type.txt
│  │  │  └─ products
│  │  │     ├─ cpu
│  │  │     │  ├─ 18.jpg
│  │  │     │  ├─ 19.jpg
│  │  │     │  ├─ 20.jpg
│  │  │     │  ├─ 21.jpg
│  │  │     │  ├─ 22.jpg
│  │  │     │  ├─ 23.jpg
│  │  │     │  ├─ 24.jpg
│  │  │     │  ├─ 25.jpg
│  │  │     │  ├─ 26.jpg
│  │  │     │  ├─ 27.jpg
│  │  │     │  └─ 28.jpg
│  │  │     ├─ gpu
│  │  │     │  ├─ 1.jpg
│  │  │     │  ├─ 10.jpg
│  │  │     │  ├─ 11.jpg
│  │  │     │  ├─ 12.jpg
│  │  │     │  ├─ 13.jpg
│  │  │     │  ├─ 14.jpg
│  │  │     │  ├─ 15.jpg
│  │  │     │  ├─ 16.jpg
│  │  │     │  ├─ 17.jpg
│  │  │     │  ├─ 2.jpg
│  │  │     │  ├─ 3.jpg
│  │  │     │  ├─ 4.jpg
│  │  │     │  ├─ 5.jpg
│  │  │     │  ├─ 6.jpg
│  │  │     │  ├─ 7.jpg
│  │  │     │  ├─ 8.jpg
│  │  │     │  └─ 9.jpg
│  │  │     ├─ mb
│  │  │     │  ├─ 37.jpg
│  │  │     │  ├─ 38.jpg
│  │  │     │  ├─ 39.jpg
│  │  │     │  ├─ 40.jpg
│  │  │     │  ├─ 41.jpg
│  │  │     │  ├─ 42.jpg
│  │  │     │  ├─ 43.jpg
│  │  │     │  ├─ 44.jpg
│  │  │     │  ├─ 45.jpg
│  │  │     │  ├─ 46.jpg
│  │  │     │  └─ 47.jpg
│  │  │     └─ ram
│  │  │        ├─ 29.jpg
│  │  │        ├─ 30.jpg
│  │  │        ├─ 31.jpg
│  │  │        ├─ 32.jpg
│  │  │        ├─ 33.jpg
│  │  │        ├─ 34.jpg
│  │  │        ├─ 35.jpg
│  │  │        └─ 36.jpg
│  │  └─ products.json
│  ├─ favicon.ico
│  ├─ index.html
│  ├─ main.ts
│  └─ styles.scss
├─ tsconfig.app.json
├─ tsconfig.json
└─ tsconfig.spec.json

```
