import Vue from 'vue'
import Router from 'vue-router'
import DatingApp from '@/components/pages/DatingApp'
import Profile from '@/components/pages/Profile'
import Chat from '@/components/pages/Chat'
import Stats from '@/components/pages/Stats'
import Browse from '@/components/pages/Browse'


Vue.use(Router);

const router =  new Router({
    routes: [
        {
            path: '/',
            name: 'DatingApp',
            component: DatingApp
        },
        {
            path: '/profile',
            name: 'Profile',
            component: Profile
        },
        {
            path: '/chat',
            name: 'Chat',
            component: Chat
        },
        {
            path: '/stats',
            name: 'Stats',
            component: Stats
        }, {
            path: '/browse',
            name: 'Browse',
            component: Browse
        }
    ]
});

router.beforeEach((to, from, next) => {
    const publicPages = ['/'];
    
    const authRequired = !publicPages.includes(to.path);
    let token = localStorage.getItem('token');
    if (authRequired && token === null) {
        return next('/');
    }

    next();
});

export default router;
