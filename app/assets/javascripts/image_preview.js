let imageInput = document.getElementById("district_image")
let imagePreview  = document.getElementById("image_preview")
let imgcheckbox = document.getElementById('district_image_delete')
imageInput.addEventListener('change', (e) => {
  if (imgcheckbox.checked === false) {
    let file = e.target.files[0];
    let blob = window.URL.createObjectURL(file);
    let img = document.querySelector('#preview_img')
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

    let img = document.querySelector('#preview_img')
    let imgIcon = document.getElementsByClassName('fa-solid fa-image')[0]
    imageInput = document.getElementById("district_image")
    imgcheckbox.value = imgcheckbox.checked === true ? 1 : 0
    if (imgcheckbox.checked === true) {
        imageInput.value = ""
        if (img) {img.remove()}
        if (imgIcon) {imgIcon.remove()}
    } else if (imgcheckbox.checked === false) {
        imgIcon = document.getElementsByClassName('fa-solid fa-image')[0]
        if (!imgIcon) {
          let insertHtml =  `<i class="fa-solid fa-image"></i>`
          imageInput.insertAdjacentHTML('beforebegin', insertHtml)
        }
    }
})