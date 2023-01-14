$(document).on('turbolinks:load', function(){
  
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

