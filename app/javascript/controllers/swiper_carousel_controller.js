import { Controller } from "stimulus";
import Swiper from 'swiper/swiper-bundle';

export default class extends Controller {
  connect() {
      new Swiper(".mySwiper", {
      loop: true,
      loopFillGroupWithBlank: true,
      autoplay: {
        delay: 3000,
        disableOnInteraction: false,
      },
      pagination: {
        el: ".swiper-pagination",
        clickable: true,
      },
      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },
      breakpoints: {
        1: {
          slidesPerView: 1,
          spaceBetween: 30,
          slidesPerGroup: 1,
        },
        768: {
          slidesPerView: 3,
          spaceBetween: 30,
          slidesPerGroup: 3,
        },
      }
    });
  }
}
