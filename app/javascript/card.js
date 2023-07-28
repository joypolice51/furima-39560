const pay = () => {
  const publicKey = gon.public_key
  const payjp = Payjp(publicKey) // PAY.JPテスト公開鍵
  const elements = payjp.elements();  //elementsインスタンスを作成
  const numberElement = elements.create('cardNumber');  //入力フォームを生成
  const expiryElement = elements.create('cardExpiry');  //入力フォームを生成
  const cvcElement = elements.create('cardCvc');        //入力フォームを生成

  numberElement.mount('#number-form');     //()というid属性の要素とフォームを置き換える
  expiryElement.mount('#expiry-form');     //()というid属性の要素とフォームを置き換える
  cvcElement.mount('#cvc-form');           //()というid属性の要素とフォームを置き換える

  const form = document.getElementById('charge-form')
  form.addEventListener("submit", (e) => {
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      document.getElementById("charge-form").submit();
    });
    e.preventDefault();
  });
};

window.addEventListener("turbo:load", pay);