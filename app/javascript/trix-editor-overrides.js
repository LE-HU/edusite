// Blacklist all file attachments
// window.addEventListener("trix-file-accept", function (event) {
//   event.preventDefault();
//   alert("File attachment not supported.");
// });

// Whitelist images
// window.addEventListener("trix-file-accept", function (event) {
//   const acceptedTypes = ["image/jpeg", "image/jpg", "image/png"];
//   if (!acceptedTypes.includes(event.file.type)) {
//     event.preventDefault();
//     alert("Allowed file types - jpeg, jpg, png.");
//   }
// });

// File size specification
// window.addEventListener("trix-file-accept", function (event) {
//   const maxFileSize = 1024 * 1024; // 1MB
//   if (event.file.size > maxFileSize) {
//     event.preventDefault();
//     alert("Maximum filesize - 1MB");
//   }
// });

window.addEventListener("trix-file-accept", function (event) {
  const maxFileSize = 3000 * 3000; // around 9MB
  if (event.file.size > maxFileSize) {
    event.preventDefault();
    alert("Only support attachment files upto 9MB in size!");
  }
});
