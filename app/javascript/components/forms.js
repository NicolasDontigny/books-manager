const addAuthorInput = (_) => {
  let newAuthorsDiv = document.getElementById('new-authors');

  if (!newAuthorsDiv) return;

  let inputHTML = `\
    <div class="form-row">\
      <div class='col-md-4 mb-3'>\
        <input type='text' class='form-control' name='book[new_authors][][first_name]' placeholder='First name'></input>\
      </div>\
      <div class='col-md-4 mb-3'>\
        <input type='text' class='form-control' name='book[new_authors][][last_name]' placeholder='Last name'></input>\
      </div>\
    </div>\
  `;

  newAuthorsDiv.insertAdjacentHTML('beforeend', inputHTML);
}

export const addNewAuthorToForm = () => {
  const authorButton = document.getElementById('add-author');
  if (authorButton) {
    authorButton.addEventListener('click', addAuthorInput);
  }
};

const addCategoryInput = (_) => {
  let newCategoriesDiv = document.getElementById('new-categories');

  if (!newCategoriesDiv) return;

  let inputHTML = `\
    <div class='col-md-3 mb-3'>\
      <input type='text' class='form-control' name='book[new_categories][][name]' placeholder='Name'></input>\
    </div>\
  `;

  newCategoriesDiv.insertAdjacentHTML('beforeend', inputHTML);
}

export const addNewCategoryToForm = () => {
  const categoryButton = document.getElementById('add-category');
  if (categoryButton) {
    categoryButton.addEventListener('click', addCategoryInput);
  }
};

