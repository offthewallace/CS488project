// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import store from "./store"
import './../node_modules/jquery/dist/jquery.min.js';
import './../node_modules/bootstrap/dist/css/bootstrap.min.css';
import './../node_modules/bootstrap/dist/js/bootstrap.min.js';
import './../node_modules/bulma/css/bulma.css';
import './../node_modules/foundation-sites/dist/css/foundation.min.css';
import './../node_modules/foundation-sites/dist/js/foundation.min.js';
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import { library } from '@fortawesome/fontawesome-svg-core'
import { faCoffee, faSignOutAlt, faThumbsUp, faThumbsDown, faFilter, faHeart, faUserEdit, faChevronRight, faHandHoldingHeart, faPaperPlane } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import VSelect from 'vue-select'
import 'vue-select/dist/vue-select.css';
import VueChatScroll from 'vue-chat-scroll'

library.add(faCoffee, faSignOutAlt, faThumbsUp, faThumbsDown, faFilter, faHeart, faUserEdit, faChevronRight, faHandHoldingHeart, faPaperPlane);

Vue.component('font-awesome-icon', FontAwesomeIcon);
Vue.use(BootstrapVue);
Vue.use(VueChatScroll)
Vue.component('v-select', VSelect);


Vue.config.productionTip = false;

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>'
});

