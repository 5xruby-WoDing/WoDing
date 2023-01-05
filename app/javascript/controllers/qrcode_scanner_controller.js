import { Controller } from "stimulus"
import QrScanner from 'qr-scanner'
import Swal from 'sweetalert2'

export default class extends Controller {
  static targets = [ 'video' ]

  connect(){}

  openLens() {    
    this.qrScanner = new QrScanner(
      this.videoTarget,
      result => {fetch(result.data, {
                   method: "GET"
                 })
                 .then((resp) => {
                   return resp.json()
                 })
                 .then(({message, reservation, seat, id}) => {                                                           
                   if (message === "success") {
                    Swal.fire({
                      title: '報到成功!',
                      text: `${reservation.name}${reservation.gender}，預約的座位為${seat.title}號的${seat.kind}`,
                      icon: 'success',
                      confirmButtonText: '進行帶位'
                    }).then(() => {
                      window.location = `/backstage/restaurants/${id}/seats`
                    })                   
                   } else {
                    Swal.fire({
                      title: '報到失敗!',
                      text: '您的QRCODE過期',
                      icon: 'error',
                      confirmButtonText: '離開'
                    })
                   }
                 })
                 .catch((err) => {
                   console.log(err);
                 });
                 this.qrScanner.stop()},      
      { highlightScanRegion: true, highlightCodeOutline: true},            
    );
    this.qrScanner.start()
  }

  closeLens() {
    this.qrScanner.stop()
  }
}