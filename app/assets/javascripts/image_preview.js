var imageInput = document.getElementById("district_image")
var imagePreview  = document.getElementById("image_preview")
var imgcheckbox = document.getElementById('district_image_delete')
imageInput.addEventListener('change', (e) => {
  if (imgcheckbox.checked === false) {
    var file = e.target.files[0];
    var blob = window.URL.createObjectURL(file);
    var img = document.querySelector('#preview_img')
    if (img) {
        img.src = blob
    } else {
        img = document.createElement('img');
        img.setAttribute('src', blob);
        img.setAttribute('id', 'preview_img')
        img.setAttribute('style', 'width: 150px; height:')
        imagePreview.appendChild(img);
    }
  }
})
imgcheckbox = document.getElementById('district_image_delete')
imgcheckbox.addEventListener('change', () =>{

    var img = document.querySelector('#preview_img')
    var imgIcon = document.getElementsByClassName('fa-solid fa-image')[0]
    imageInput = document.getElementById("district_image")
    imgcheckbox.value = imgcheckbox.checked === true ? 1 : 0
    if (imgcheckbox.checked === true) {
        imageInput.value = ""
        if (img) {img.remove()}
        if (imgIcon) {imgIcon.remove()}
    } else if (imgcheckbox.checked === false) {
        imgIcon = document.getElementsByClassName('fa-solid fa-image')[0]
        if (!imgIcon) {
          var insertHtml =  `<i class="fa-solid fa-image"></i>`
          imageInput.insertAdjacentHTML('beforebegin', insertHtml)
        }
    }
})