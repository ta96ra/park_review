$(document).on('turbolinks:load', function(){
  
  //-------------------
  // 5段階評価
  //-------------------
  
  //---------------------
  // ハンバーガーメニュー
  //---------------------
    const hamburger = document.getElementById('hamburger');
    const sp = document.querySelector('.sp');
    hamburger.addEventListener('click',()=>{
    hamburger.classList.toggle('rotate');
    sp.classList.toggle('slide');
  });
  
  //-------------------
  // 利用規約の同意
  //-------------------
    const checkbox = document.getElementById('checkbox');
    // 送信ボタン
    const submit_btn = document.getElementById(`submit`);
    // チェックボックスをクリックした時
    // checkbox.addEventListener("click", () => {
    // チェックボックスの入力イベント
    checkbox.addEventListener('change',() => {
    	// チェックボックスがあれば無効化をオフ、なければオン
    	if (checkbox.checked === true) {
    		submit_btn.disabled = false;
    	} else {
    		submit_btn.disabled = true;
    	}
    });
  
  // -------------------
  // トップへ戻るボタン
  //--------------------
  
  // Intersection Overver APIなどの定義
  const index = document.getElementById('index');
  const toTop = document.getElementById('to-top');
  const observer = new IntersectionObserver(callback);
  observer.observe(index);
  
  // header下のindexが見えなくなれば、to-topボタンの表示
  function callback(entries){
    entries.forEach(entry => {
      if(!entry.isIntersecting){
        toTop.classList.add('scrolled');
      }else{
        toTop.classList.remove('scrolled');
      }
    });
  }
  // to-topを押したらスクロールトップ
  toTop.addEventListener('click',e=>{
  e.preventDefault();
    window.scrollTo({
      top:0,
      behavior:'smooth',
    });
  });
  
  
});

