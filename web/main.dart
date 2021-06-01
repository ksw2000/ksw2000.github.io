import 'dart:html';

var page = {
  'main': 'About me',
  'projects': 'Projects',
  'resume': 'Résumé'
};

void routingPage(String r, {bool push = true}){
  querySelector('#routing-loader')?.style.display = 'block';
  page.forEach((k, v){
    querySelector('#page-$k')?.style.display = (r != k)? 'none' : 'block';
    querySelector('#routing-$k')?.className = (r != k)? '' : 'active';
  });
  querySelector('#routing-loader')?.style.display = 'none';
  if(push){
    window.history.pushState({'title': page[r]}, page[r] ?? '', (r=='main')?'':'#$r');
  }else{
    window.history.replaceState({'title': page[r]}, page[r] ?? '', (r=='main')?'':'#$r');
  }
  document.title = '${page[r]} :: Bocheng Liao';
}

void autoRoute(){
  var exp = RegExp(r'(.*?)#(.*)');
  Match? m = exp.firstMatch(window.location.href);
  routingPage((m == null) ? 'main' : m[2]!, push: false);
}

void main() {
  autoRoute();
  page.forEach((k,_) {
    querySelector('#routing-$k a')?.addEventListener('click', (event){
      routingPage(k);
    });
  });

  window.addEventListener('popstate', (event){
    autoRoute();
  });
}

