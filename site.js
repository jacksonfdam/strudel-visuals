// Shared chrome: the top nav, plus a HEAD probe that tells the pages which
// demo files actually shipped.
(function () {
  var DEMOS = window.DEMOS || [];

  function el(tag, attrs, kids) {
    var n = document.createElement(tag);
    Object.keys(attrs || {}).forEach(function (k) { n.setAttribute(k, attrs[k]); });
    (kids || []).forEach(function (kid) {
      n.appendChild(typeof kid === 'string' ? document.createTextNode(kid) : kid);
    });
    return n;
  }

  window.demoById = function (id) {
    return DEMOS.filter(function (d) { return d.id === id; })[0] || null;
  };

  // Resolves true when the demo file exists on the server.
  window.demoExists = function (demo) {
    return fetch(demo.file, { method: 'HEAD' })
      .then(function (r) {
        // A static host that rewrites misses to an HTML 404 page still answers
        // 200, so require the status *and* an html-ish type we asked for.
        return r.ok;
      })
      .catch(function () { return false; });
  };

  window.buildNav = function (activeId) {
    var nav = el('nav', { class: 'nav' });

    var brand = el('a', { class: 'nav-brand', href: './' }, [
      el('span', { class: 'dot' }, []),
      'strudel visuals',
    ]);
    nav.appendChild(brand);

    DEMOS.forEach(function (d) {
      var attrs = { class: 'nav-link', href: 'demo.html#' + d.id };
      if (d.id === activeId) attrs['aria-current'] = 'page';
      nav.appendChild(el('a', attrs, [
        el('span', { class: 'num' }, [String(d.n)]),
        d.nav,
      ]));
    });

    nav.appendChild(el('span', { class: 'nav-spacer' }, []));

    if (activeId) {
      var hide = el('button', { class: 'nav-tool', type: 'button', id: 'hide-nav' }, ['hide nav']);
      hide.addEventListener('click', function () {
        document.body.classList.add('nav-hidden');
      });
      nav.appendChild(hide);
    }

    nav.appendChild(el('a', {
      class: 'nav-tool',
      href: 'https://github.com/jacksonfdam/strudel-visuals',
      target: '_blank',
      rel: 'noopener',
    }, ['github']));

    document.body.insertBefore(nav, document.body.firstChild);
    return nav;
  };
})();
