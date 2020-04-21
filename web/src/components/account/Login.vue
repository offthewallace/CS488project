<template>
    <form>
        <div class="form-group">
            <label>Email address</label>
            <input v-model="userLogIn.username" type="email" class="form-control" aria-describedby="emailHelp" placeholder="Enter email">
            <small class="form-text text-muted">We'll not share your email with anyone else.</small>
        </div>
        <div class="form-group">
            <label>Password</label>
            <input v-model="userLogIn.password" type="password" class="form-control" placeholder="Password">
        </div>
        <span v-if="errorLogIn" class="text-danger small-text">Check your email and password</span>
        <div class="w-100"></div>
        <button class="btn" v-on:click.prevent="enter">Enter</button>
    </form>
</template>

<script>
    export default {
        name: "Login",
        data() {
            return {
                errorLogIn: true,
                user: {},
                userLogIn: {
                    username: "",
                    password: ""
                },
            }
        },
        methods: {
            enter: function() {
                this.errorLogIn = false;
                this.$store.dispatch('login', this.userLogIn)
                    .then(() => {
                        this.$router.push('Profile');
                    })
                    .catch(error => {
                        this.errorLogIn = true;
                    })
            },
        }
    }
</script>

<style scoped>
    .text-danger .small-text {
        margin-bottom: 1ch
    }

    .btn {
        background-color: #751b26;
        color: white; border-radius: 5px
    }

</style>