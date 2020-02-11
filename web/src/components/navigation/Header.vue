<template>
    <nav class="navbar navbar-expand-md navbar-dark fixed-top" style="background-color: #bd1651; color: white; ">
        <a class="navbar-brand" href="#">DatingHub</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="collapsibleNavbar" style="background-color: #bd1651">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <router-link class="nav-link" to="/profile">MY PROFILE</router-link>
                </li>
                <li class="nav-item">
                    <router-link class="nav-link" to="/browse">BROWSE</router-link>
                </li>
                <li class="nav-item">
                    <router-link class="nav-link" to="/chat">CHATS</router-link>
                </li>
                <li class="nav-item">
                    <router-link class="nav-link" to="/stats">STATS</router-link>
                </li>
                <li>
                    <a>
                        <font-awesome-icon icon="sign-out-alt" style="margin-top: 1.7vh; margin-left: 2ch" v-on:click="logOut()"/>
                    </a>
                </li>
            </ul>
        </div>
    </nav>
</template>

<script>
    export default {
        name: "Header",
        methods: {
            logOut: function() {
                this.$store.dispatch('logout')
                    .then(() => {
                        this.$router.push("DatingApp");
                    })
            },
        }
    }
</script>

<style scoped>

</style>