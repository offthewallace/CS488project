<template>
    <div class="bg" style="background-color: rgba(248,211,173,0.06)">
        <div class="row" style="background-color: #751b26">
            <div class="col-sm text-center" style="margin-top: 20px">
                <span style="font-weight: bolder; color: white; font-size: large">Welcome to the DatingHub</span>
            </div>
        </div>
        <div class="container align-items-center justify-content-center text-center">
            <div class="row" style="background-color: #751b26">
                <div class="col-sm" style="margin-top: 5vh">
                    <button v-on:click="logIn = true" style="border: none; outline: none; color: white" ref="logIn">LOG IN</button>
                    <button v-on:click="logIn = false" style="outline: none; border: none; color: white" ref="signUp">SIGN UP</button>
                </div>
            </div><hr>
            <div v-if="logIn" class="row align-items-center justify-content-center text-left">
                <Login></Login>
            </div>
            <div v-if="!logIn" class="row align-items-center justify-content-center text-left">
                <Registration></Registration>
            </div>
        </div>
    </div>
</template>
<script>
    import Registration from '../account/Registration.vue'
    import Login from '../account/Login.vue'

    export default {
        // app initial state
        components: {
            Registration,
            Login
        },
        data() {
            return {
                logIn: true
            }
        },
    }
</script>

<style src="../style/MainStyle.css">
</style>
