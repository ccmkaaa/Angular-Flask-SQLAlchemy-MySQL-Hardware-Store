import { Component, OnInit } from '@angular/core';
import { Observable, filter, mapTo, map, merge } from 'rxjs';
import {User} from '../../user';
import { AdminService } from '../../services/admin.service';
import { Router, ResolveStart, ResolveEnd, ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-contacts',
  templateUrl: './contacts.component.html',
  styleUrls: ['./contacts.component.scss']
})
export class ContactsComponent implements OnInit{

  personalList!: Observable<User[]>

  constructor(private adminService: AdminService, private router: Router, private activatedRoute: ActivatedRoute) {}

  ngOnInit(): void {
      this.personalList = this.activatedRoute.data.pipe(map((data) => data?.['users'])) // this.adminService.getPersonalList()
  }

}
