<template>
    <div class="bg" style="background-color: rgba(248,211,173,0.06)">
        <Header></Header>
        <div v-if="!loaded" class="container align-items-center justify-content-center margin4">
            <img src="../../assets/load3.gif"/>
        </div>
        <div v-if="loaded" class="container container-fix">
            <div class="row">
                <div v-if="!noUsersLeft" class="col-sm-7 border base">
                    <div class="row container-fix">
                        <div class="col-sm">
                            <div id="demo" class="carousel slide" data-ride="carousel">
                                <!-- Indicators -->
                                <ol class="carousel-indicators">
                                    <li data-target="#demo" v-for="(img, index) in user.image" data-slide-to="$index"></li>
                                </ol>
                                <!-- The slideshow -->
                                <div class="carousel-inner">
                                    <div class="carousel-item active">
                                        <img class="profileImage" v-bind:src="firstImg" width="100">
                                    </div>
                                    <div class="carousel-item" v-for="img in otherImg">
                                        <img class="profileImage" v-bind:src="'data:image/jpeg;base64,'+ img" width="100">
                                    </div>
                                </div>
                                <!-- Left and right controls -->
                                <a class="carousel-control-prev" href="#demo" data-slide="prev">
                                    <span class="carousel-control-prev-icon"></span>
                                </a>
                                <a class="carousel-control-next" href="#demo" data-slide="next">
                                    <span class="carousel-control-next-icon"></span>
                                </a>
                            </div>
                            
                        </div>
                        <div class="col-sm text-left colStyle3">
                            <div class="row">
                                <span class="span1">{{user.name}} {{user.surname}}, {{user.age}}</span>
                                <div class="w-100"></div>
                                <span class="bold"></span><span>{{user.city}}, {{user.country}}</span>
                            </div>
                            <div class="row margin2">
                                <span v-for="hobby in user.hobbies" class="span2" :key="hobby.id">#{{hobby.name}}</span>
                            </div>
                            <div class="row rowFix1">
                                <span class="bold">Age: </span><span>{{user.birth}}</span>
                            </div>
                            <div class="row margin2">
                                <span  class="bold">BIO</span>
                                <div class="w-100"></div>
                                <span>{{user.bio}}</span>
                            </div>
                            
                        </div>
                    </div>
                    <div class="row margin3">
                        <div class="col rowStyle1">
                            <div class="col"></div>
                            <div class="row">
                                <div class="col">
                                    <a v-on:click="getChoiceDislike">
                                        <font-awesome-icon icon="thumbs-down" class="fa-4x" style="color: rgba(191, 22, 45, 0.96)"/>
                                    </a>
                                </div>
                                <div class="col">
                                    <a v-on:click="getChoiceLike">
                                        <font-awesome-icon icon="thumbs-up" class="fa-4x"/>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div v-else class="col-sm-7 base">
                    NO MORE USERS
                </div>
                <div class="col-sm-1"></div>
                <div class="col-sm-4 colStyle1 base border">
                    <div class="row margin4">
                        <div class="col-sm text-right">
                            <a>
                                <font-awesome-icon icon="filter" class="fa-2x"/>
                            </a>
                        </div>
                    </div>
                    <div class="row rowStyle1">
                        <div class="col-sm">
                            <div class="input-group colored">
                                <div class="input-group-prepend">
                                    <label class="input-group-text colored">GENDER</label>
                                </div>
                                <select class="custom-select" v-model="filter.gender">
                                    <option>MALE</option>
                                    <option>FEMALE</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row rowStyle1">
                        <div class="col-sm">
                            <div class="input-group colored">
                                <div class="input-group-prepend">
                                    <label class="input-group-text colored">COUNTRY</label>
                                </div>
                                <select class="custom-select" v-model="filter.country">
                                    <option v-for="(value, key) in Countries" :key="key">{{key}}</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row rowStyle1">
                        <div class="col-sm">
                            <div class="input-group colored">
                                <div class="input-group-prepend">
                                    <label class="input-group-text colored">CITY</label>
                                </div>
                                    <select class="custom-select" v-model="filter.city">
                                        <option v-for="cities in getCities()" :key="cities" v-on:click="checkCity()">
                                            {{cities}}
                                        </option>
                                    </select>
                            </div>
                        </div>
                    </div>
                    <div class="row rowStyle1">
                        <div class="col-sm">
                            <div class="input-group colored">
                                <div class="input-group-prepend">
                                    <label class="input-group-text colored">HOBBY</label>
                                </div>
                                <select class="custom-select" v-model="filter.hobby">
                                    <option class="disabled" value=""selected>Choose hobby</option>
                                    <option v-for="hobby in allHobbies" :key="hobby">
                                        {{hobby}}
                                    </option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row rowStyle1 margin5">
                        <div class="col-sm">
                            <button v-on:click="getAllUsers" type="button" class="btn btnStyle">GO!</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import BContainer from "bootstrap-vue/src/components/layout/container";
    import Header from "../navigation/Header.vue"
    import {AXIOS} from '../resources/http.config'
    import Hobbies from '../resources/hobbies.json'

    import Countries from '../resources/countries.json'

    export default {
        components: {BContainer, Header},
        name: "browse",
        data() {
            return {
                loaded:true,
                users: [],
                user: {},
                images: [],
                firstImg: {},
                otherImg: [],
                n: 0,
                country: {},
                city: {},
                gender: {},
                matchingPercentage: {},
                noUsersLeft: false,
                filter: {
                    id: null,
                    city: "Beijing",
                    country: "China",
                    gender: "MALE",
                    hobby: ""
                },
                choice: {
                    fromUserId: null,
                    toUserId: {},
                    likeValue: {}
                },
                Countries,
                allHobbies: []
            }
        },
        mounted: function() {
            if (localStorage.getItem('token')) {
                AXIOS.defaults.headers.common['Authorization'] = localStorage.getItem('token');
                this.getClientId();
            }
            this.collectHobbies();

        },
        methods: {
            collectHobbies: function() {
                for(let el in Hobbies['hobbies']){
                    this.allHobbies.push(Hobbies['hobbies'][el])
                }
            },
            getCities: function() {
                let country = this.filter.country;
                return Countries[country]
            },
            checkCity: function() {
                let country = this.filter.country;
                let city = this.filter.city;
                if (!Countries[country].includes(city)) this.filter.city = "";
            },
            getChoiceLike: function() {
                this.choice.toUserId = this.user.username;
                this.choice.likeValue = 1;
                this.sendChoice();
            },
            getChoiceDislike: function() {
                this.choice.toUserId = this.user.username;
                this.choice.likeValue = 0;
                this.sendChoice();
            },
            sendChoice: function () {
                AXIOS.post('/match/update', this.choice);
                this.n++;
                if (this.n === this.users.length){
                    this.noUsersLeft = true;
                }
                else if(this.users.length === 0){
                    this.noUsersLeft = true;
                }
                else {
                    this.noUsersLeft = false;
                    this.getUser();
                }
            },
            setLoaded: function() {
                setTimeout(() => this.loaded= true, 500);
            },
                getAllUsers: function () {
                AXIOS.get('/match/all/?id=' + this.filter.id
                + '&city=' + this.filter.city
                + '&country=' + this.filter.country
                + '&gender=' + this.filter.gender
                + '&hobby=' + this.filter.hobby)
                    .then(response => {
                        this.users = response.data;
                        console.log(response);
                        this.n = 0;
                        if(this.users.length === 0){
                            this.noUsersLeft = true;
                            this.setLoaded();
                        }
                        else{
                            this.noUsersLeft = false;
                            this.getUser();
                        }
                    }).catch(error => {
                        console.log(error);
                })
            },
            getUser: function () {
                this.user = this.users[this.n];
                this.images = this.user.image;
                this.firstImg = this.user.image;
                
            },
            getClientId: function() {
                        this.choice.fromUserId = localStorage.getItem('key');
                        this.filter.id = localStorage.getItem('key');
                        this.getAllUsers();
                   
            },
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
    .base{
        margin-top: 68px;
    }
    .colored {
        background-color: rgba(8,134,229,0.96);
        color: white;
    }

    .container-fix {
        margin-top: 5vh;
    }

    .border {
        background-color: #F4F4F4;
        border-radius: 10px;
        border: #3b2b49;
    }

    .fa-2x {
        color: rgba(8,134,229,0.96)
    }

    .fa-4x {
        color: rgba(27, 175, 31, 0.96)
    }

    .fa-4x2 {
        color: rgba(191, 22, 45, 0.96)
    }

    .rowStyle1 {
        margin-top: 2vh;
    }

    .colStyle1 {
        background-color: #F4F4F4;
        border-radius: 5px;
    }

    .colStyle2 {
        margin: 20px 0;
    }

    .colStyle3 {
        margin: 0 20px;
    }

    .label1 {
        font-weight: bold;
        color: #bd1651
    }

    .span1 {
        font-weight: bold;
        font-size: 2ch
    }

    .span2 {
        background-color: rgba(248,211,173,0.06);
        border-radius: 5px;
    }

    .span3 {
        color: #bd1651;
        font-size: 23px
    }

    .bold {
        font-weight: bold;
    }

    .margin2 {
        margin-top: 3vh;
    }

    .margin3 {
        margin-bottom: 5vh;
    }

    .margin4 {
        margin-top: 5vh;
    }

    .fixed {
        margin-left: 1ch
    }

    .margin5 {
        margin-bottom: 2vh;
    }

    .btnStyle {
        background-color: rgba(8,134,229,0.96);
        color: white;
        border-radius: 5px
    }
</style>
