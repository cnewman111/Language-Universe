// app/assets/javascripts/auto_dismiss_alerts.js

document.addEventListener('turbo:load', function() {
    const autoDismissAlerts = document.querySelectorAll('.alert.auto-dismiss');
    autoDismissAlerts.forEach(function(alertElement) {
      setTimeout(function() {
        alertElement.classList.add('fade');
        alertElement.addEventListener('transitionend', function() {
          alertElement.remove();
        });
        alertElement.style.opacity = '0';
      }, 3000);
    });
  });
  
  
  
  