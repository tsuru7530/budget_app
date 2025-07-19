let imageInput = document.getElementById("district_image")
let imagePreview  = document.getElementById("image_preview")
imageInput.addEventListener('change', (e) => {
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
})
let imgcheckbox = document.getElementById('district_image_delete')
imgcheckbox.addEventListener('change', () =>{
    let img = document.querySelector('#preview_img')
    if (imgcheckbox.checked === true && img) {
        img.remove()
    }
})