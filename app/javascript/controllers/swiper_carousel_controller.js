import { Controller } from "stimulus";
import Swiper from 'swiper/swiper-bundle';

export default class extends Controller {
  connect() {
    var getSwiperClass = document.querySelector(".mySwiper");
    if (getSwiperClass){
      const swiper = new Swiper(".mySwiper", {
        effect: "coverflow",
        grabCursor: true,
        centeredSlides: true,
        slidesPerView: "auto",
        coverflowEffect: {
          rotate: 50,
          stretch: 0,
          depth: 50,
          modifier: 0.5,
          slideShadows: true,
        },
        pagination: {
          el: ".swiper-pagination",
        },
      });
    }
  }
}
