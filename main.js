const page = {
  'main': 'About me',
  'projects': 'Projects',
  'resume': 'Résumé',
  'links': 'Links',
};

function routingPage(r, push) {
  const routingLoader = document.querySelector('#routing-loader');
  if (routingLoader) {
    routingLoader.style.display = 'block';
  }
  
  Object.keys(page).forEach((k) => {
    const pageElement = document.querySelector(`#page-${k}`);
    const routingElement = document.querySelector(`#routing-${k}`);
    
    if (pageElement) {
      pageElement.style.display = (r !== k) ? 'none' : 'block';
    }
    
    if (routingElement) {
      routingElement.className = (r !== k) ? '' : 'active';
    }
  });
  
  if (routingLoader) {
    routingLoader.style.display = 'none';
  }
  
  if (push) {
    const title = page[r] ? {'title': page[r]} : {};
    const url = (r === 'main') ? '' : `#${r}`;
    window.history.pushState(title, page[r], url);
  } else {
    const title = page[r] ? {'title': page[r]} : {};
    const url = (r === 'main') ? '' : `#${r}`;
    window.history.replaceState(title, page[r], url);
  }
  
  document.title = `${page[r]} :: Bocheng Liao`;
}

function autoRoute() {
  const exp = /(.*?)#(.*)/;
  const m = exp.exec(window.location.href);
  routingPage(m === null ? 'main' : m[2], false);
}

function main() {
  autoRoute();
  
  Object.keys(page).forEach((k) => {
    const routingElement = document.querySelector(`#routing-${k} a`);
    if (routingElement) {
      routingElement.addEventListener('click', () => {
        routingPage(k, true);
      });
    }
  });
  
  window.addEventListener('popstate', () => {
    autoRoute();
  });
}

main();