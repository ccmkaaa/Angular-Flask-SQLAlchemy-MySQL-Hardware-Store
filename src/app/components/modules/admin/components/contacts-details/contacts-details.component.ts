import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { User } from '../../user';
import { ActivatedRoute, Params } from '@angular/router';
import { AdminService } from '../../services/admin.service';
import { map } from 'rxjs/operators';

@Component({
  selector: 'app-contacts-details',
  templateUrl: './contacts-details.component.html',
  styleUrls: ['./contacts-details.component.scss']
})
export class ContactsDetailsComponent implements OnInit {
  id!: number;
  user!: Observable<User>

  constructor(private activateRoute: ActivatedRoute, private adminService: AdminService) {}

  ngOnInit(): void {
    this.user = this.activateRoute.data.pipe(map((data) => data?.['user']))
  }

}
