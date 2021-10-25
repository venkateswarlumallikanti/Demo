import {LightningElement, track, wire, api} from 'lwc';
import getTreeData from '@salesforce/apex/DynamicTreeGridController.getTreeData';
export default class dynamicTreeGrid extends LightningElement {
     @track treeItems;
     @track error;
     @api recordId;
     @wire(getTreeData, {accId: '$recordId'})
    wireTreeData({error,data}) {
         if (data) {
             this.treeItems = data;
             console.log(JSON.stringify(data, null, '\t'));
         } else {
             this.error = error;
         }
     }
}
