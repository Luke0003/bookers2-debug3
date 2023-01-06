import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("テスト")
    const html = `<p style="text-align: right;">${data.content.message}</p>`;
    const messages = document.getElementById('messages');
    const newMessage = document.getElementById('chat_message');
    messages.insertAdjacentHTML('beforeend', html);
    newMessage.value = '';
  }
});
