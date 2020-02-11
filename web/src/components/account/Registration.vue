<template>
    <form class="needs-validation" novalidate>
        <div class="form-row">
            <div class="col-md-4 mb-3">
                <label class="bold">Name</label>
                <input type="text" class="form-control" placeholder="Name" v-model="userRegister.name" required>
                <p v-if="loaded" class="text-danger small-text">{{errors['name']}}</p>
            </div>
            <div class="col-md-4 mb-3">
                <label class="bold">Surname</label>
                <input type="text" class="form-control" placeholder="Surname" v-model="userRegister.surname" required>
                <p v-if="loaded" class="text-danger small-text">{{errors['surname']}}</p>
            </div>
            <div class="col-md-4 mb-3">
                <label class="bold">Email</label>
                <input type="email" class="form-control" placeholder="Email" v-model="userRegister.email" required>
                <p v-if="loaded" class="text-danger small-text">{{errors['email']}}</p>
            </div>
        </div>
        <div class="form-row">
            <div class="col-md-4 mb-3">
                <label class="bold">Your birthday</label>
                <input type="date" data-date-format="YYYY-MM-DD" placeholder="yyyy-mm-dd" v-model="userRegister.birth"
                       required>
                <p v-if="loaded" class="text-danger small-text">{{errors['birth']}}</p>
            </div>
            <div class="col-md-4 mb-3">
                <label class="bold">Gender</label>
                <input type="radio" value="FEMALE" v-model="userRegister.gender">Female
                <input type="radio" value="MALE" v-model="userRegister.gender">Male<br>
                <span v-if="loaded" class="text-danger small-text">{{errors['gender']}}</span>
            </div>
        </div>
        <div class="form-row">
            <div class="col-md-4 mb-3">
                <label class="bold">Country</label>
                <select v-model="userRegister.country">
                    <option class="disabled" value="" disabled selected>Select country</option>
                    <option class="selectOption" v-for="(value, key) in Countries" :key="key">{{ key }}</option>
                </select>
                <span v-if="loaded" class="text-danger small-text">{{errors['country']}}</span>
            </div>
            <div class="col-md-4 mb-3">
                <label class="bold">City</label>
                <select v-model="userRegister.city" class="selectOption smallInput">
                    <option class="disabled" value="" disabled selected>Select city</option>
                    <option class="selectOption" v-for="cities in getCities()" :key="cities" v-on:click="checkCity()">{{
                        cities }}
                    </option>
                </select>
                <span v-if="loaded" class="text-danger small-text">{{errors['city']}}</span>
            </div>
        </div>
        <div class="form-row">
            <div class="col-md-4 mb-3">
                <label style="font-weight: bold">Password</label>
                <input type="password" v-model="userRegister.password" placeholder="Your password">
                <span v-if="loaded" class="text-danger small-text">{{errors['password']}}</span>
            </div>
            <div class="col-md-4 mb-3">
                <label style="font-weight: bold">Repeat password</label>
                <input type="password" v-model="userRegister.password2" placeholder="Repeat your password">
            </div>
        </div>
        <span class="text-danger small-text"></span>
        <div class="w-100"></div>
        <button class="btn btn-styles" v-on:click="register">
            Register
        </button>
    </form>
</template>

<script>
    import Countries from '../resources/countries.json'

    export default {
        name: "Registration",
        computed: {
            send: function () {
                return this.error
            }
        },
        data() {
            return {
                loaded: false,
                error: [],
                errors: {},
                user: {},
                userRegister: {
                    name: "",
                    surname: "",
                    email: "",
                    password: "",
                    password2: "",
                    gender: "",
                    city: "",
                    country: "",
                    birth: "",
                },
                userLogIn: {
                    username: "",
                    password: ""
                },
                Countries
            }


        },
        methods: {
            getCities: function () {
                let country = this.userRegister.country;
                return Countries[country]
            },
            checkCity: function () {
                let country = this.userRegister.country;
                let city = this.userRegister.city;
                if (!Countries[country].includes(city)) this.userRegister.city = "";
            },
            register: function () {
                this.$store.dispatch('register', this.userRegister)
                    .then(() => {
                        this.userLogIn.username = this.userRegister.email;
                        this.userLogIn.password = this.userRegister.password;
                        this.enter();

                    }).catch(error => {
                        /*
                        this.loaded = true;
                        //this.error = error.response.data;
                        this.errors = {};

                        for (let e in this.error) {
                            if(this.error[e].defaultMessage.includes('age')) {
                                this.errors['birth'] = this.error[e].defaultMessage;
                            } else if (this.error[e].defaultMessage.includes('Passwords')){
                                this.errors['password'] = this.error[e].defaultMessage;
                            } else {
                                this.errors[this.error[e].field] = this.error[e].defaultMessage;
                            }

                        }
                        */
                });
            },
            enter: function() {
                this.$store.dispatch('login', this.userLogIn)
                    .then(() => {
                        this.$router.push('Profile');
                    })
                    .catch(error => {
                    });
            },
        }
    }
</script>

<style scoped>
    .needs-validation {
        padding: 0 20px 20px 20px;
    }
    .bold {
        font-weight: bold;
    }

    .btn-styles {
        background-color: #bd1651;
        color: white;
        border-radius: 5px
    }

</style>