import { Component, ElementRef, HostListener, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { CartService } from '../../services/cart.service';

@Component({
  selector: 'app-payment',
  templateUrl: './payment.component.html',
  styleUrls: ['./payment.component.scss'],
})
export class PaymentComponent {
  total_amount!: number;
  paymentForm: FormGroup;

  constructor(
    public dialogRef: MatDialogRef<PaymentComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private elementRef: ElementRef,
    private cartService: CartService,
    private formBuilder: FormBuilder
  ) {
    this.total_amount = this.data.total_amount;
    this.paymentForm = this.formBuilder.group({
      cardNumber: ['', [Validators.required, Validators.pattern(/^\d{4}\s\d{4}\s\d{4}\s\d{4}$/)]],
      expirationDate: ['', [Validators.required, Validators.pattern(/^\d{2}\/\d{2}$/)]],
      cvc: ['', [Validators.required, Validators.pattern(/^\d{3,4}$/)]],
    });
  }

  closeDialog() {
    this.dialogRef.close();
  }

  @HostListener('document:click', ['$event'])
  onClick(event: MouseEvent) {
    const target = event.target as HTMLElement;
    if (!this.elementRef.nativeElement.querySelector('.dialog-content').contains(target)) {
      const isBuyButtonClicked = target.classList.contains('buy-button');
      if (!isBuyButtonClicked) {
        this.closeDialog();
      }
    }
  }

  submitForm() {
    if (this.paymentForm.valid) {
      // Здесь можно отправить данные платежа на сервер или выполнить другие действия
      console.log('Payment form submitted:', this.paymentForm.value);
      this.dialogRef.close();
    }
  }

  makeOrder() {
    this.cartService.orderCart(this.total_amount)
    localStorage.removeItem('cart')
    alert('Order is complete')
    this.closeDialog()
  }
}
