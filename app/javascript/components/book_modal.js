const preventCloseOnClickInsideModal = (bookModal) => {
  bookModal.addEventListener('click', function(event) {
    console.log('inside click event');
    event.preventDefault();
  });
}

export const selectAllBookDetailsModals = () => {
  // let modal = $('#book-popup-14');

  // $('#book-popup-14').options.backdrop = 'static';

  // console.log('modal: ', modal);

  const bookModals = document.querySelectorAll('.modal');

  bookModals.forEach(preventCloseOnClickInsideModal);
}
