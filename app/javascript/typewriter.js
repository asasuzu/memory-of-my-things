document.addEventListener("DOMContentLoaded", function() {
  const typewriter = (param) => {
    let el = document.querySelector(param.el);
    let speed = param.speed;
    let string = param.string.split("");
    string.forEach((char, index) => {
      setTimeout(() => {
        el.textContent += char;
      }, speed * index);
    });
  };

  const message = document.getElementById("typewriter").getAttribute("data-message");

  typewriter({
    el: "#typewriter",
    string: message,
    speed: 90,
  });
});