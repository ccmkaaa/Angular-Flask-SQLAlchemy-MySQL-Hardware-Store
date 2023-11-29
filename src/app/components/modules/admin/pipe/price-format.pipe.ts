import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'priceFormat'
})
export class PriceFormatPipe implements PipeTransform {
  transform(value: number): string {
    // Преобразование числа в строку и добавление пробелов каждые три цифры
    return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ' ');
  }
}
