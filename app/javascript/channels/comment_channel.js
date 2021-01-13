import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    let url = window.location.href
    let param = url.split('/');
    let paramContent = param[param.length - 1]
    if (paramContent == data.id) {
    
      const comments = document.getElementById('comments');
      const textElement = document.createElement('div');
      textElement.setAttribute('class', "comment__list");

      const topElement = document.createElement('div');
      topElement.setAttribute('class', "comment__top");

      const bottomElement = document.createElement('div');
      bottomElement.setAttribute('class', "comment__bottom");

      const nameElement = document.createElement('div');
      const timeElement = document.createElement('div');

      comments.insertBefore(textElement, comments.firstElementChild);
      textElement.appendChild(topElement);
      textElement.appendChild(bottomElement);
      bottomElement.appendChild(nameElement);
      bottomElement.appendChild(timeElement);

      const text = `<p>${data.content.text}</p>`;
      topElement.innerHTML = text;
      const name = `${data.name}`;
      nameElement.innerHTML = name;
      const time = `${data.time}`;
      timeElement.innerHTML = time;

      const newComment = document.getElementById('comment_text');
      newComment.value='';

      const inputElement = document.querySelector('input[name="commit"]');
      inputElement.disabled = false;
      
    }
  }
});
