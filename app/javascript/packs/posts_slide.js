// Swiperのオプションを定数化
const opt = {
  loop: true,
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
    delay: 300,
    disableOnInteraction: false, // 矢印をクリックしても自動再生を止めない
  },
};

// $(document).ready(function() {
//     let swiper = new Swiper('.swiper', opt);
// });

$(document).ready(function() {
  // スライドの枚数が表示する枚数より多い場合
  if (postCount > opt.slidesPerView) {
    let swiper = new Swiper('.swiper', opt); // Swiperを初期化
  } else {
    // スライドの枚数が足りない場合、何もしない
  }
});
console.log(opt.slidesPerView);



