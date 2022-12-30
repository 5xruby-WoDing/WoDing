import { Controller } from "stimulus"
import QrScanner from 'qr-scanner'
import Swal from 'sweetalert2'


export default class extends Controller {
  static targets = [ 'video', 'scanRegion' ]

  connect(){
  }

  openLens() {
    

    this.qrScanner = new QrScanner(
      this.videoTarget,
      result => {console.log('decoded qr code:', result.data);
                 fetch(result.data, {
                   method: "GET"
                 })
                 .then((resp) => {
                   return resp.json()
                 })
                 .then((data) => {
                   console.log(data)
                 })
                 .catch((err) => {
                   console.log(err);
                 });
                 this.qrScanner.stop()},
      
      { highlightScanRegion: true, highlightCodeOutline: true},
      
      
    );
    
    this.qrScanner.start()
    

  

    // Swal.fire({
    //   title: 'success!',
    //   text: '確認訂位',
    //   icon: 'success',
    //   confirmButtonText: 'Cool'
    // })


  }

  closeLens() {
    this.qrScanner.stop()
  }


}



