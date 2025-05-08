document.addEventListener('turbo:load', function() {
  document.addEventListener('change', function(event) {
    let image_upload = document.querySelector('#micropost_image');
    const size_in_megabytes = image_upload.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert(I18n.t("micropost.image_alert"));
      image_upload.value = '';
    }
  });
});
