import { Controller } from "stimulus";
import Swiper from 'swiper/swiper-bundle';

export default class extends Controller {
  connect() {
    var getSwiperHeaderClass = document.querySelector(".mySwiperTop");
    if (getSwiperHeaderClass){
      const swipeTwo = new Swiper(".mySwiperTop", {
        cssMode: true,
        navigation: {
          nextEl: ".swiper-button-next-top",
          prevEl: ".swiper-button-prev-top",
        },
        pagination: {
          el: ".swiper-pagination-top",
        },
        mousewheel: true,
        keyboard: true,
      });
    }
  }
}
