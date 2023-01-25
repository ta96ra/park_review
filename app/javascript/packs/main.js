$(document).on('turbolinks:load', function(){
  
  //---------------------
  // ハンバーガーメニュー
  //---------------------
    const hamburger = document.getElementById('hamburger');
    const sp = document.querySelector('.sp');
    hamburger.addEventListener('click',()=>{
    hamburger.classList.toggle('rotate');
    sp.classList.toggle('slide');
  });
  
  // --------------------
  // スクロールフェード
  // --------------------
  const targets = document.querySelectorAll('.target');
  // console.log(targets);
  
  function scrollCallback(entries,obs){
    // console.log(entries);
    entries.forEach(entry=>{
      // targetとrootが交差していなければ、処理終了
      if(!entry.isIntersecting){
        // console.log('none');
        return;
      }
      // 交差していればappearクラスの追加
      entry.target.classList.add('appear');
      // console.log('ok');
      obs.unobserve(entry.target);
    });
  }
  const options = {threshold:0.3,rootMargin:'0px 0px -200px'};
  const scrollObserver = new IntersectionObserver(scrollCallback,options);
  targets.forEach(target =>{
    scrollObserver.observe(target);  
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

