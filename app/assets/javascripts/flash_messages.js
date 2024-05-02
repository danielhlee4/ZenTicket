document.addEventListener('DOMContentLoaded', () => {
    const flashMessages = document.querySelectorAll('.alert');
  
    flashMessages.forEach(flash => {
        if (flash.classList.contains('alert-success')) {
            setTimeout(() => {
                flash.classList.remove('show');
            }, 3000);
            setTimeout(() => {
                flash.remove();
            }, 3200);
        }
    });
});