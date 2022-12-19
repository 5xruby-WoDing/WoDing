import { Controller } from "stimulus";
import Swiper from 'swiper/swiper-bundle';

export default class extends Controller {
  connect() {
    const swiperTop = new Swiper(".mySwiperTop", {
      spaceBetween: 30,
      effect: "fade",
      autoplay: {
        delay: 2000,
        disableOnInteraction: false,
      },
      navigation: {
        nextEl: ".swiper-button-next-top",
        prevEl: ".swiper-button-prev-top",
      },
      pagination: {
        el: ".swiper-pagination-top",
        clickable: true,
      },
    });
  }
}


