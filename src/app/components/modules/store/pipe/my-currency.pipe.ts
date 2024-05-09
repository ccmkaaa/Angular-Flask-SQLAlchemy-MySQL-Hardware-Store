import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'myCurrency'
})
export class MyCurrencyPipe implements PipeTransform {

  transform(value: number): string {
    // Преобразование числа в строку и добавление разделителей
    return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  }

}
