const menu = document.querySelector("#mobile-menu");
const menuLinks = document.querySelector(".navbar-menu");

// amikor a felhhasználó a három csíkra katting mobil nézetben...
menu.addEventListener("click", function() {
    menu.classList.toggle("is-active");
    menuLinks.classList.toggle("active");
});