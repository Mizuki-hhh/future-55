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
      const comment = document.getElementsByClassName('comments__list');

      const textElement = document.createElement('div');
      textElement.setAttribute('class', "comment__list");

      const topElement = document.createElement('div');
      topElement.setAttribute('class', "comment__top");

      const bottomElement = document.createElement('div');
      bottomElement.setAttribute('class', "comment__bottom");

      const nameElement = document.createElement('div');
      nameElement.setAttribute('class', "comment__name");
      const timeElement = document.createElement('div');
      timeElement.setAttribute('class', "comment__date");

      comments.insertBefore(textElement, comments.firstElementChild);
      textElement.appendChild(topElement);
      textElement.appendChild(bottomElement);
      bottomElement.appendChild(nameElement);
      bottomElement.appendChild(timeElement);

      const text = `<p>${data.content.text}</p>`;
      const br = text.replace(/\n|\r\n|\r/g, "<br>");
      topElement.innerHTML = text;
      const name = `${data.name}`;
      nameElement.innerHTML = name;
      const time = `${data.time}`;
      timeElement.innerHTML = time;

      const newComment = document.getElementById('comment_text');
      newComment.value='';

      const inputElement = document.querySelector('input[name="commit"]');
      inputElement.disabled = false;

    }else{

      const newComment = document.getElementById('comment_text');
      newComment.value='';
      const comments = document.getElementById('comments');
      const comment = document.getElementsByClassName('field_with_errors');

      const textElement = document.createElement('div');
      textElement.setAttribute('class', "comment__list");

      const topElement = document.createElement('div');
      topElement.setAttribute('class', "comment__top");

      const bottomElement = document.createElement('div');
      bottomElement.setAttribute('class', "comment__bottom");

      const nameElement = document.createElement('div');
      nameElement.setAttribute('class', "comment__name");
      const timeElement = document.createElement('div');
      timeElement.setAttribute('class', "comment__date");

      comments.insertBefore(textElement, comments.firstElementChild);
      textElement.appendChild(topElement);
      textElement.appendChild(bottomElement);
      bottomElement.appendChild(nameElement);
      bottomElement.appendChild(timeElement);

      const text = `<p>${data.content.text}</p>`;
      const br = text.replace(/\n|\r\n|\r/g, "<br>");
      topElement.innerHTML = text;
      const name = `${data.name}`;
      nameElement.innerHTML = name;
      const time = `${data.time}`;
      timeElement.innerHTML = time;

      const newNewComment = document.getElementById('comment_text');
      newNewComment.value='';

      const inputElement = document.querySelector('input[name="commit"]');
      inputElement.disabled = false;
    }
  }
});
