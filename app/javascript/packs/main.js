$(document).on('turbolinks:load', function(){
  
  //-------------------
  // 5段階評価
  //-------------------
  // new Raty(document.querySelector('[#post_raty]'));
   // scriptファイルをどのidの部分に配置するかを指定
   
  // let elem = document.querySelector('#post_raty');
  // let opt = {  
  //   //星画像の指定などのオプションをここに記述,
    
    
  // };
  // raty(elem,opt);
  
  
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

