import 'dart:html';

var page = {
  'main': 'About me',
  'projects': 'Projects',
  'resume': 'Résumé'
};

void routing(String r){
  page.forEach((k, v){
    querySelector('#page-$k').style.display = (r != k)? 'none' : 'block';
    querySelector('#routing-$k').className = (r != k)? '' : 'active';
  });
  window.history.pushState({'title': page[r]}, page[r], '#$r');
  document.title = '${page[r]} :: Bocheng Liao';
}

void main() {
  RegExp exp = RegExp(r"(.*?)#(.*)");
  Match m = exp.firstMatch(window.location.href);
  routing((m == null) ? 'main' : m[2]);

  page.forEach((k,_) {
    querySelector('#routing-$k a').addEventListener('click', (event){
      routing(k);
    });
  });

  window.addEventListener('popstate', (event){

  });
}

