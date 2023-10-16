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
  autoplay: {
    delay: 1000,
    disableOnInteraction: false, // 矢印をクリックしても自動再生を止めない
  },
  slidesPerView: getCurrentSlidesPerView(),
};

function getCurrentSlidesPerView() {
  const screenWidth = window.innerWidth; // 現在の画面幅を取得

  if (screenWidth >= 1240) {
    return 4;
  } else if (screenWidth >= 920) {
    return 3;
  } else if (screenWidth >= 600) {
    return 2;
  } else {
    return 1; // 600未満の場合は1を返す
  }
}

let swiper;

function initializeSwiper() {
  opt.slidesPerView = getCurrentSlidesPerView(); // スライド表示数を更新

  // 既存のSwiperインスタンスが存在する場合、破棄
  if (swiper) {
    swiper.destroy();
  }
  // 投稿の数がスライド表示数より多ければ、ループさせる
  opt.loop = postCount > opt.slidesPerView;
  // 新しいSwiperインスタンスを初期化
  swiper = new Swiper('.swiper', opt);
}

// ウィンドウの幅が変更されたときにスライダーを再初期化
window.onresize = function () {
  initializeSwiper();
};

// ドキュメントが読み込まれたときに初期化
$(function () {
  initializeSwiper();
});