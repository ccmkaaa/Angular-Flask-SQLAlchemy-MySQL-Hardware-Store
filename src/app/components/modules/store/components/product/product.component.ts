import { Component, Inject, ElementRef, HostListener } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { StoreService } from '../../services/store.service';
import { DialogService } from '../../services/dialog.service';
import { MatSnackBar } from '@angular/material/snack-bar';

@Component({
  selector: 'app-product',
  templateUrl: './product.component.html',
  styleUrls: ['./product.component.scss']
})
export class ProductComponent {
  product: any;
  imageUrl!: string;
  quantity!: number;

  constructor(
    public dialogRef: MatDialogRef<ProductComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private elementRef: ElementRef,
    private storeService: StoreService,
    private dialogService: DialogService,
    private snackBar: MatSnackBar
  ) {
    this.product = data.product;
  }

  closeDialog(): void {
    this.dialogRef.close();
    setTimeout(() => {
      this.dialogRef.removePanelClass('fade-in'); // удаляем класс fade-in
  }, 300); // даем время для завершения анимации (300 миллисекунд, согласно длительности анимации)
  }

  loadProductImage(): void {
    this.storeService.getProductImage(this.product.id).subscribe(imageBlob => {
      this.imageUrl = URL.createObjectURL(imageBlob);
    });
  }

  quantityCheck(event: any) {
    let value = parseInt(event.target.value); // Преобразование введенного значения в число

    // Проверяем, является ли значение отрицательным или нулевым
    if (value <= 0 || isNaN(value)) {
      value = 1; // Устанавливаем значение по умолчанию в 1
    }
    event.target.value = Math.abs(value);
  }

  checkValue(event: any) {
    const value = event.target.value;
    if (value === '0') {
      event.target.value = '1';
    }
  }

  addToCart() {
    const data = {
      product: this.product,
      quantity: this.quantity
    }
    this.dialogService.addToCart(data.product, data.quantity);
    this.closeDialog();
    this.snackBar.open('Product added to cart', 'Close', {
      duration: 2000, // Длительность отображения сообщения
      panelClass: ['app-notification-success'] // Дополнительные классы для стилизации сообщения
    });
  }

  @HostListener('document:click', ['$event'])
  onClick(event: MouseEvent) {
    // Проверяем, был ли клик сделан вне элемента диалогового окна
    if (!this.elementRef.nativeElement.contains(event.target) && !this.isAddToCartButton(event.target)) {
      this.closeDialog(); // Закрываем диалоговое окно
    }
  }

  private isAddToCartButton(target: EventTarget | null): boolean {
    // Проверяем, является ли целевой элемент кнопкой "Add To Cart" или его родительским элементом
    while (target instanceof HTMLElement) {
      if (target.classList.contains('add-to-cart')) {
        return true;
      }
      target = target.parentElement;
    }
    return false;
  }

  ngOnInit(): void {
    this.loadProductImage();
    this.quantity = 1;
  }
}
