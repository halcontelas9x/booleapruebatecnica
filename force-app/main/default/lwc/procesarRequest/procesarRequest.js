import { LightningElement, api, wire } from 'lwc';
import procesarRegistro from '@salesforce/apex/SupportRequestLwcController.procesarRegistro';
import getEstadoRegistro from '@salesforce/apex/SupportRequestLwcController.estadoRegistro';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import SUPPORTREQUESTCLOSED from '@salesforce/label/c.SupportRequestClosed';
import SUPPORTREQUESTPROCESED from '@salesforce/label/c.SupportRequestProcesed';

export default class ProcesarRequest extends LightningElement {
    @api recordId;
    estadoRequest;

    labels = {
        SUPPORTREQUESTCLOSED,
        SUPPORTREQUESTPROCESED
    }

    @api invoke() {
        getEstadoRegistro({ recordId: this.recordId })
            .then(result => {
                console.log('Estado del registro:', result);
                if (result == 'Closed') {
                    this.dispatchEvent(new ShowToastEvent({
                            title: 'Error',
                            message: SUPPORTREQUESTCLOSED,
                            variant: 'error'
                        }));
                } else {
                    procesarRegistro({ recordId: this.recordId })
                    .then(() => {
                        this.dispatchEvent(new ShowToastEvent({
                            title: 'Éxito',
                            message: SUPPORTREQUESTPROCESED,
                            variant: 'success'
                        }));
                        setTimeout(() => {
                            window.location.reload();
                        }, 1000);
                    })
                    .catch(error => {
                        this.dispatchEvent(new ShowToastEvent({
                            title: 'Error',
                            message: error.body.message,
                            variant: 'error'
                        }));
                    });
                }
            }).catch(error => {
                this.showToast('Error', error.body.message, 'error');
            });
        }
}