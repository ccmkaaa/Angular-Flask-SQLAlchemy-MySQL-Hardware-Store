import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class IndexedDBService {
  private dbName = 'myDatabase';
  private dbVersion = 1;
  private db!: IDBDatabase;

  constructor() {
    this.openDatabase();
  }

  openDatabase() {
    const request = indexedDB.open(this.dbName, this.dbVersion);

    request.onerror = (event) => {
      console.error('IndexedDB error:', event);
    };

    request.onsuccess = (event) => {
      this.db = request.result;
      console.log('IndexedDB opened successfully');
    };

    request.onupgradeneeded = (event) => {
      this.db = request.result;
      if (!this.db.objectStoreNames.contains('myObjectStore')) {
        this.db.createObjectStore('myObjectStore', { keyPath: 'id' });
      }
      console.log('IndexedDB upgraded');
    };
  }

  addToDatabase(data: any) {
    const transaction = this.db.transaction('myObjectStore', 'readwrite');
    const store = transaction.objectStore('myObjectStore');
    store.add(data);
  }

  getAllData() {
    const transaction = this.db.transaction('myObjectStore', 'readonly');
    const store = transaction.objectStore('myObjectStore');
    const request = store.getAll();

    return new Promise<any[]>((resolve, reject) => {
      request.onerror = (event) => {
        reject(request.error);
      };

      request.onsuccess = (event) => {
        resolve(request.result);
      };
    });
  }
}
