// Swiperのオプションを定数化
const opt = {
  pagination: {
    el: '.swiper-pagination',
    clickable: true, // クリック有効化
  },
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  },
  spaceBetween: 10,
  slidesPerView: 1,
  breakpoints: {
    1240: {
      slidesPerView: 4,
    },
    920: {
      slidesPerView: 3,
    },
    600: {
      slidesPerView: 2,
    },
  },
  autoplay: {
    delay: 1000,
    disableOnInteraction: false, // 矢印をクリックしても自動再生を止めない
  },
};

function getCurrentSlidesPerView() {
  const windowWidth = window.innerWidth;
  let newSlidesPerView = opt.slidesPerView;

  for (const breakpoint in opt.breakpoints) {
    if (windowWidth >= parseInt(breakpoint)) {
      newSlidesPerView = opt.breakpoints[breakpoint].slidesPerView;
    }
  }

  return newSlidesPerView;
}

let swiper; // Swiperを格納する変数を宣言

$(document).ready(function() {
  const currentSlidesPerView = getCurrentSlidesPerView();

  if (postCount > currentSlidesPerView) {
    opt.loop = true;
  } else {
    // スライドの枚数が足りない場合、ループを無効に
    opt.loop = false;
  }

  swiper = new Swiper('.swiper', opt);
});
