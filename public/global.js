// Gets hamburger menu
//
// Returns Element
function get_hamburger_menu() {
  return document.getElementById("homenav");
}
// Sets a toggle on our menu to show/hide
// 
// Returns nothing
function toggle_hamburger_menu() {
  var h = get_hamburger_menu();
  h.classList.toggle("grow_hamburger_menu");
  h.classList.toggle("shrink_hamburger_menu");  
}
// Change the classes on the specified element
// 
// Takes 3 arguments, the String of the element_name we want to change, the String
// of the class_to_add to the Element, and the String of the class_to_remove
// from the Element.
// 
// Returns nothing
function change_attached_class(element_name, class_to_add, class_to_remove) {
  document.getElementById(element_name).classList.add(class_to_add);
  document.getElementById(element_name).classList.remove(class_to_remove);
}
// Changes the classes of two images and the height of the header based on the y-position
// of the scroll.
// 
// Returns nothing.
function run_on_width () {
  if (this.innerWidth > 700) {
    document.getElementById("homenav").classList.remove("shrink_hamburger_menu");
  } else {
    change_attached_class("homenav", "shrink_hamburger_menu", "grow_hamburger_menu");
  }
}



window.onload = function() {
  var x = document.getElementsByClassName("menu");
  x[0].addEventListener("click", toggle_hamburger_menu); 
  
  window.addEventListener("resize", run_on_width);
}
