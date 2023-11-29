import { Directive, Input, ViewContainerRef } from '@angular/core';

@Directive({
  selector: '[appDynamicComponent]'
})
export class DynamicComponentDirective {
  @Input() component: any;

  constructor(public viewContainerRef: ViewContainerRef) {}
}
